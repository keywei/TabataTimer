// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutImageDto _$WorkoutImageDtoFromJson(Map<String, dynamic> json) =>
    _WorkoutImageDto(
      id: json['id'] as String,
      relativePath: json['relativePath'] as String,
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$WorkoutImageDtoToJson(_WorkoutImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relativePath': instance.relativePath,
      'enabled': instance.enabled,
    };
