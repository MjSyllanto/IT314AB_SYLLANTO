import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/enrollment.dart';
import '../models/grade.dart';
import '../viewmodels/enrollment_viewmodel.dart';
import '../viewmodels/grade_viewmodel.dart';
import '../viewmodels/student_viewmodel.dart';
import 'enrollment_screen.dart';
import 'grade_screen.dart';
import 'student_form_screen.dart';
import 'widgets/common.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudentViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: stateBody(
        isLoading: vm.isLoading,
        error: vm.errorMessage,
        isEmpty: vm.students.isEmpty,
        emptyText: 'No students yet. Tap + to add one.',
        onRetry: vm.load,
        data: () => RefreshIndicator(
          onRefresh: vm.load,
          child: ListView.builder(
            itemCount: vm.students.length,
            itemBuilder: (ctx, i) {
              final s = vm.students[i];
              return ListTile(
                leading: CircleAvatar(
                    child: Text(s.name.isNotEmpty ? s.name[0].toUpperCase() : '?')),
                title: Text(s.name),
                subtitle: Text('${s.studentNumber}  •  ${s.programCode ?? 'No program'}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  ctx,
                  MaterialPageRoute(builder: (_) => StudentDetailsScreen(studentId: s.id!)),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const StudentFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StudentDetailsScreen extends StatefulWidget {
  final int studentId;
  const StudentDetailsScreen({super.key, required this.studentId});
  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EnrollmentViewModel>().loadForStudent(widget.studentId);
      context.read<GradeViewModel>().loadForStudent(widget.studentId);
    });
  }

  Future<void> _delete() async {
    if (!await confirm(context, 'Delete this student?')) return;
    if (!mounted) return;
    final err = await context.read<StudentViewModel>().remove(widget.studentId);
    if (!mounted) return;
    if (err == null) {
      showMsg(context, 'Student deleted');
      Navigator.pop(context);
    } else {
      showMsg(context, err, error: true);
    }
  }

  Future<void> _drop(Enrollment e) async {
    if (!await confirm(context, 'Drop ${e.subjectCode}?', yes: 'Drop')) return;
    if (!mounted) return;
    final err = await context.read<EnrollmentViewModel>().drop(e);
    if (!mounted) return;
    showMsg(context, err ?? 'Subject dropped', error: err != null);
  }

  Future<void> _deleteGrade(Grade g) async {
    if (!await confirm(context, 'Delete grade for ${g.subjectCode}?')) return;
    if (!mounted) return;
    final err = await context.read<GradeViewModel>().remove(g.id!);
    if (!mounted) return;
    showMsg(context, err ?? 'Grade deleted', error: err != null);
  }

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentViewModel>().byId(widget.studentId);
    final evm = context.watch<EnrollmentViewModel>();
    final gvm = context.watch<GradeViewModel>();

    if (student == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit), onPressed: () => showEditStudentModal(context, student)),
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Student No: ${student.studentNumber}'),
                Text('Email: ${student.email}'),
                Text('Program: ${student.programCode ?? '-'}'),
                Text('Year Level: ${student.yearLevel ?? '-'}'),
                Text('Contact: ${student.contactNumber ?? '-'}'),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text('Enrollments', style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Enroll'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EnrollScreen(student: student))),
            ),
          ]),
          if (evm.isLoading)
            const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()))
          else if (evm.errorMessage != null)
            Padding(padding: const EdgeInsets.all(16), child: Text(evm.errorMessage!))
          else if (evm.items.isEmpty)
            const Padding(padding: EdgeInsets.all(16), child: Text('No enrollments yet.'))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: evm.items.length,
              itemBuilder: (ctx, i) {
                final e = evm.items[i];
                final grade = gvm.gradeFor(e.id);
                return Card(
                  child: ListTile(
                    title: Text('${e.subjectCode} - ${e.subjectName}'),
                    subtitle: Text('${e.day} ${e.timeLabel}  •  Room ${e.room}\n'
                        'Status: ${e.status}'
                        '${grade != null ? '  •  Grade: ${grade.score}' : ''}'),
                    isThreeLine: true,
                    trailing: e.isEnrolled
                        ? PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'change') {
                                Navigator.push(
                                    ctx,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EnrollScreen(student: student, changing: e)));
                              } else if (v == 'drop') {
                                _drop(e);
                              } else if (v == 'grade') {
                                showGradeDialog(ctx, enrollmentId: e.id, grade: grade);
                              }
                            },
                            itemBuilder: (_) => [
                              const PopupMenuItem(value: 'change', child: Text('Change schedule')),
                              PopupMenuItem(
                                  value: 'grade',
                                  child: Text(grade == null ? 'Add grade' : 'Edit grade')),
                              const PopupMenuItem(value: 'drop', child: Text('Drop subject')),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
          const SizedBox(height: 16),
          Text('Grades', style: Theme.of(context).textTheme.titleMedium),
          if (gvm.grades.isEmpty)
            const Padding(padding: EdgeInsets.all(16), child: Text('No grades recorded.'))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gvm.grades.length,
              itemBuilder: (ctx, i) {
                final g = gvm.grades[i];
                return Card(
                  child: ListTile(
                    title: Text('${g.subjectCode} - ${g.subjectName}'),
                    subtitle: Text('Score: ${g.score}  •  ${g.remarks ?? ''}\nRecorded: ${g.dateRecorded ?? '-'}'),
                    isThreeLine: true,
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              showGradeDialog(ctx, enrollmentId: g.enrollmentId, grade: g)),
                      IconButton(icon: const Icon(Icons.delete), onPressed: () => _deleteGrade(g)),
                    ]),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
