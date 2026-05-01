import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/preset_repository.dart';

const _kThemeModeKey = 'theme_mode_v1';
const _kLocaleKey = 'locale_v1';

class SettingsNotifier extends Notifier<AppSettings> {
  late SharedPreferences _prefs;

  @override
  AppSettings build() {
    final prefsAsync = ref.watch(sharedPreferencesProvider);
    return prefsAsync.maybeWhen(
      data: (prefs) {
        _prefs = prefs;
        return _read(prefs);
      },
      orElse: AppSettings.initial,
    );
  }

  AppSettings _read(SharedPreferences prefs) {
    final themeStr = prefs.getString(_kThemeModeKey);
    final localeStr = prefs.getString(_kLocaleKey);
    return AppSettings(
      themeMode: _parseThemeMode(themeStr),
      locale: _parseLocale(localeStr),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setString(_kThemeModeKey, _themeModeName(mode));
  }

  Future<void> setLocale(Locale? locale) async {
    state = state.copyWith(locale: locale);
    if (locale == null) {
      await _prefs.remove(_kLocaleKey);
    } else {
      await _prefs.setString(_kLocaleKey, _localeTag(locale));
    }
  }
}

class AppSettings {
  const AppSettings({this.themeMode = ThemeMode.system, this.locale});
  factory AppSettings.initial() => const AppSettings();

  final ThemeMode themeMode;
  final Locale? locale;

  AppSettings copyWith({ThemeMode? themeMode, Object? locale = _sentinel}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: identical(locale, _sentinel) ? this.locale : locale as Locale?,
    );
  }

  static const _sentinel = Object();
}

ThemeMode _parseThemeMode(String? raw) {
  switch (raw) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

String _themeModeName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.system:
      return 'system';
  }
}

Locale? _parseLocale(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final parts = raw.split('_');
  if (parts.length == 1) return Locale(parts[0]);
  return Locale(parts[0], parts[1]);
}

String _localeTag(Locale l) {
  if (l.countryCode == null || l.countryCode!.isEmpty) return l.languageCode;
  return '${l.languageCode}_${l.countryCode}';
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
