import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/app_settings.dart';
import '../../l10n/app_localizations.dart';
import '../shared/section_header.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.tabSettings)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (settings) => _SettingsBody(settings: settings),
      ),
    );
  }
}

class _SettingsBody extends ConsumerWidget {
  const _SettingsBody({required this.settings});
  final AppSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final notifier = ref.read(settingsControllerProvider.notifier);

    return ListView(
      children: [
        SectionHeader(t.settingsTheme),
        _Option(
          icon: Icons.brightness_auto_outlined,
          label: t.themeSystem,
          selected: settings.themeMode == AppThemeMode.system,
          onTap: () => notifier.setThemeMode(AppThemeMode.system),
        ),
        const Divider(),
        _Option(
          icon: Icons.light_mode_outlined,
          label: t.themeLight,
          selected: settings.themeMode == AppThemeMode.light,
          onTap: () => notifier.setThemeMode(AppThemeMode.light),
        ),
        const Divider(),
        _Option(
          icon: Icons.dark_mode_outlined,
          label: t.themeDark,
          selected: settings.themeMode == AppThemeMode.dark,
          onTap: () => notifier.setThemeMode(AppThemeMode.dark),
        ),
        SectionHeader(t.settingsLanguage),
        _Option(
          label: t.languageSystem,
          selected: settings.localeTag == null,
          onTap: () => notifier.setLocaleTag(null),
        ),
        const Divider(),
        _Option(
          label: t.languageEnglish,
          selected: settings.localeTag == 'en',
          onTap: () => notifier.setLocaleTag('en'),
        ),
        const Divider(),
        _Option(
          label: t.languageChinese,
          selected: settings.localeTag?.startsWith('zh') ?? false,
          onTap: () => notifier.setLocaleTag('zh_TW'),
        ),
        SectionHeader(t.settingsAbout),
        ListTile(
          leading: const Icon(Icons.fitness_center_outlined, size: 20),
          title: Text(t.appTitle),
          subtitle: const Text('1.0.0'),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData? icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: icon == null ? const SizedBox(width: 24) : Icon(icon, size: 20),
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check, size: 18, color: scheme.primary)
          : null,
      onTap: onTap,
    );
  }
}
