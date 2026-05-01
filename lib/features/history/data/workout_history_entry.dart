import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_history_entry.freezed.dart';
part 'workout_history_entry.g.dart';

@freezed
abstract class WorkoutHistoryEntry with _$WorkoutHistoryEntry {
  const factory WorkoutHistoryEntry({
    required String id,
    required String presetName,
    required DateTime startedAt,
    required DateTime completedAt,
    required int durationSeconds,
    required int totalRounds,
    required int totalSets,
    @Default(true) bool completed,
  }) = _WorkoutHistoryEntry;

  factory WorkoutHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$WorkoutHistoryEntryFromJson(json);
}
