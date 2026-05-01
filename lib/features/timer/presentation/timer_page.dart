import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/audio/audio_cue_service.dart';
import '../../../core/haptics/haptics_service.dart';
import '../../../core/notifications/local_notif_service.dart';
import '../../../core/storage/history_repository.dart';
import '../../../core/tts/tts_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../history/data/workout_history_entry.dart';
import '../../presets/data/tabata_preset.dart';
import '../domain/timer_controller.dart';
import '../domain/timer_state.dart';
import 'widgets/circular_countdown.dart';

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key, required this.preset});

  final TabataPreset preset;

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  ProviderSubscription<AsyncValue<PhaseTransitionEvent>>? _sub;
  DateTime? _startedAt;
  bool _historyRecorded = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startedAt = DateTime.now();
      ref.read(timerControllerProvider.notifier).start(widget.preset);
      _sub = ref.listenManual<AsyncValue<PhaseTransitionEvent>>(
        phaseTransitionsProvider,
        (prev, next) {
          final ev = next.value;
          if (ev != null) _handleTransition(ev);
        },
      );
    });
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _sub?.close();
    super.dispose();
  }

  void _handleTransition(PhaseTransitionEvent ev) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final tag = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}-${locale.countryCode}';
    final audio = ref.read(audioCueServiceProvider);
    final haptics = ref.read(hapticsServiceProvider);
    final tts = ref.read(ttsServiceProvider);
    void say(String msg) => tts.say(msg, languageTag: tag);

    switch (ev.to) {
      case TimerPhase.prepare:
        audio.phaseChange();
        say(t.ttsGetReady);
        break;
      case TimerPhase.work:
        audio.phaseChange();
        haptics.workStart();
        say(ev.set > 1 || ev.round > 1 ? t.ttsRoundWork(ev.round) : t.ttsWork);
        break;
      case TimerPhase.rest:
        audio.phaseChange();
        haptics.restStart();
        say(t.ttsRest);
        break;
      case TimerPhase.restBetweenSets:
        audio.phaseChange();
        haptics.restStart();
        say(t.ttsSetComplete);
        break;
      case TimerPhase.completed:
        audio.completed();
        haptics.completed();
        say(t.ttsWorkoutComplete);
        ref.read(localNotifServiceProvider.future).then(
              (s) => s.showWorkoutComplete(
                title: t.notifWorkoutCompleteTitle,
                body: t.notifWorkoutCompleteBody,
              ),
            );
        _recordHistory();
        break;
      case TimerPhase.idle:
        break;
    }
  }

  Future<void> _recordHistory() async {
    if (_historyRecorded) return;
    _historyRecorded = true;
    final start = _startedAt ?? DateTime.now();
    final end = DateTime.now();
    final entry = WorkoutHistoryEntry(
      id: const Uuid().v4(),
      presetName: widget.preset.name,
      startedAt: start,
      completedAt: end,
      durationSeconds: end.difference(start).inSeconds,
      totalRounds: widget.preset.rounds * widget.preset.sets,
      totalSets: widget.preset.sets,
    );
    final repo = await ref.read(historyRepositoryProvider.future);
    await repo.add(entry);
    ref.invalidate(historyProvider);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final snap = ref.watch(timerControllerProvider);
    final ctrl = ref.read(timerControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    final color = _phaseColor(snap.phase, scheme);
    final label = _phaseLabel(snap.phase, t);
    final preset = snap.preset ?? widget.preset;

    return PopScope(
      canPop: snap.phase == TimerPhase.idle || snap.phase == TimerPhase.completed,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          final confirmed = await _confirmStop(context, t);
          if (confirmed && mounted) {
            ctrl.stop();
            if (context.mounted) context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: color.withValues(alpha: 0.06),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(preset.name),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _SetRoundChip(
                  set: snap.currentSet,
                  totalSets: preset.sets,
                  round: snap.currentRound,
                  totalRounds: preset.rounds,
                ),
                const Spacer(),
                CircularCountdown(
                  progress: snap.phaseProgress,
                  color: color,
                  label: label,
                  bigText: '${snap.phaseRemainingSeconds}',
                  subtitle: snap.phase == TimerPhase.completed
                      ? t.doneLabel
                      : t.totalLabel(_fmtMmSs(snap.totalElapsedMs ~/ 1000)),
                ),
                const Spacer(),
                _Controls(snap: snap, ctrl: ctrl),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmStop(BuildContext context, AppLocalizations t) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.stopWorkoutTitle),
        content: Text(t.stopWorkoutBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.actionContinue)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.actionStop)),
        ],
      ),
    );
    return result ?? false;
  }

  Color _phaseColor(TimerPhase phase, ColorScheme scheme) {
    switch (phase) {
      case TimerPhase.prepare:
        return Colors.amber.shade700;
      case TimerPhase.work:
        return Colors.red.shade600;
      case TimerPhase.rest:
        return Colors.green.shade600;
      case TimerPhase.restBetweenSets:
        return Colors.blue.shade600;
      case TimerPhase.completed:
        return Colors.purple.shade600;
      case TimerPhase.idle:
        return scheme.primary;
    }
  }

  String _phaseLabel(TimerPhase phase, AppLocalizations t) {
    switch (phase) {
      case TimerPhase.prepare:
        return t.phasePrepare;
      case TimerPhase.work:
        return t.phaseWork;
      case TimerPhase.rest:
        return t.phaseRest;
      case TimerPhase.restBetweenSets:
        return t.phaseSetBreak;
      case TimerPhase.completed:
        return t.phaseDone;
      case TimerPhase.idle:
        return '';
    }
  }

  String _fmtMmSs(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$m:$ss';
  }
}

class _SetRoundChip extends ConsumerWidget {
  const _SetRoundChip({
    required this.set,
    required this.totalSets,
    required this.round,
    required this.totalRounds,
  });

  final int set;
  final int totalSets;
  final int round;
  final int totalRounds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return Wrap(
      spacing: 12,
      children: [
        if (totalSets > 1) Chip(label: Text(t.setRoundChip(set, totalSets))),
        Chip(label: Text(t.roundChip(round, totalRounds))),
      ],
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({required this.snap, required this.ctrl});

  final TimerSnapshot snap;
  final TimerController ctrl;

  @override
  Widget build(BuildContext context) {
    final isCompleted = snap.phase == TimerPhase.completed;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton.filledTonal(
          iconSize: 36,
          onPressed: isCompleted ? null : ctrl.skipPhase,
          icon: const Icon(Icons.skip_next),
        ),
        FloatingActionButton.large(
          heroTag: 'play_pause',
          onPressed: isCompleted
              ? null
              : () => snap.isPaused ? ctrl.resume() : ctrl.pause(),
          child: Icon(snap.isPaused ? Icons.play_arrow : Icons.pause, size: 48),
        ),
        IconButton.filledTonal(
          iconSize: 36,
          onPressed: () {
            ctrl.stop();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.stop),
        ),
      ],
    );
  }
}
