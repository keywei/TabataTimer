import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum AppThemeMode { system, light, dark }

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    String? localeTag,
    @Default(0.5) double ttsVolume,
  }) = _AppSettings;
}
