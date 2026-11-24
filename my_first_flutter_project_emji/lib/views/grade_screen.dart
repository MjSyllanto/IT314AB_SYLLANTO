import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grade.dart';
import '../viewmodels/grade_viewmodel.dart';
import 'widgets/common.dart';

/// Add (grade == null) or edit a grade for an enrollment.
Future<void> showGradeDialog(BuildContext context,
    {required int enrollmentId, Grade? grade}) {
  final formKey = GlobalKey<FormState>();
  final score = TextEditingController(text: grade?.score.toString());
  final remarks = TextEditingController(text: grade?.remarks);

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(grade == null ? 'Add Grade' : 'Edit Grade'),
      content: Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: score,
            decoration: const InputDecoration(labelText: 'Score (0 - 100)'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              final n = double.tryParse((v ?? '').trim());
              if (n == null) return 'Enter a number';
              if (n < 0 || n > 100) return 'Must be between 0 and 100';
              return null;
            },
          ),
          TextFormField(
            controller: remarks,
            decoration: const InputDecoration(labelText: 'Remarks (optional)'),
            maxLength: 50,
          ),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            final value = double.parse(score.text.trim());
            final note = remarks.text.trim().isEmpty
                ? (value >= 75 ? 'Passed' : 'Failed')
                : remarks.text.trim();
            final err = await context.read<GradeViewModel>().save(Grade(
                  id: grade?.id,
                  enrollmentId: enrollmentId,
                  score: value,
                  remarks: note,
                ));
            if (!ctx.mounted) return;
            Navigator.pop(ctx);
            if (!context.mounted) return;
            showMsg(context, err ?? 'Grade saved', error: err != null);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
