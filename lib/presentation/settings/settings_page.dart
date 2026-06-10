import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../di/providers.dart';
import '../../domain/entities/app_settings.dart';
import '../../l10n/app_localizations.dart';
import '../shared/password_dialog.dart';
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
        SectionHeader(t.settingsPasswordSection),
        _PasswordRows(settings: settings),
        SectionHeader(t.settingsAbout),
        ListTile(
          leading: const Icon(Icons.fitness_center_outlined, size: 20),
          title: Text(t.appTitle),
          subtitle: const Text('1.0.0'),
        ),
        const _ProvisioningProfileTile(),
      ],
    );
  }
}

class _ProvisioningProfileTile extends ConsumerWidget {
  const _ProvisioningProfileTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(provisioningProfileProvider);
    return async.maybeWhen(
      data: (profile) {
        if (profile == null) return const SizedBox.shrink();
        final t = AppLocalizations.of(context);
        final scheme = Theme.of(context).colorScheme;
        final locale = Localizations.localeOf(context).toString();
        final localExp = profile.expirationDate.toLocal();
        final formatted = DateFormat.yMd(locale).add_Hm().format(localExp);
        final now = DateTime.now();
        final expired = profile.isExpired(now);
        final days = profile.remainingFrom(now).inDays;
        final subtitle = expired
            ? t.settingsIosProfileExpired(formatted)
            : t.settingsIosProfileValidUntil(formatted, days);
        return Column(
          children: [
            const Divider(height: 1),
            ListTile(
              leading: Icon(
                Icons.verified_user_outlined,
                size: 20,
                color: expired ? scheme.error : null,
              ),
              title: Text(t.settingsIosProfileExpiry),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: expired ? scheme.error : null),
              ),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
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

class _PasswordRows extends ConsumerWidget {
  const _PasswordRows({required this.settings});
  final AppSettings settings;

  bool get _isSet =>
      settings.passwordHash != null && settings.passwordHash!.isNotEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.lock_outline, size: 20),
          title: Text(_isSet ? t.settingsPasswordChange : t.settingsPasswordSet),
          subtitle: Text(t.settingsPasswordExplain),
          onTap: () => _onSet(context, ref),
        ),
        if (_isSet) ...[
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_open_outlined, size: 20),
            title: Text(t.settingsPasswordRemove),
            onTap: () => _onRemove(context, ref),
          ),
        ],
      ],
    );
  }

  Future<void> _onSet(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(settingsControllerProvider.notifier);
    final t = AppLocalizations.of(context);

    if (_isSet) {
      final ok = await ensurePasswordOrAsk(context, ref);
      if (!ok || !context.mounted) return;
    }

    final newPwd = await _promptForNewPassword(context, t);
    if (newPwd == null || !context.mounted) return;

    await controller.setPassword(newPwd);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(t.passwordSetToast)));
  }

  Future<void> _onRemove(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(settingsControllerProvider.notifier);
    final t = AppLocalizations.of(context);
    final ok = await ensurePasswordOrAsk(context, ref);
    if (!ok || !context.mounted) return;
    await controller.setPassword(null);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(t.passwordRemovedToast)));
  }
}

Future<String?> _promptForNewPassword(
    BuildContext context, AppLocalizations t) async {
  final newPwd = TextEditingController();
  final confirm = TextEditingController();
  String? errorText;

  final result = await showDialog<String?>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: Text(t.passwordSetTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newPwd,
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(labelText: t.passwordNewLabel),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirm,
              obscureText: true,
              decoration: InputDecoration(
                labelText: t.passwordConfirmLabel,
                errorText: errorText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.actionCancel),
          ),
          FilledButton(
            onPressed: () {
              if (newPwd.text.isEmpty) {
                setState(() => errorText = t.passwordEmpty);
                return;
              }
              if (newPwd.text != confirm.text) {
                setState(() => errorText = t.passwordMismatch);
                return;
              }
              Navigator.pop(ctx, newPwd.text);
            },
            child: Text(t.actionSave),
          ),
        ],
      ),
    ),
  );
  newPwd.dispose();
  confirm.dispose();
  return result;
}
