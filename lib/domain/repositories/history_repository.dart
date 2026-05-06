import '../entities/workout_history_entry.dart';

abstract class HistoryRepository {
  Future<List<WorkoutHistoryEntry>> loadAll();
  Future<void> add(WorkoutHistoryEntry entry);
  Future<void> deleteOne(String id);
  Future<void> clearAll();

  /// Replace the entire stored set in one shot. Used by import flows
  /// where we want bulk insert without per-entry trimming.
  Future<void> replaceAll(List<WorkoutHistoryEntry> entries);
}
