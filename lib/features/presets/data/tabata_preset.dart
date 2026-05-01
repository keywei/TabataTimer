import 'package:freezed_annotation/freezed_annotation.dart';

part 'tabata_preset.freezed.dart';
part 'tabata_preset.g.dart';

@freezed
abstract class TabataPreset with _$TabataPreset {
  const factory TabataPreset({
    required String id,
    required String name,
    @Default(10) int prepareSeconds,
    @Default(20) int workSeconds,
    @Default(10) int restSeconds,
    @Default(8) int rounds,
    @Default(1) int sets,
    @Default(60) int restBetweenSetsSeconds,
  }) = _TabataPreset;

  factory TabataPreset.fromJson(Map<String, dynamic> json) =>
      _$TabataPresetFromJson(json);
}

extension TabataPresetX on TabataPreset {
  int get totalSeconds {
    final perSet = workSeconds * rounds + restSeconds * (rounds - 1);
    final allSets = perSet * sets + restBetweenSetsSeconds * (sets - 1);
    return prepareSeconds + allSets;
  }
}
