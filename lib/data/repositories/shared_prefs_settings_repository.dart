import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

const _kThemeModeKey = 'theme_mode_v1';
const _kLocaleKey = 'locale_v1';
const _kTtsVolumeKey = 'tts_volume_v1';
const _kPasswordHashKey = 'password_hash_v1';

class SharedPrefsSettingsRepository implements SettingsRepository {
  SharedPrefsSettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<AppSettings> load() async {
    final themeRaw = _prefs.getString(_kThemeModeKey);
    final localeRaw = _prefs.getString(_kLocaleKey);
    final volumeRaw = _prefs.getDouble(_kTtsVolumeKey);
    final passwordRaw = _prefs.getString(_kPasswordHashKey);
    return AppSettings(
      themeMode: _parseThemeMode(themeRaw),
      localeTag: localeRaw,
      ttsVolume: volumeRaw ?? 0.5,
      passwordHash: (passwordRaw != null && passwordRaw.isNotEmpty)
          ? passwordRaw
          : null,
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    await _prefs.setString(_kThemeModeKey, _themeModeName(settings.themeMode));
    if (settings.localeTag == null) {
      await _prefs.remove(_kLocaleKey);
    } else {
      await _prefs.setString(_kLocaleKey, settings.localeTag!);
    }
    await _prefs.setDouble(_kTtsVolumeKey, settings.ttsVolume);
    if (settings.passwordHash == null) {
      await _prefs.remove(_kPasswordHashKey);
    } else {
      await _prefs.setString(_kPasswordHashKey, settings.passwordHash!);
    }
  }

  AppThemeMode _parseThemeMode(String? raw) {
    switch (raw) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }

  String _themeModeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }
}
