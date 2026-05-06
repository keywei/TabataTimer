import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/services/history_archive.dart';
import '../../l10n/app_localizations.dart';
import '../shared/section_header.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(historyControllerProvider);

    final hasEntries = async.maybeWhen(
      data: (list) => list.isNotEmpty,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.tabHistory),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'export':
                  _onExport(context, ref, t);
                case 'import':
                  _onImport(context, ref, t);
                case 'clear':
                  _confirmClear(context, ref, t);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'export',
                enabled: hasEntries,
                child: Row(
                  children: [
                    const Icon(Icons.ios_share_outlined, size: 18),
                    const SizedBox(width: 12),
                    Text(t.historyExport),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'import',
                child: Row(
                  children: [
                    const Icon(Icons.file_download_outlined, size: 18),
                    const SizedBox(width: 12),
                    Text(t.historyImport),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'clear',
                enabled: hasEntries,
                child: Row(
                  children: [
                    const Icon(Icons.delete_sweep_outlined, size: 18),
                    const SizedBox(width: 12),
                    Text(t.historyClearAction),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) return _Empty(message: t.historyEmpty);
          return _GroupedList(entries: list);
        },
      ),
    );
  }

  void _snack(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onExport(
      BuildContext context, WidgetRef ref, AppLocalizations t) async {
    try {
      final shared =
          await ref.read(historyControllerProvider.notifier).exportAndShare();
      if (!shared && context.mounted) _snack(context, t.historyExportEmpty);
    } catch (e) {
      if (context.mounted) _snack(context, t.historyImportFailed('$e'));
    }
  }

  Future<void> _onImport(
      BuildContext context, WidgetRef ref, AppLocalizations t) async {
    final controller = ref.read(historyControllerProvider.notifier);
    List<WorkoutHistoryEntry>? imported;
    try {
      imported = await controller.pickToImport();
    } on HistoryArchiveException catch (e) {
      if (context.mounted) _snack(context, t.historyImportFailed(e.message));
      return;
    } catch (e) {
      if (context.mounted) _snack(context, t.historyImportFailed('$e'));
      return;
    }
    if (imported == null) return; // user cancelled
    if (imported.isEmpty) {
      if (context.mounted) _snack(context, t.historyImportNothing);
      return;
    }
    if (!context.mounted) return;

    final mode = await showDialog<_ImportMode>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.historyImportTitle(imported!.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, _ImportMode.replace),
            child: Text(t.historyImportReplace),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, _ImportMode.merge),
            child: Text(t.historyImportMerge),
          ),
        ],
      ),
    );

    if (mode == null || !context.mounted) return;
    if (mode == _ImportMode.merge) {
      final added = await controller.mergeImported(imported);
      if (!context.mounted) return;
      _snack(
        context,
        added == 0
            ? t.historyImportNoNewToast
            : t.historyImportMergedToast(added),
      );
    } else {
      final count = await controller.replaceWithImported(imported);
      if (!context.mounted) return;
      _snack(context, t.historyImportReplacedToast(count));
    }
  }

  Future<void> _confirmClear(BuildContext context, WidgetRef ref, AppLocalizations t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.historyClearTitle),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.actionCancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.actionDelete)),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(historyControllerProvider.notifier).clearAll();
    }
  }
}

enum _ImportMode { merge, replace }

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

class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.entries});
  final List<WorkoutHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final groups = <String, List<WorkoutHistoryEntry>>{};
    for (final e in entries) {
      groups.putIfAbsent(_dayKey(e.completedAt, t), () => []).add(e);
    }

    final widgets = <Widget>[];
    for (final entry in groups.entries) {
      widgets.add(SectionHeader(entry.key));
      for (var i = 0; i < entry.value.length; i++) {
        widgets.add(_HistoryTile(entry: entry.value[i]));
        if (i < entry.value.length - 1) widgets.add(const Divider());
      }
    }

    return ListView(children: widgets);
  }

  String _dayKey(DateTime when, AppLocalizations t) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(when.year, when.month, when.day);
    final diff = today.difference(that).inDays;
    if (diff == 0) return t.historyToday;
    if (diff == 1) return t.historyYesterday;
    return '${that.year}-${_two(that.month)}-${_two(that.day)}';
  }

  String _two(int n) => n.toString().padLeft(2, '0');
}

class _HistoryTile extends ConsumerWidget {
  const _HistoryTile({required this.entry});
  final WorkoutHistoryEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final time = '${_two(entry.completedAt.hour)}:${_two(entry.completedAt.minute)}';

    return Dismissible(
      key: ValueKey(entry.id),
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
                title: Text(t.historyDeleteConfirm),
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
          .read(historyControllerProvider.notifier)
          .deleteOne(entry.id),
      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: scheme.outline, width: 1),
          ),
          child: Icon(Icons.check, size: 16, color: scheme.onSurfaceVariant),
        ),
        title: Text(entry.presetName),
        subtitle: Text(t.historyEntrySubtitle(entry.totalRounds, _fmtMmSs(entry.durationSeconds))),
        trailing: Text(
          time,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
        ),
      ),
    );
  }

  String _two(int n) => n.toString().padLeft(2, '0');
  String _fmtMmSs(int s) => '${_two(s ~/ 60)}:${_two(s % 60)}';
}
