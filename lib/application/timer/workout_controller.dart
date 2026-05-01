import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../di/providers.dart';
import '../../domain/clock.dart';
import '../../domain/entities/tabata_preset.dart';
import '../../domain/entities/timer_phase.dart';
import '../../domain/entities/timer_snapshot.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/services/audio_cue.dart';
import '../../domain/services/haptics.dart';
import '../../domain/services/wake_lock.dart';
import '../../domain/timer/phase_transition.dart';
import '../../domain/timer/timer_engine.dart';

class WorkoutController extends Notifier<TimerSnapshot> {
  static const _uuid = Uuid();

  late TimerEngine _engine;
  late AudioCue _audio;
  late Haptics _haptics;
  late WakeLock _wakeLock;
  late Clock _clock;

  StreamSubscription<TimerSnapshot>? _stateSub;
  StreamSubscription<PhaseTransition>? _transitionsSub;
  TabataPreset? _activePreset;
  DateTime? _startedAt;
  bool _historyRecorded = false;

  Stream<PhaseTransition> get transitions => _engine.transitions;

  @override
  TimerSnapshot build() {
    _engine = ref.watch(timerEngineProvider);
    _audio = ref.watch(audioCueProvider);
    _haptics = ref.watch(hapticsProvider);
    _wakeLock = ref.watch(wakeLockProvider);
    _clock = ref.watch(clockProvider);

    _stateSub = _engine.snapshots.listen((s) => state = s);
    _transitionsSub = _engine.transitions.listen(_onTransition);

    ref.onDispose(() async {
      await _stateSub?.cancel();
      await _transitionsSub?.cancel();
      await _wakeLock.disable();
    });

    return _engine.state;
  }

  Future<void> start(TabataPreset preset) async {
    _activePreset = preset;
    _startedAt = _clock.now();
    _historyRecorded = false;
    await _wakeLock.enable();
    _engine.start(preset);
  }

  void pause() => _engine.pause();
  void resume() => _engine.resume();
  void skipPhase() => _engine.skipPhase();

  Future<void> stop() async {
    _engine.stop();
    await _wakeLock.disable();
  }

  Future<void> _onTransition(PhaseTransition ev) async {
    switch (ev.to) {
      case TimerPhase.prepare:
        unawaited(_audio.phaseChange());
        break;
      case TimerPhase.work:
        unawaited(_audio.phaseChange());
        unawaited(_haptics.workStart());
        break;
      case TimerPhase.rest:
        unawaited(_audio.phaseChange());
        unawaited(_haptics.restStart());
        break;
      case TimerPhase.restBetweenSets:
        unawaited(_audio.phaseChange());
        unawaited(_haptics.restStart());
        break;
      case TimerPhase.completed:
        unawaited(_audio.completed());
        unawaited(_haptics.completed());
        await _recordHistory();
        await _wakeLock.disable();
        break;
      case TimerPhase.idle:
        break;
    }
  }

  Future<void> _recordHistory() async {
    if (_historyRecorded) return;
    final preset = _activePreset;
    final start = _startedAt;
    if (preset == null || start == null) return;
    _historyRecorded = true;

    final repo = await ref.read(historyRepositoryProvider.future);
    final end = _clock.now();
    final entry = WorkoutHistoryEntry(
      id: _uuid.v4(),
      presetName: preset.name,
      startedAt: start,
      completedAt: end,
      durationSeconds: end.difference(start).inSeconds,
      totalRounds: preset.rounds * preset.sets,
      totalSets: preset.sets,
    );
    await repo.add(entry);
    ref.invalidate(historyControllerProvider);
  }
}
