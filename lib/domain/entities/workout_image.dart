import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_image.freezed.dart';

@freezed
abstract class WorkoutImage with _$WorkoutImage {
  const factory WorkoutImage({
    required String id,
    /// Path relative to the app's documents directory.
    /// e.g., `workout_images/<uuid>.jpg`
    required String relativePath,
    @Default(true) bool enabled,
  }) = _WorkoutImage;
}
