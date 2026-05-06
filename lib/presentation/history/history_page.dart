import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../l10n/app_localizations.dart';
import '../shared/section_header.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(historyControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.tabHistory),
        actions: [
          async.maybeWhen(
            data: (list) => list.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_sweep_outlined),
                    tooltip: t.historyClearAction,
                    onPressed: () => _confirmClear(context, ref, t),
                  ),
            orElse: () => const SizedBox.shrink(),
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
