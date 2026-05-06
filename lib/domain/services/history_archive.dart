import '../entities/workout_history_entry.dart';

/// File-system + share/pick concerns for workout history.
/// The repository handles persistence; this handles the user's
/// file system and share sheet.
abstract class HistoryArchive {
  /// Serialize [entries] to a versioned JSON file in temp storage and
  /// open the system share sheet so the user can save / send it.
  /// Returns true if the share sheet was opened successfully.
  Future<bool> exportAndShare(List<WorkoutHistoryEntry> entries);

  /// Open the system file picker, parse the chosen JSON file, and
  /// return the parsed entries. Returns null when the user cancels.
  /// Throws [HistoryArchiveException] on parse / format errors.
  Future<List<WorkoutHistoryEntry>?> pickAndParse();
}

class HistoryArchiveException implements Exception {
  HistoryArchiveException(this.message);
  final String message;
  @override
  String toString() => 'HistoryArchiveException: $message';
}
