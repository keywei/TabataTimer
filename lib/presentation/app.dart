import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/providers.dart';
import '../domain/entities/app_settings.dart';
import '../l10n/app_localizations.dart';
import 'routing/router.dart';
import 'theme/app_theme.dart';

class TabataApp extends ConsumerWidget {
  const TabataApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    final settings = settingsAsync.maybeWhen(
      data: (s) => s,
      orElse: () => const AppSettings(),
    );

    return MaterialApp.router(
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _toThemeMode(settings.themeMode),
      locale: _toLocale(settings.localeTag),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeMode _toThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Locale? _toLocale(String? tag) {
    if (tag == null || tag.isEmpty) return null;
    final parts = tag.split('_');
    if (parts.length == 1) return Locale(parts[0]);
    return Locale(parts[0], parts[1]);
  }
}
