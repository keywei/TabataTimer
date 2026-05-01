import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../features/presets/data/tabata_preset.dart';

const _kPresetsKey = 'presets_v1';
const _kSelectedPresetKey = 'selected_preset_id_v1';

class PresetRepository {
  PresetRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _uuid = Uuid();

  Future<List<TabataPreset>> loadAll() async {
    final raw = _prefs.getString(_kPresetsKey);
    if (raw == null || raw.isEmpty) {
      return _seedDefaults();
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TabataPreset.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<TabataPreset> presets) async {
    final encoded = jsonEncode(presets.map((p) => p.toJson()).toList());
    await _prefs.setString(_kPresetsKey, encoded);
  }

  Future<TabataPreset> upsert(TabataPreset preset) async {
    final list = await loadAll();
    final idx = list.indexWhere((p) => p.id == preset.id);
    if (idx >= 0) {
      list[idx] = preset;
    } else {
      list.add(preset);
    }
    await saveAll(list);
    return preset;
  }

  Future<void> delete(String id) async {
    final list = await loadAll();
    list.removeWhere((p) => p.id == id);
    await saveAll(list);
  }

  String newId() => _uuid.v4();

  String? get selectedPresetId => _prefs.getString(_kSelectedPresetKey);

  Future<void> setSelectedPresetId(String? id) async {
    if (id == null) {
      await _prefs.remove(_kSelectedPresetKey);
    } else {
      await _prefs.setString(_kSelectedPresetKey, id);
    }
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
        sets: 1,
      ),
      TabataPreset(
        id: _uuid.v4(),
        name: 'HIIT 30/15',
        prepareSeconds: 10,
        workSeconds: 30,
        restSeconds: 15,
        rounds: 10,
        sets: 1,
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
    await saveAll(defaults);
    return defaults;
  }
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final presetRepositoryProvider = FutureProvider<PresetRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return PresetRepository(prefs);
});

final presetsProvider = FutureProvider<List<TabataPreset>>((ref) async {
  final repo = await ref.watch(presetRepositoryProvider.future);
  return repo.loadAll();
});
