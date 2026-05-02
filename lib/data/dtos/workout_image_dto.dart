import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_image.dart';

part 'workout_image_dto.freezed.dart';
part 'workout_image_dto.g.dart';

@freezed
abstract class WorkoutImageDto with _$WorkoutImageDto {
  const factory WorkoutImageDto({
    required String id,
    required String relativePath,
    @Default(true) bool enabled,
  }) = _WorkoutImageDto;

  factory WorkoutImageDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutImageDtoFromJson(json);
}

extension WorkoutImageDtoX on WorkoutImageDto {
  WorkoutImage toEntity() =>
      WorkoutImage(id: id, relativePath: relativePath, enabled: enabled);
}

extension WorkoutImageMapper on WorkoutImage {
  WorkoutImageDto toDto() =>
      WorkoutImageDto(id: id, relativePath: relativePath, enabled: enabled);
}
