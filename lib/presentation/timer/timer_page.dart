import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../di/providers.dart';
import '../../domain/entities/tabata_preset.dart';
import '../../domain/entities/timer_phase.dart';
import '../../domain/entities/timer_snapshot.dart';
import '../../domain/timer/phase_transition.dart';
import '../../l10n/app_localizations.dart';
import '../theme/phase_colors.dart';
import 'widgets/circular_countdown.dart';

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key, required this.preset});

  final TabataPreset preset;

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  StreamSubscription<PhaseTransition>? _sub;
  StreamSubscription<int>? _countdownSub;
  StreamSubscription<void>? _halfwaySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ctrl = ref.read(workoutControllerProvider.notifier);
      _sub = ctrl.transitions.listen(_handleTransition);
      _countdownSub = ctrl.countdowns.listen(_handleCountdown);
      _halfwaySub = ctrl.halfways.listen((_) => _handleHalfway());
      final settings = await ref.read(settingsControllerProvider.future);
      await ref.read(ttsSpeakerProvider).setVolume(settings.ttsVolume);
      await ctrl.start(widget.preset);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _countdownSub?.cancel();
    _halfwaySub?.cancel();
    super.dispose();
  }

  String _localeTag() {
    final locale = Localizations.localeOf(context);
    return locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}-${locale.countryCode}';
  }

  void _handleCountdown(int n) {
    if (!mounted) return;
    ref.read(ttsSpeakerProvider).say('$n', languageTag: _localeTag());
  }

  void _handleHalfway() {
    if (!mounted) return;
    ref
        .read(ttsSpeakerProvider)
        .say(AppLocalizations.of(context).ttsHalfway, languageTag: _localeTag());
  }

  Future<void> _handleTransition(PhaseTransition ev) async {
    if (!mounted) return;
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final tag = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}-${locale.countryCode}';
    final tts = ref.read(ttsSpeakerProvider);
    void say(String msg) => tts.say(msg, languageTag: tag);

    switch (ev.to) {
      case TimerPhase.prepare:
        say(t.ttsGetReady);
        break;
      case TimerPhase.work:
        say(ev.set > 1 || ev.round > 1 ? t.ttsRoundWork(ev.round) : t.ttsWork);
        break;
      case TimerPhase.rest:
        say(t.ttsRest);
        break;
      case TimerPhase.restBetweenSets:
        say(t.ttsSetComplete);
        break;
      case TimerPhase.completed:
        say(t.ttsWorkoutComplete);
        final notifier = await ref.read(workoutNotifierProvider.future);
        unawaited(notifier.showCompleted(
          title: t.notifWorkoutCompleteTitle,
          body: t.notifWorkoutCompleteBody,
        ));
        break;
      case TimerPhase.idle:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final snap = ref.watch(workoutControllerProvider);
    final ctrl = ref.read(workoutControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    final color = PhaseColors.of(snap.phase, scheme).foreground;
    final preset = snap.preset ?? widget.preset;

    return PopScope(
      canPop: snap.phase == TimerPhase.idle || snap.phase == TimerPhase.completed,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          final confirmed = await _confirmStop(context, t);
          if (confirmed && mounted) {
            await ctrl.stop();
            if (context.mounted) context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(preset.name),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final confirmed =
                  snap.phase == TimerPhase.idle || snap.phase == TimerPhase.completed
                      ? true
                      : await _confirmStop(context, t);
              if (confirmed && mounted) {
                await ctrl.stop();
                if (context.mounted) context.pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 32),
            child: Column(
              children: [
                _SetRoundChips(
                  set: snap.currentSet,
                  totalSets: preset.sets,
                  round: snap.currentRound,
                  totalRounds: preset.rounds,
                ),
                const Spacer(),
                CircularCountdown(
                  progress: snap.phaseProgress,
                  color: color,
                  label: _phaseLabel(snap.phase, t),
                  bigText: '${snap.phaseRemainingSeconds}',
                  subtitle: snap.phase == TimerPhase.completed
                      ? t.doneLabel
                      : t.totalLabel(_fmtMmSs(snap.totalElapsedMs ~/ 1000)),
                ),
                const Spacer(),
                const _TtsVolumeSlider(),
                const SizedBox(height: 16),
                _Controls(snap: snap, ctrl: ctrl),
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

class _SetRoundChips extends StatelessWidget {
  const _SetRoundChips({
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
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Wrap(
      spacing: 8,
      children: [
        if (totalSets > 1) Chip(label: Text(t.setRoundChip(set, totalSets))),
        Chip(label: Text(t.roundChip(round, totalRounds))),
      ],
    );
  }
}

class _Controls extends ConsumerWidget {
  const _Controls({required this.snap, required this.ctrl});

  final TimerSnapshot snap;
  final dynamic ctrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = snap.phase == TimerPhase.completed;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleIconButton(
          icon: Icons.skip_next_outlined,
          onPressed: isCompleted ? null : () => ctrl.skipPhase(),
        ),
        SizedBox(
          width: 84,
          height: 84,
          child: OutlinedButton(
            onPressed: isCompleted
                ? null
                : () => snap.isPaused ? ctrl.resume() : ctrl.pause(),
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: BorderSide(
                color: isCompleted ? scheme.outline : scheme.primary,
                width: 1.4,
              ),
              foregroundColor: scheme.primary,
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              snap.isPaused ? Icons.play_arrow : Icons.pause,
              size: 36,
            ),
          ),
        ),
        _CircleIconButton(
          icon: Icons.stop_outlined,
          onPressed: () async {
            await ctrl.stop();
            if (context.mounted) Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _TtsVolumeSlider extends ConsumerWidget {
  const _TtsVolumeSlider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final volume = ref.watch(
      settingsControllerProvider.select(
        (s) => s.value?.ttsVolume ?? 0.5,
      ),
    );
    return Row(
      children: [
        Icon(Icons.volume_down, size: 20, color: scheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Slider(
            value: volume.clamp(0.0, 1.0),
            min: 0.0,
            max: 1.0,
            label: '${(volume * 100).round()}%',
            divisions: 20,
            onChanged: (v) async {
              await ref.read(ttsSpeakerProvider).setVolume(v);
              await ref
                  .read(settingsControllerProvider.notifier)
                  .setTtsVolume(v);
            },
            semanticFormatterCallback: (v) =>
                '${t.voiceVolumeLabel} ${(v * 100).round()}%',
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.volume_up, size: 20, color: scheme.onSurfaceVariant),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 56,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: BorderSide(color: scheme.outline, width: 1),
          foregroundColor: scheme.onSurface,
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: 24),
      ),
    );
  }
}
