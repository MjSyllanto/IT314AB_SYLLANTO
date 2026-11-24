import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';
import '../viewmodels/student_viewmodel.dart';
import 'widgets/common.dart';

/// Full-screen wrapper used for CREATE.
class StudentFormScreen extends StatelessWidget {
  const StudentFormScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('New Student')),
        body: const SingleChildScrollView(child: StudentForm()),
      );
}

/// Used for EDIT inside a modal bottom sheet.
void showEditStudentModal(BuildContext context, Student s) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: SingleChildScrollView(child: StudentForm(student: s)),
    ),
  );
}

class StudentForm extends StatefulWidget {
  final Student? student;
  const StudentForm({super.key, this.student});
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late final _number = TextEditingController(text: widget.student?.studentNumber);
  late final _name = TextEditingController(text: widget.student?.name);
  late final _email = TextEditingController(text: widget.student?.email);
  late final _contact = TextEditingController(text: widget.student?.contactNumber);
  int? _programId;
  int? _year;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _programId = widget.student?.programId;
    _year = widget.student?.yearLevel;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final student = Student(
      id: widget.student?.id,
      studentNumber: _number.text.trim(),
      name: _name.text.trim(),
      email: _email.text.trim(),
      programId: _programId,
      yearLevel: _year,
      contactNumber: _contact.text.trim().isEmpty ? null : _contact.text.trim(),
    );
    final err = await context.read<StudentViewModel>().save(student);
    if (!mounted) return;
    setState(() => _saving = false);
    if (err == null) {
      showMsg(context, widget.student == null ? 'Student added' : 'Student updated');
      Navigator.pop(context);
    } else {
      showMsg(context, err, error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final programs = context.watch<StudentViewModel>().programs;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(widget.student == null ? 'Add Student' : 'Edit Student',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(
            controller: _number,
            decoration: const InputDecoration(labelText: 'Student Number *'),
            maxLength: 20,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Full Name *'),
            maxLength: 100,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email *'),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())
                  ? null
                  : 'Enter a valid email';
            },
          ),
          DropdownButtonFormField<int>(
            value: _programId,
            decoration: const InputDecoration(labelText: 'Program'),
            items: [
              for (final p in programs) DropdownMenuItem(value: p.id, child: Text(p.code)),
            ],
            onChanged: (v) => setState(() => _programId = v),
          ),
          DropdownButtonFormField<int>(
            value: _year,
            decoration: const InputDecoration(labelText: 'Year Level'),
            items: [
              for (var y = 1; y <= 6; y++) DropdownMenuItem(value: y, child: Text('Year $y')),
            ],
            onChanged: (v) => setState(() => _year = v),
          ),
          TextFormField(
            controller: _contact,
            decoration: const InputDecoration(labelText: 'Contact Number'),
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return null;
              return RegExp(r'^[0-9+\-\s]{7,20}$').hasMatch(v.trim())
                  ? null
                  : 'Enter a valid phone number';
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox(
                      height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save'),
            ),
          ),
        ]),
      ),
    );
  }
}
