// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutHistoryEntry _$WorkoutHistoryEntryFromJson(Map<String, dynamic> json) =>
    _WorkoutHistoryEntry(
      id: json['id'] as String,
      presetName: json['presetName'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: DateTime.parse(json['completedAt'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      totalRounds: (json['totalRounds'] as num).toInt(),
      totalSets: (json['totalSets'] as num).toInt(),
      completed: json['completed'] as bool? ?? true,
    );

Map<String, dynamic> _$WorkoutHistoryEntryToJson(
  _WorkoutHistoryEntry instance,
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
