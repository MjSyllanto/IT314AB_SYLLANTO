import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/enrollment.dart';
import '../models/schedule.dart';
import '../models/student.dart';
import '../viewmodels/enrollment_viewmodel.dart';
import '../viewmodels/schedule_viewmodel.dart';
import 'widgets/common.dart';

/// Pick a subject schedule to ENROLL the student, or (if [changing] is set)
/// pick a new schedule for an existing enrollment.
class EnrollScreen extends StatelessWidget {
  final Student student;
  final Enrollment? changing;
  const EnrollScreen({super.key, required this.student, this.changing});

  Future<void> _pick(BuildContext context, ScheduleViewModel svm, Schedule s) async {
    final isChange = changing != null;
    final ok = await confirm(
      context,
      '${isChange ? 'Change to' : 'Enroll ${student.name} in'} ${s.subjectCode} '
      '(${s.day} ${s.timeLabel}, Room ${s.room})?',
      yes: isChange ? 'Change' : 'Enroll',
    );
    if (!ok || !context.mounted) return;
    final evm = context.read<EnrollmentViewModel>();
    final err = isChange
        ? await evm.changeSchedule(changing!, s.id!)
        : await evm.enroll(student.id!, s.id!);
    if (!context.mounted) return;
    if (err == null) {
      showMsg(context, isChange ? 'Schedule changed' : 'Enrollment successful!');
      Navigator.pop(context);
    } else {
      showMsg(context, err, error: true);
      svm.reload(); // refresh slot counts
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = ScheduleViewModel();
        changing == null ? vm.loadAll() : vm.loadForSubject(changing!.subjectId);
        return vm;
      },
      child: Consumer<ScheduleViewModel>(
        builder: (ctx, svm, _) => Scaffold(
          appBar: AppBar(
              title: Text(changing == null ? 'Enroll: ${student.name}' : 'Change Schedule')),
          body: stateBody(
            isLoading: svm.isLoading,
            error: svm.errorMessage,
            isEmpty: svm.schedules.isEmpty,
            emptyText: 'No schedules available.',
            onRetry: svm.reload,
            data: () => ListView.builder(
              itemCount: svm.schedules.length,
              itemBuilder: (_, i) {
                final s = svm.schedules[i];
                final full = (s.remaining ?? 0) <= 0;
                final current = changing?.scheduleId == s.id;
                return ListTile(
                  enabled: !full && !current,
                  title: Text('${s.subjectCode} - ${s.subjectName}'),
                  subtitle: Text('${s.day} ${s.timeLabel}  •  Room ${s.room}\n'
                      '${current ? 'Current schedule' : full ? 'FULL' : '${s.remaining} slot(s) left'}'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _pick(ctx, svm, s),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
