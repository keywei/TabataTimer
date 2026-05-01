// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TabataPreset _$TabataPresetFromJson(Map<String, dynamic> json) =>
    _TabataPreset(
      id: json['id'] as String,
      name: json['name'] as String,
      prepareSeconds: (json['prepareSeconds'] as num?)?.toInt() ?? 10,
      workSeconds: (json['workSeconds'] as num?)?.toInt() ?? 20,
      restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 10,
      rounds: (json['rounds'] as num?)?.toInt() ?? 8,
      sets: (json['sets'] as num?)?.toInt() ?? 1,
      restBetweenSetsSeconds:
          (json['restBetweenSetsSeconds'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$TabataPresetToJson(_TabataPreset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prepareSeconds': instance.prepareSeconds,
      'workSeconds': instance.workSeconds,
      'restSeconds': instance.restSeconds,
      'rounds': instance.rounds,
      'sets': instance.sets,
      'restBetweenSetsSeconds': instance.restBetweenSetsSeconds,
    };
