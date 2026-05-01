import '../entities/tabata_preset.dart';

abstract class PresetRepository {
  Future<List<TabataPreset>> loadAll();
  Future<TabataPreset> upsert(TabataPreset preset);
  Future<void> delete(String id);
  String newId();
}
