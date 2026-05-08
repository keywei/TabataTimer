import 'dart:convert';

import 'package:crypto/crypto.dart';
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

  Future<void> setTtsVolume(double volume) async {
    final current = state.value ?? const AppSettings();
    final clamped = volume.clamp(0.0, 1.0);
    final updated = current.copyWith(ttsVolume: clamped);
    await _repository.save(updated);
    state = AsyncData(updated);
  }

  bool get isPasswordSet {
    final hash = state.value?.passwordHash;
    return hash != null && hash.isNotEmpty;
  }

  /// Sets a new password (or clears it when [raw] is null/empty).
  /// Stores SHA-256 hex; never the plain text.
  Future<void> setPassword(String? raw) async {
    final current = state.value ?? const AppSettings();
    final hash = (raw == null || raw.isEmpty) ? null : _hash(raw);
    final updated = current.copyWith(passwordHash: hash);
    await _repository.save(updated);
    state = AsyncData(updated);
  }

  /// Returns true if [raw] matches the stored password (or if none is set).
  bool verifyPassword(String raw) {
    final stored = state.value?.passwordHash;
    if (stored == null || stored.isEmpty) return true;
    return _hash(raw) == stored;
  }

  String _hash(String raw) =>
      sha256.convert(utf8.encode(raw)).toString();
}
