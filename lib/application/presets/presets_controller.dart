import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/tabata_preset.dart';
import '../../domain/repositories/preset_repository.dart';

class PresetsController extends AsyncNotifier<List<TabataPreset>> {
  late PresetRepository _repository;

  @override
  Future<List<TabataPreset>> build() async {
    _repository = await ref.watch(presetRepositoryProvider.future);
    return _repository.loadAll();
  }

  Future<TabataPreset> upsert(TabataPreset preset) async {
    final saved = await _repository.upsert(preset);
    ref.invalidateSelf();
    return saved;
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    ref.invalidateSelf();
  }

  String newId() => _repository.newId();
}
