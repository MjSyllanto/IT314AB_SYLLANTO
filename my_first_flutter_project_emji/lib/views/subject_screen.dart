import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subject.dart';
import '../viewmodels/schedule_viewmodel.dart';
import '../viewmodels/subject_viewmodel.dart';
import 'schedule_screen.dart';
import 'widgets/common.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SubjectViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: stateBody(
        isLoading: vm.isLoading,
        error: vm.errorMessage,
        isEmpty: vm.subjects.isEmpty,
        emptyText: 'No subjects yet. Tap + to add one.',
        onRetry: vm.load,
        data: () => RefreshIndicator(
          onRefresh: vm.load,
          child: ListView.builder(
            itemCount: vm.subjects.length,
            itemBuilder: (ctx, i) {
              final s = vm.subjects[i];
              return ListTile(
                title: Text('${s.code} - ${s.name}'),
                subtitle: Text('${s.units} unit(s)'),
                onTap: () => Navigator.push(
                    ctx, MaterialPageRoute(builder: (_) => SubjectDetailsScreen(subject: s))),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'edit') {
                      Navigator.push(ctx,
                          MaterialPageRoute(builder: (_) => SubjectFormScreen(subject: s)));
                    } else if (v == 'delete') {
                      if (!await confirm(ctx, 'Delete ${s.code}?')) return;
                      if (!ctx.mounted) return;
                      final err = await ctx.read<SubjectViewModel>().remove(s.id!);
                      if (!ctx.mounted) return;
                      showMsg(ctx, err ?? 'Subject deleted', error: err != null);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SubjectFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Subject details + its schedules (Schedule READ / UPDATE / DELETE).
class SubjectDetailsScreen extends StatefulWidget {
  final Subject subject;
  const SubjectDetailsScreen({super.key, required this.subject});
  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<ScheduleViewModel>().loadForSubject(widget.subject.id!));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleViewModel>();
    final s = widget.subject;
    return Scaffold(
      appBar: AppBar(title: Text(s.code)),
      body: Column(children: [
        ListTile(
          title: Text(s.name),
          subtitle: Text('${s.units} unit(s)\n${s.description ?? ''}'),
          isThreeLine: true,
        ),
        const Divider(),
        Expanded(
          child: stateBody(
            isLoading: vm.isLoading,
            error: vm.errorMessage,
            isEmpty: vm.schedules.isEmpty,
            emptyText: 'No schedules yet. Tap + to add one.',
            onRetry: vm.reload,
            data: () => ListView.builder(
              itemCount: vm.schedules.length,
              itemBuilder: (ctx, i) {
                final sc = vm.schedules[i];
                return ListTile(
                  title: Text('${sc.day}  ${sc.timeLabel}'),
                  subtitle: Text(
                      'Room ${sc.room}  •  ${sc.remaining}/${sc.capacity} slot(s) left'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                          ctx,
                          MaterialPageRoute(
                              builder: (_) => ScheduleFormScreen(subject: s, schedule: sc))),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        if (!await confirm(ctx, 'Delete this schedule?')) return;
                        if (!ctx.mounted) return;
                        final err = await ctx.read<ScheduleViewModel>().remove(sc.id!);
                        if (!ctx.mounted) return;
                        showMsg(ctx, err ?? 'Schedule deleted', error: err != null);
                      },
                    ),
                  ]),
                );
              },
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ScheduleFormScreen(subject: s))),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SubjectFormScreen extends StatefulWidget {
  final Subject? subject;
  const SubjectFormScreen({super.key, this.subject});
  @override
  State<SubjectFormScreen> createState() => _SubjectFormScreenState();
}

class _SubjectFormScreenState extends State<SubjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _code = TextEditingController(text: widget.subject?.code);
  late final _name = TextEditingController(text: widget.subject?.name);
  late final _desc = TextEditingController(text: widget.subject?.description);
  late int _units = widget.subject?.units ?? 3;
  bool _saving = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final err = await context.read<SubjectViewModel>().save(Subject(
          id: widget.subject?.id,
          code: _code.text.trim(),
          name: _name.text.trim(),
          units: _units,
          description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
        ));
    if (!mounted) return;
    setState(() => _saving = false);
    if (err == null) {
      showMsg(context, widget.subject == null ? 'Subject added' : 'Subject updated');
      Navigator.pop(context);
    } else {
      showMsg(context, err, error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subject == null ? 'New Subject' : 'Edit Subject')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _code,
              decoration: const InputDecoration(labelText: 'Subject Code *'),
              maxLength: 20,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Subject Name *'),
              maxLength: 100,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            DropdownButtonFormField<int>(
              value: _units,
              decoration: const InputDecoration(labelText: 'Units'),
              items: [for (var u = 1; u <= 6; u++) DropdownMenuItem(value: u, child: Text('$u'))],
              onChanged: (v) => setState(() => _units = v ?? 3),
            ),
            TextFormField(
              controller: _desc,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
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
