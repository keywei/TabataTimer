// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata_preset_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TabataPresetDto _$TabataPresetDtoFromJson(Map<String, dynamic> json) =>
    _TabataPresetDto(
      id: json['id'] as String,
      name: json['name'] as String,
      prepareSeconds: (json['prepareSeconds'] as num?)?.toInt() ?? 10,
      workSeconds: (json['workSeconds'] as num?)?.toInt() ?? 20,
      restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 10,
      rounds: (json['rounds'] as num?)?.toInt() ?? 8,
      sets: (json['sets'] as num?)?.toInt() ?? 1,
      restBetweenSetsSeconds:
          (json['restBetweenSetsSeconds'] as num?)?.toInt() ?? 60,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => WorkoutImageDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WorkoutImageDto>[],
      slideshowMode:
          $enumDecodeNullable(_$SlideshowModeEnumMap, json['slideshowMode']) ??
          SlideshowMode.off,
      slideshowIntervalSeconds:
          (json['slideshowIntervalSeconds'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$TabataPresetDtoToJson(_TabataPresetDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prepareSeconds': instance.prepareSeconds,
      'workSeconds': instance.workSeconds,
      'restSeconds': instance.restSeconds,
      'rounds': instance.rounds,
      'sets': instance.sets,
      'restBetweenSetsSeconds': instance.restBetweenSetsSeconds,
      'images': instance.images,
      'slideshowMode': _$SlideshowModeEnumMap[instance.slideshowMode]!,
      'slideshowIntervalSeconds': instance.slideshowIntervalSeconds,
    };

const _$SlideshowModeEnumMap = {
  SlideshowMode.off: 'off',
  SlideshowMode.sequential: 'sequential',
  SlideshowMode.random: 'random',
};
