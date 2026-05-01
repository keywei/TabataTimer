// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_history_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutHistoryEntryDto _$WorkoutHistoryEntryDtoFromJson(
  Map<String, dynamic> json,
) => _WorkoutHistoryEntryDto(
  id: json['id'] as String,
  presetName: json['presetName'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  completedAt: DateTime.parse(json['completedAt'] as String),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  totalRounds: (json['totalRounds'] as num).toInt(),
  totalSets: (json['totalSets'] as num).toInt(),
  completed: json['completed'] as bool? ?? true,
);

Map<String, dynamic> _$WorkoutHistoryEntryDtoToJson(
  _WorkoutHistoryEntryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'presetName': instance.presetName,
  'startedAt': instance.startedAt.toIso8601String(),
  'completedAt': instance.completedAt.toIso8601String(),
  'durationSeconds': instance.durationSeconds,
  'totalRounds': instance.totalRounds,
  'totalSets': instance.totalSets,
  'completed': instance.completed,
};
