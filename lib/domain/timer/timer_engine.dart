import 'dart:async';

import '../clock.dart';
import '../entities/tabata_preset.dart';
import '../entities/timer_phase.dart';
import '../entities/timer_snapshot.dart';
import 'phase_transition.dart';

class TimerEngine {
  TimerEngine({
    required Clock clock,
    Duration tickInterval = const Duration(milliseconds: 100),
  })  : _clock = clock,
        _tickInterval = tickInterval;

  final Clock _clock;
  final Duration _tickInterval;

  final _snapshots = StreamController<TimerSnapshot>.broadcast();
  final _transitions = StreamController<PhaseTransition>.broadcast();
  final _countdowns = StreamController<int>.broadcast();

  TimerSnapshot _state = TimerSnapshot.idle();
  Timer? _ticker;
  DateTime? _phaseStart;
  int _phaseDurationMs = 0;
  Duration _accumPaused = Duration.zero;
  DateTime? _pausedAt;
  int _baselineElapsedMs = 0;
  int _lastCountdownSec = 0;

  TimerSnapshot get state => _state;
  Stream<TimerSnapshot> get snapshots => _snapshots.stream;
  Stream<PhaseTransition> get transitions => _transitions.stream;

  /// Emits 3, 2, 1 as the current phase reaches the final three seconds.
  /// Suppressed for phases shorter than 4 seconds (saying "3" the moment
  /// the phase begins is noise, not a countdown).
  Stream<int> get countdowns => _countdowns.stream;

  void start(TabataPreset preset) {
    _disposeTicker();
    _baselineElapsedMs = 0;
    _accumPaused = Duration.zero;
    _pausedAt = null;
    final initialPhase =
        preset.prepareSeconds > 0 ? TimerPhase.prepare : TimerPhase.work;
    final durationMs = _durationForPhase(preset, initialPhase) * 1000;
    _phaseStart = _clock.now();
    _phaseDurationMs = durationMs;
    _lastCountdownSec = (durationMs / 1000).ceil();

    _emitState(TimerSnapshot(
      preset: preset,
      phase: initialPhase,
      currentRound: 1,
      currentSet: 1,
      phaseRemainingMs: durationMs,
      phaseDurationMs: durationMs,
      totalElapsedMs: 0,
      isRunning: true,
      isPaused: false,
    ));
    _emitTransition(TimerPhase.idle, initialPhase, 1, 1);
    _ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  void pause() {
    if (!_state.isRunning || _state.isPaused) return;
    _pausedAt = _clock.now();
    _disposeTicker();
    _emitState(_state.copyWith(isPaused: true));
  }

  void resume() {
    if (!_state.isRunning || !_state.isPaused) return;
    if (_pausedAt != null) {
      _accumPaused += _clock.now().difference(_pausedAt!);
      _pausedAt = null;
    }
    _emitState(_state.copyWith(isPaused: false));
    _ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  void stop() {
    _disposeTicker();
    _emitState(TimerSnapshot.idle());
  }

  void skipPhase() {
    if (!_state.isRunning) return;
    _phaseStart = _clock
        .now()
        .subtract(Duration(milliseconds: _phaseDurationMs))
        .add(_accumPaused);
    _tick();
  }

  Future<void> dispose() async {
    _disposeTicker();
    await _snapshots.close();
    await _transitions.close();
    await _countdowns.close();
  }

  void _tick() {
    final snap = _state;
    if (!snap.isRunning || snap.isPaused) return;
    final start = _phaseStart;
    if (start == null) return;
    final elapsed = _clock.now().difference(start) - _accumPaused;
    final remainingMs =
        (_phaseDurationMs - elapsed.inMilliseconds).clamp(0, _phaseDurationMs);
    final totalElapsed = _baselineElapsedMs + elapsed.inMilliseconds;

    _emitState(snap.copyWith(
      phaseRemainingMs: remainingMs,
      totalElapsedMs: totalElapsed,
    ));

    final cur = (remainingMs / 1000).ceil();
    if (cur != _lastCountdownSec) {
      // Only fire 3/2/1 if the phase is long enough that 3-2-1 is a real
      // tail-end countdown — not the phase's opening seconds.
      if (cur >= 1 && cur <= 3 && _phaseDurationMs >= 4000) {
        _countdowns.add(cur);
      }
      _lastCountdownSec = cur;
    }

    if (remainingMs <= 0) {
      _advance();
    }
  }

  void _advance() {
    final snap = _state;
    final preset = snap.preset;
    if (preset == null) return;

    _baselineElapsedMs += _phaseDurationMs;

    final next = _nextPhase(snap, preset);
    if (next == null) {
      _disposeTicker();
      _emitState(snap.copyWith(
        phase: TimerPhase.completed,
        isRunning: false,
        phaseRemainingMs: 0,
        phaseDurationMs: 0,
      ));
      _emitTransition(snap.phase, TimerPhase.completed, snap.currentRound, snap.currentSet);
      return;
    }

    final newDurationMs = _durationForPhase(preset, next.phase) * 1000;
    _phaseStart = _clock.now();
    _phaseDurationMs = newDurationMs;
    _accumPaused = Duration.zero;
    _lastCountdownSec = (newDurationMs / 1000).ceil();

    _emitState(snap.copyWith(
      phase: next.phase,
      currentRound: next.round,
      currentSet: next.set,
      phaseRemainingMs: newDurationMs,
      phaseDurationMs: newDurationMs,
    ));
    _emitTransition(snap.phase, next.phase, next.round, next.set);
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

  void _emitState(TimerSnapshot s) {
    _state = s;
    _snapshots.add(s);
  }

  void _emitTransition(TimerPhase from, TimerPhase to, int round, int set) {
    _transitions.add(PhaseTransition(from: from, to: to, round: round, set: set));
  }

  void _disposeTicker() {
    _ticker?.cancel();
    _ticker = null;
  }
}
