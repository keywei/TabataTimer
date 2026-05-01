import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryController extends AsyncNotifier<List<WorkoutHistoryEntry>> {
  late HistoryRepository _repository;

  @override
  Future<List<WorkoutHistoryEntry>> build() async {
    _repository = await ref.watch(historyRepositoryProvider.future);
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
}
