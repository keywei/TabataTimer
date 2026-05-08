abstract class WorkoutNotifier {
  /// Ask the OS for permission to post notifications. iOS prompts the
  /// system alert; Android 13+ shows the runtime permission dialog;
  /// older Android grants implicitly. Returns whether permission is now
  /// granted (or true on platforms that don't gate on permission).
  Future<bool> requestPermission();

  Future<void> showCompleted({required String title, required String body});

  /// Show / update a persistent "workout in progress" notification on
  /// Android (foreground-style, ongoing, no sound). On iOS this is a
  /// no-op until Live Activity support is added.
  Future<void> showOngoing({required String title, required String body});

  /// Dismiss the ongoing notification (no-op if none).
  Future<void> cancelOngoing();
}
