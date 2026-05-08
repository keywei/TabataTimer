import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../l10n/app_localizations.dart';

/// Asks the user to type the saved password and verifies it.
/// Returns true on a correct password, false on cancel.
/// If no password is set, returns true immediately without prompting.
Future<bool> ensurePasswordOrAsk(
    BuildContext context, WidgetRef ref) async {
  final controller = ref.read(settingsControllerProvider.notifier);
  if (!controller.isPasswordSet) return true;

  final t = AppLocalizations.of(context);
  final input = TextEditingController();
  String? errorText;

  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(t.passwordPromptTitle),
          content: TextField(
            controller: input,
            autofocus: true,
            obscureText: true,
            decoration: InputDecoration(
              labelText: t.settingsPasswordSection,
              errorText: errorText,
            ),
            onSubmitted: (_) {
              if (controller.verifyPassword(input.text)) {
                Navigator.pop(ctx, true);
              } else {
                setState(() => errorText = t.passwordIncorrect);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.actionCancel),
            ),
            FilledButton(
              onPressed: () {
                if (controller.verifyPassword(input.text)) {
                  Navigator.pop(ctx, true);
                } else {
                  setState(() => errorText = t.passwordIncorrect);
                }
              },
              child: Text(t.actionContinue),
            ),
          ],
        ),
      );
    },
  );
  input.dispose();
  return ok ?? false;
}
