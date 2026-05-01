import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/history_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../data/workout_history_entry.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(historyProvider);

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
          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  t.historyEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            );
          }
          return _GroupedHistory(entries: list);
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
      final repo = await ref.read(historyRepositoryProvider.future);
      await repo.clearAll();
      ref.invalidate(historyProvider);
    }
  }
}

class _GroupedHistory extends StatelessWidget {
  const _GroupedHistory({required this.entries});

  final List<WorkoutHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final groups = <String, List<WorkoutHistoryEntry>>{};
    for (final e in entries) {
      groups.putIfAbsent(_dayKey(context, e.completedAt, t), () => []).add(e);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: groups.length,
      itemBuilder: (ctx, i) {
        final key = groups.keys.elementAt(i);
        final items = groups[key]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                key,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            ...items.map((e) => _HistoryTile(entry: e)),
          ],
        );
      },
    );
  }

  String _dayKey(BuildContext context, DateTime when, AppLocalizations t) {
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

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});

  final WorkoutHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final time = '${_two(entry.completedAt.hour)}:${_two(entry.completedAt.minute)}';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        child: const Icon(Icons.check),
      ),
      title: Text(entry.presetName),
      subtitle: Text(t.historyEntrySubtitle(entry.totalRounds, _fmtMmSs(entry.durationSeconds))),
      trailing: Text(
        time,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
      ),
    );
  }

  String _two(int n) => n.toString().padLeft(2, '0');
  String _fmtMmSs(int s) => '${_two(s ~/ 60)}:${_two(s % 60)}';
}
