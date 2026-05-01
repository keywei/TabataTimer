import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presets/data/tabata_preset.dart';
import 'timer_state.dart';

class PhaseTransitionEvent {
  PhaseTransitionEvent({
    required this.from,
    required this.to,
    required this.round,
    required this.set,
  });
  final TimerPhase from;
  final TimerPhase to;
  final int round;
  final int set;
}

final phaseTransitionsProvider = StreamProvider<PhaseTransitionEvent>((ref) {
  final controller = StreamController<PhaseTransitionEvent>.broadcast();
  ref.onDispose(controller.close);
  ref.read(timerControllerProvider.notifier).bindEventSink(controller);
  return controller.stream;
});

final timerControllerProvider =
    NotifierProvider<TimerController, TimerSnapshot>(TimerController.new);

class TimerController extends Notifier<TimerSnapshot> {
  Timer? _ticker;
  DateTime? _phaseStart;
  int _phaseDurationMs = 0;
  Duration _accumPaused = Duration.zero;
  DateTime? _pausedAt;
  int _baselineElapsedMs = 0;
  StreamController<PhaseTransitionEvent>? _events;

  static const _tickInterval = Duration(milliseconds: 100);

  @override
  TimerSnapshot build() {
    ref.onDispose(_disposeTicker);
    return TimerSnapshot.idle();
  }

  void bindEventSink(StreamController<PhaseTransitionEvent> sink) {
    _events = sink;
  }

  void start(TabataPreset preset) {
    _disposeTicker();
    _baselineElapsedMs = 0;
    _accumPaused = Duration.zero;
    _pausedAt = null;
    final initialPhase = preset.prepareSeconds > 0 ? TimerPhase.prepare : TimerPhase.work;
    final durationMs = _durationForPhase(preset, initialPhase) * 1000;
    _phaseStart = DateTime.now();
    _phaseDurationMs = durationMs;
    state = TimerSnapshot(
      preset: preset,
      phase: initialPhase,
      currentRound: 1,
      currentSet: 1,
      phaseRemainingMs: durationMs,
      phaseDurationMs: durationMs,
      totalElapsedMs: 0,
      isRunning: true,
      isPaused: false,
    );
    _emit(TimerPhase.idle, initialPhase, 1, 1);
    _ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  void pause() {
    if (!state.isRunning || state.isPaused) return;
    _pausedAt = DateTime.now();
    _ticker?.cancel();
    _ticker = null;
    state = state.copyWith(isPaused: true);
  }

  void resume() {
    if (!state.isRunning || !state.isPaused) return;
    if (_pausedAt != null) {
      _accumPaused += DateTime.now().difference(_pausedAt!);
      _pausedAt = null;
    }
    state = state.copyWith(isPaused: false);
    _ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  void stop() {
    _disposeTicker();
    state = TimerSnapshot.idle();
  }

  void skipPhase() {
    if (!state.isRunning) return;
    _phaseStart = DateTime.now()
        .subtract(Duration(milliseconds: _phaseDurationMs))
        .add(_accumPaused);
    _tick();
  }

  void _tick() {
    final snap = state;
    if (!snap.isRunning || snap.isPaused) return;
    final start = _phaseStart;
    if (start == null) return;
    final elapsed = DateTime.now().difference(start) - _accumPaused;
    final remainingMs = (_phaseDurationMs - elapsed.inMilliseconds).clamp(0, _phaseDurationMs);
    final totalElapsed = _baselineElapsedMs + elapsed.inMilliseconds;

    state = snap.copyWith(
      phaseRemainingMs: remainingMs,
      totalElapsedMs: totalElapsed,
    );

    if (remainingMs <= 0) {
      _advance();
    }
  }

  void _advance() {
    final snap = state;
    final preset = snap.preset;
    if (preset == null) return;

    _baselineElapsedMs += _phaseDurationMs;

    final next = _nextPhase(snap, preset);
    if (next == null) {
      _disposeTicker();
      state = snap.copyWith(
        phase: TimerPhase.completed,
        isRunning: false,
        phaseRemainingMs: 0,
        phaseDurationMs: 0,
      );
      _emit(snap.phase, TimerPhase.completed, snap.currentRound, snap.currentSet);
      return;
    }

    final newDurationMs = _durationForPhase(preset, next.phase) * 1000;
    _phaseStart = DateTime.now();
    _phaseDurationMs = newDurationMs;
    _accumPaused = Duration.zero;

    state = snap.copyWith(
      phase: next.phase,
      currentRound: next.round,
      currentSet: next.set,
      phaseRemainingMs: newDurationMs,
      phaseDurationMs: newDurationMs,
    );
    _emit(snap.phase, next.phase, next.round, next.set);
  }

  ({TimerPhase phase, int round, int set})? _nextPhase(
    TimerSnapshot snap,
    TabataPreset preset,
  ) {
    switch (snap.phase) {
      case TimerPhase.prepare:
        return (phase: TimerPhase.work, round: 1, set: snap.currentSet);
      case TimerPhase.work:
        if (snap.currentRound < preset.rounds) {
          return (
            phase: TimerPhase.rest,
            round: snap.currentRound,
            set: snap.currentSet,
          );
        }
        if (snap.currentSet < preset.sets) {
          return (
            phase: TimerPhase.restBetweenSets,
            round: snap.currentRound,
            set: snap.currentSet,
          );
        }
        return null;
      case TimerPhase.rest:
        return (
          phase: TimerPhase.work,
          round: snap.currentRound + 1,
          set: snap.currentSet,
        );
      case TimerPhase.restBetweenSets:
        return (
          phase: TimerPhase.work,
          round: 1,
          set: snap.currentSet + 1,
        );
      case TimerPhase.idle:
      case TimerPhase.completed:
        return null;
    }
  }

  int _durationForPhase(TabataPreset preset, TimerPhase phase) {
    switch (phase) {
      case TimerPhase.prepare:
        return preset.prepareSeconds;
      case TimerPhase.work:
        return preset.workSeconds;
      case TimerPhase.rest:
        return preset.restSeconds;
      case TimerPhase.restBetweenSets:
        return preset.restBetweenSetsSeconds;
      case TimerPhase.idle:
      case TimerPhase.completed:
        return 0;
    }
  }

  void _emit(TimerPhase from, TimerPhase to, int round, int set) {
    _events?.add(PhaseTransitionEvent(from: from, to: to, round: round, set: set));
  }

  void _disposeTicker() {
    _ticker?.cancel();
    _ticker = null;
  }
}
