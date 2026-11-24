import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/schedule.dart';
import '../models/subject.dart';
import '../viewmodels/schedule_viewmodel.dart';
import 'widgets/common.dart';

class ScheduleFormScreen extends StatefulWidget {
  final Subject subject;
  final Schedule? schedule;
  const ScheduleFormScreen({super.key, required this.subject, this.schedule});
  @override
  State<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends State<ScheduleFormScreen> {
  static const _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final _formKey = GlobalKey<FormState>();
  late String _day = widget.schedule?.day ?? 'Monday';
  late final _start = TextEditingController(text: widget.schedule?.startTime.substring(0, 5));
  late final _end = TextEditingController(text: widget.schedule?.endTime.substring(0, 5));
  late final _room = TextEditingController(text: widget.schedule?.room);
  late final _cap = TextEditingController(text: widget.schedule?.capacity.toString());
  bool _saving = false;

  Future<void> _pickTime(TextEditingController c) async {
    final parts = c.text.split(':');
    final initial = parts.length == 2
        ? TimeOfDay(hour: int.tryParse(parts[0]) ?? 8, minute: int.tryParse(parts[1]) ?? 0)
        : const TimeOfDay(hour: 8, minute: 0);
    final t = await showTimePicker(context: context, initialTime: initial);
    if (t != null) {
      c.text = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final err = await context.read<ScheduleViewModel>().save(Schedule(
          id: widget.schedule?.id,
          subjectId: widget.subject.id!,
          day: _day,
          startTime: _start.text,
          endTime: _end.text,
          room: _room.text.trim(),
          capacity: int.parse(_cap.text.trim()),
        ));
    if (!mounted) return;
    setState(() => _saving = false);
    if (err == null) {
      showMsg(context, widget.schedule == null ? 'Schedule added' : 'Schedule updated');
      Navigator.pop(context);
    } else {
      showMsg(context, err, error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.schedule == null
              ? 'New Schedule - ${widget.subject.code}'
              : 'Edit Schedule - ${widget.subject.code}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            DropdownButtonFormField<String>(
              value: _day,
              decoration: const InputDecoration(labelText: 'Day'),
              items: [for (final d in _days) DropdownMenuItem(value: d, child: Text(d))],
              onChanged: (v) => setState(() => _day = v ?? 'Monday'),
            ),
            TextFormField(
              controller: _start,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Start Time *', suffixIcon: Icon(Icons.access_time)),
              onTap: () => _pickTime(_start),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _end,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'End Time *', suffixIcon: Icon(Icons.access_time)),
              onTap: () => _pickTime(_end),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (_start.text.isNotEmpty && v.compareTo(_start.text) <= 0) {
                  return 'End time must be after start time';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _room,
              decoration: const InputDecoration(labelText: 'Room *'),
              maxLength: 30,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _cap,
              decoration: const InputDecoration(labelText: 'Slot Capacity *'),
              keyboardType: TextInputType.number,
              validator: (v) {
                final n = int.tryParse((v ?? '').trim());
                return (n == null || n <= 0) ? 'Enter a number greater than 0' : null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _saving ? null : _submit, child: const Text('Save')),
            ),
          ]),
        ),
      ),
    );
  }
}
