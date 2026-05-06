import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/services/history_archive.dart';

class HistoryController extends AsyncNotifier<List<WorkoutHistoryEntry>> {
  late HistoryRepository _repository;
  late HistoryArchive _archive;

  @override
  Future<List<WorkoutHistoryEntry>> build() async {
    _repository = await ref.watch(historyRepositoryProvider.future);
    _archive = ref.watch(historyArchiveProvider);
    return _repository.loadAll();
  }

  Future<void> deleteOne(String id) async {
    await _repository.deleteOne(id);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    await _repository.clearAll();
    ref.invalidateSelf();
  }

  /// Returns true on a successful share, false if dismissed, throws on
  /// IO failure. Empty history yields false.
  Future<bool> exportAndShare() async {
    final list = await _repository.loadAll();
    if (list.isEmpty) return false;
    return _archive.exportAndShare(list);
  }

  /// Open the file picker and parse the chosen file. Returns null when
  /// the user cancels; throws [HistoryArchiveException] on bad files.
  Future<List<WorkoutHistoryEntry>?> pickToImport() {
    return _archive.pickAndParse();
  }

  /// Merge [imported] into existing history, deduping by entry id.
  /// Returns the number of new entries actually added.
  Future<int> mergeImported(List<WorkoutHistoryEntry> imported) async {
    final existing = await _repository.loadAll();
    final existingIds = existing.map((e) => e.id).toSet();
    final newOnes = imported.where((e) => !existingIds.contains(e.id)).toList();
    if (newOnes.isEmpty) {
      ref.invalidateSelf();
      return 0;
    }
    await _repository.replaceAll([...existing, ...newOnes]);
    ref.invalidateSelf();
    return newOnes.length;
  }

  /// Replace the entire history with [imported]. Returns the count.
  Future<int> replaceWithImported(List<WorkoutHistoryEntry> imported) async {
    await _repository.replaceAll(imported);
    ref.invalidateSelf();
    return imported.length;
  }
}
