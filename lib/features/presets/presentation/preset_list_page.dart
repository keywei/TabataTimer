import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/storage/preset_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../data/tabata_preset.dart';

class PresetListPage extends ConsumerWidget {
  const PresetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final presetsAsync = ref.watch(presetsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.appTitle)),
      body: presetsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('$e')),
        data: (presets) {
          if (presets.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  t.presetsEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: presets.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => _PresetTile(preset: presets[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/presets/edit'),
        icon: const Icon(Icons.add),
        label: Text(t.newPreset),
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
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(t.deletePresetTitle(preset.name)),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.actionCancel)),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.actionDelete)),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) async {
        final repo = await ref.read(presetRepositoryProvider.future);
        await repo.delete(preset.id);
        ref.invalidate(presetsProvider);
      },
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          title: Text(
            preset.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: t.actionEdit,
                onPressed: () => context.push('/presets/edit', extra: preset),
              ),
              const SizedBox(width: 4),
              FilledButton.icon(
                onPressed: () => context.push('/timer', extra: preset),
                icon: const Icon(Icons.play_arrow),
                label: Text(t.actionStart),
              ),
            ],
          ),
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
