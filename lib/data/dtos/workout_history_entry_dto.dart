import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_history_entry.dart';

part 'workout_history_entry_dto.freezed.dart';
part 'workout_history_entry_dto.g.dart';

@freezed
abstract class WorkoutHistoryEntryDto with _$WorkoutHistoryEntryDto {
  const factory WorkoutHistoryEntryDto({
    required String id,
    required String presetName,
    required DateTime startedAt,
    required DateTime completedAt,
    required int durationSeconds,
    required int totalRounds,
    required int totalSets,
    @Default(true) bool completed,
  }) = _WorkoutHistoryEntryDto;

  factory WorkoutHistoryEntryDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutHistoryEntryDtoFromJson(json);
}

extension WorkoutHistoryEntryDtoX on WorkoutHistoryEntryDto {
  WorkoutHistoryEntry toEntity() => WorkoutHistoryEntry(
        id: id,
        presetName: presetName,
        startedAt: startedAt,
        completedAt: completedAt,
        durationSeconds: durationSeconds,
        totalRounds: totalRounds,
        totalSets: totalSets,
        completed: completed,
      );
}

extension WorkoutHistoryEntryMapper on WorkoutHistoryEntry {
  WorkoutHistoryEntryDto toDto() => WorkoutHistoryEntryDto(
        id: id,
        presetName: presetName,
        startedAt: startedAt,
        completedAt: completedAt,
        durationSeconds: durationSeconds,
        totalRounds: totalRounds,
        totalSets: totalSets,
        completed: completed,
      );
}
