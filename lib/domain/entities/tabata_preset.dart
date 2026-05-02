import 'package:freezed_annotation/freezed_annotation.dart';

import 'slideshow_mode.dart';
import 'workout_image.dart';

part 'tabata_preset.freezed.dart';

@freezed
abstract class TabataPreset with _$TabataPreset {
  const TabataPreset._();

  const factory TabataPreset({
    required String id,
    required String name,
    @Default(10) int prepareSeconds,
    @Default(20) int workSeconds,
    @Default(10) int restSeconds,
    @Default(8) int rounds,
    @Default(1) int sets,
    @Default(60) int restBetweenSetsSeconds,
    @Default(<WorkoutImage>[]) List<WorkoutImage> images,
    @Default(SlideshowMode.off) SlideshowMode slideshowMode,
    @Default(5) int slideshowIntervalSeconds,
  }) = _TabataPreset;

  int get totalSeconds {
    final perSet = workSeconds * rounds + restSeconds * (rounds - 1);
    final allSets = perSet * sets + restBetweenSetsSeconds * (sets - 1);
    return prepareSeconds + allSets;
  }

  Iterable<WorkoutImage> get enabledImages => images.where((i) => i.enabled);
}
