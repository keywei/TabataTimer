import '../entities/workout_history_entry.dart';

abstract class HistoryRepository {
  Future<List<WorkoutHistoryEntry>> loadAll();
  Future<void> add(WorkoutHistoryEntry entry);
  Future<void> deleteOne(String id);
  Future<void> clearAll();
}
