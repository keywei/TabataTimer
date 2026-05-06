import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/workout_history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../dtos/workout_history_entry_dto.dart';

const _kHistoryKey = 'history_v1';
const _kHistoryMax = 200;

class SharedPrefsHistoryRepository implements HistoryRepository {
  SharedPrefsHistoryRepository(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<List<WorkoutHistoryEntry>> loadAll() async {
    final raw = _prefs.getString(_kHistoryKey);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List<dynamic>)
        .map((e) =>
            WorkoutHistoryEntryDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
    list.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return list;
  }

  @override
  Future<void> add(WorkoutHistoryEntry entry) async {
    final list = await loadAll();
    list.insert(0, entry);
    if (list.length > _kHistoryMax) {
      list.removeRange(_kHistoryMax, list.length);
    }
    await _persist(list);
  }

  @override
  Future<void> deleteOne(String id) async {
    final list = await loadAll();
    list.removeWhere((e) => e.id == id);
    await _persist(list);
  }

  @override
  Future<void> clearAll() async {
    await _prefs.remove(_kHistoryKey);
  }

  @override
  Future<void> replaceAll(List<WorkoutHistoryEntry> entries) async {
    final sorted = [...entries]
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    final trimmed = sorted.length > _kHistoryMax
        ? sorted.sublist(0, _kHistoryMax)
        : sorted;
    await _persist(trimmed);
  }

  Future<void> _persist(List<WorkoutHistoryEntry> list) async {
    final encoded = jsonEncode(list.map((e) => e.toDto().toJson()).toList());
    await _prefs.setString(_kHistoryKey, encoded);
  }
}
