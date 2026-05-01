import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/tabata_preset.dart';

part 'tabata_preset_dto.freezed.dart';
part 'tabata_preset_dto.g.dart';

@freezed
abstract class TabataPresetDto with _$TabataPresetDto {
  const factory TabataPresetDto({
    required String id,
    required String name,
    @Default(10) int prepareSeconds,
    @Default(20) int workSeconds,
    @Default(10) int restSeconds,
    @Default(8) int rounds,
    @Default(1) int sets,
    @Default(60) int restBetweenSetsSeconds,
  }) = _TabataPresetDto;

  factory TabataPresetDto.fromJson(Map<String, dynamic> json) =>
      _$TabataPresetDtoFromJson(json);
}

extension TabataPresetDtoX on TabataPresetDto {
  TabataPreset toEntity() => TabataPreset(
        id: id,
        name: name,
        prepareSeconds: prepareSeconds,
        workSeconds: workSeconds,
        restSeconds: restSeconds,
        rounds: rounds,
        sets: sets,
        restBetweenSetsSeconds: restBetweenSetsSeconds,
      );
}

extension TabataPresetMapper on TabataPreset {
  TabataPresetDto toDto() => TabataPresetDto(
        id: id,
        name: name,
        prepareSeconds: prepareSeconds,
        workSeconds: workSeconds,
        restSeconds: restSeconds,
        rounds: rounds,
        sets: sets,
        restBetweenSetsSeconds: restBetweenSetsSeconds,
      );
}
