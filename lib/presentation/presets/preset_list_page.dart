import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../di/providers.dart';
import '../../domain/entities/tabata_preset.dart';
import '../../l10n/app_localizations.dart';

class PresetListPage extends ConsumerWidget {
  const PresetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(presetsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.appTitle)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (presets) {
          if (presets.isEmpty) return _Empty(message: t.presetsEmpty);
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: presets.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (ctx, i) => _PresetTile(preset: presets[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/presets/edit'),
        icon: const Icon(Icons.add, size: 18),
        label: Text(t.newPreset),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

class _PresetTile extends ConsumerWidget {
  const _PresetTile({required this.preset});
  final TabataPreset preset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(preset.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.error.withValues(alpha: 0.08),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.error, size: 22),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(t.deletePresetTitle(preset.name)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text(t.actionCancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text(t.actionDelete),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => ref
          .read(presetsControllerProvider.notifier)
          .delete(preset.id),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        title: Text(
          preset.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            t.presetSummary(
              preset.sets,
              preset.rounds,
              preset.workSeconds,
              preset.restSeconds,
              _fmtMmSs(preset.totalSeconds),
            ),
          ),
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              tooltip: t.actionEdit,
              onPressed: () => context.push('/presets/edit', extra: preset),
              style: IconButton.styleFrom(shape: const CircleBorder()),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow, size: 20),
              tooltip: t.actionStart,
              onPressed: () => context.push('/timer', extra: preset),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                side: BorderSide(color: scheme.primary, width: 1.2),
                foregroundColor: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtMmSs(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$m:$ss';
  }
}
