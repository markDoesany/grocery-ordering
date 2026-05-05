import 'package:flutter/material.dart';

void showMockSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(message)));
}

Future<void> showMockActionSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
}) {
  final rootContext = context;
  final cs = Theme.of(context).colorScheme;
  final tt = Theme.of(context).textTheme;

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: cs.surface,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title.toUpperCase(),
                style: tt.headlineSmall?.copyWith(color: cs.primary),
              ),
              const SizedBox(height: 12),
              for (final option in options)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showMockSnack(rootContext, '$option selected');
                    },
                    child: Text(option.toUpperCase()),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
