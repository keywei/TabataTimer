import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/history/data/workout_history_entry.dart';
import 'preset_repository.dart';

const _kHistoryKey = 'history_v1';
const _kHistoryMax = 200;

class HistoryRepository {
  HistoryRepository(this._prefs);

  final SharedPreferences _prefs;

  Future<List<WorkoutHistoryEntry>> loadAll() async {
    final raw = _prefs.getString(_kHistoryKey);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List<dynamic>)
        .map((e) => WorkoutHistoryEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return list;
  }

  Future<void> _save(List<WorkoutHistoryEntry> list) async {
    final encoded = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs.setString(_kHistoryKey, encoded);
  }

  Future<void> add(WorkoutHistoryEntry entry) async {
    final list = await loadAll();
    list.insert(0, entry);
    if (list.length > _kHistoryMax) {
      list.removeRange(_kHistoryMax, list.length);
    }
    await _save(list);
  }

  Future<void> deleteOne(String id) async {
    final list = await loadAll();
    list.removeWhere((e) => e.id == id);
    await _save(list);
  }

  Future<void> clearAll() async {
    await _prefs.remove(_kHistoryKey);
  }
}

final historyRepositoryProvider = FutureProvider<HistoryRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return HistoryRepository(prefs);
});

final historyProvider = FutureProvider<List<WorkoutHistoryEntry>>((ref) async {
  final repo = await ref.watch(historyRepositoryProvider.future);
  return repo.loadAll();
});
