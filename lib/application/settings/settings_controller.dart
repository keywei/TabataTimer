import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsController extends AsyncNotifier<AppSettings> {
  late SettingsRepository _repository;

  @override
  Future<AppSettings> build() async {
    _repository = await ref.watch(settingsRepositoryProvider.future);
    return _repository.load();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    final current = state.value ?? const AppSettings();
    final updated = current.copyWith(themeMode: mode);
    await _repository.save(updated);
    state = AsyncData(updated);
  }

  Future<void> setLocaleTag(String? localeTag) async {
    final current = state.value ?? const AppSettings();
    final updated = current.copyWith(localeTag: localeTag);
    await _repository.save(updated);
    state = AsyncData(updated);
  }
}
