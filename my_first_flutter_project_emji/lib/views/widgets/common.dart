import 'package:flutter/material.dart';

void showMsg(BuildContext context, String text, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: error ? Colors.red.shade700 : Colors.green.shade700,
    ));
}

Future<bool> confirm(BuildContext context, String message, {String yes = 'Delete'}) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(yes)),
      ],
    ),
  );
  return r ?? false;
}

/// Loading / error / empty / data states in one place (Conditional Widgets).
Widget stateBody({
  required bool isLoading,
  required String? error,
  required bool isEmpty,
  required String emptyText,
  required VoidCallback onRetry,
  required Widget Function() data,
}) {
  if (isLoading) return const Center(child: CircularProgressIndicator());
  if (error != null) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(error, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
  if (isEmpty) return Center(child: Text(emptyText));
  return data();
}
