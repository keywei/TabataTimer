import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/tabata_preset.dart';
import '../../domain/repositories/preset_repository.dart';
import '../dtos/tabata_preset_dto.dart';

const _kPresetsKey = 'presets_v1';

class SharedPrefsPresetRepository implements PresetRepository {
  SharedPrefsPresetRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _uuid = Uuid();

  @override
  Future<List<TabataPreset>> loadAll() async {
    final raw = _prefs.getString(_kPresetsKey);
    if (raw == null || raw.isEmpty) return _seedDefaults();
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TabataPresetDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<TabataPreset> upsert(TabataPreset preset) async {
    final list = await loadAll();
    final idx = list.indexWhere((p) => p.id == preset.id);
    if (idx >= 0) {
      list[idx] = preset;
    } else {
      list.add(preset);
    }
    await _persist(list);
    return preset;
  }

  @override
  Future<void> delete(String id) async {
    final list = await loadAll();
    list.removeWhere((p) => p.id == id);
    await _persist(list);
  }

  @override
  String newId() => _uuid.v4();

  Future<void> _persist(List<TabataPreset> list) async {
    final encoded = jsonEncode(list.map((p) => p.toDto().toJson()).toList());
    await _prefs.setString(_kPresetsKey, encoded);
  }

  Future<List<TabataPreset>> _seedDefaults() async {
    final defaults = <TabataPreset>[
      TabataPreset(
        id: _uuid.v4(),
        name: 'Classic Tabata',
        prepareSeconds: 10,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
      ),
      TabataPreset(
        id: _uuid.v4(),
        name: 'HIIT 30/15',
        prepareSeconds: 10,
        workSeconds: 30,
        restSeconds: 15,
        rounds: 10,
      ),
      TabataPreset(
        id: _uuid.v4(),
        name: 'Double Tabata',
        prepareSeconds: 10,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
        sets: 2,
        restBetweenSetsSeconds: 60,
      ),
    ];
    await _persist(defaults);
    return defaults;
  }
}
