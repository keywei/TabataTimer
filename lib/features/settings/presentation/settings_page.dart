import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/settings/settings_providers.dart';
import '../../../l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(t.tabSettings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionHeader(label: t.settingsTheme),
          _ThemeOption(
            label: t.themeSystem,
            icon: Icons.brightness_auto_outlined,
            selected: settings.themeMode == ThemeMode.system,
            onTap: () => notifier.setThemeMode(ThemeMode.system),
          ),
          _ThemeOption(
            label: t.themeLight,
            icon: Icons.light_mode_outlined,
            selected: settings.themeMode == ThemeMode.light,
            onTap: () => notifier.setThemeMode(ThemeMode.light),
          ),
          _ThemeOption(
            label: t.themeDark,
            icon: Icons.dark_mode_outlined,
            selected: settings.themeMode == ThemeMode.dark,
            onTap: () => notifier.setThemeMode(ThemeMode.dark),
          ),
          const SizedBox(height: 8),
          _SectionHeader(label: t.settingsLanguage),
          _LangOption(
            label: t.languageSystem,
            selected: settings.locale == null,
            onTap: () => notifier.setLocale(null),
          ),
          _LangOption(
            label: t.languageEnglish,
            selected: settings.locale?.languageCode == 'en',
            onTap: () => notifier.setLocale(const Locale('en')),
          ),
          _LangOption(
            label: t.languageChinese,
            selected: settings.locale?.languageCode == 'zh',
            onTap: () => notifier.setLocale(const Locale('zh', 'TW')),
          ),
          const SizedBox(height: 16),
          const Divider(),
          _SectionHeader(label: t.settingsAbout),
          ListTile(
            leading: const Icon(Icons.fitness_center_outlined),
            title: Text(t.appTitle),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: onTap,
    );
  }
}

class _LangOption extends StatelessWidget {
  const _LangOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: onTap,
    );
  }
}
