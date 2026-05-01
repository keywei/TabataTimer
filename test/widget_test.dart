import 'package:flutter_test/flutter_test.dart';
import 'package:tabata_timer/domain/clock.dart';
import 'package:tabata_timer/domain/entities/tabata_preset.dart';
import 'package:tabata_timer/domain/entities/timer_phase.dart';
import 'package:tabata_timer/domain/entities/timer_snapshot.dart';
import 'package:tabata_timer/domain/timer/timer_engine.dart';

class _FakeClock implements Clock {
  DateTime current;
  _FakeClock(this.current);
  @override
  DateTime now() => current;
}

void main() {
  group('TabataPreset', () {
    test('totalSeconds includes prepare, work, rest', () {
      const p = TabataPreset(
        id: 'a', name: 't',
        prepareSeconds: 10, workSeconds: 20, restSeconds: 10,
        rounds: 8, sets: 1,
      );
      expect(p.totalSeconds, 240); // 10 + 8*20 + 7*10
    });

    test('totalSeconds with multiple sets', () {
      const p = TabataPreset(
        id: 'b', name: 't',
        prepareSeconds: 10, workSeconds: 20, restSeconds: 10,
        rounds: 8, sets: 2, restBetweenSetsSeconds: 60,
      );
      expect(p.totalSeconds, 530); // 10 + 2*230 + 1*60
    });
  });

  group('TimerSnapshot', () {
    test('phaseProgress is 0 when phaseDurationMs is 0', () {
      const snap = TimerSnapshot();
      expect(snap.phaseProgress, 0);
    });
    test('phaseProgress reflects elapsed fraction', () {
      const snap = TimerSnapshot(phaseDurationMs: 10000, phaseRemainingMs: 2500);
      expect(snap.phaseProgress, closeTo(0.75, 0.001));
    });
    test('phaseRemainingSeconds rounds up', () {
      const snap = TimerSnapshot(phaseDurationMs: 10000, phaseRemainingMs: 2400);
      expect(snap.phaseRemainingSeconds, 3);
    });
  });

  group('TimerEngine state machine', () {
    test('starts in prepare phase when prepareSeconds > 0', () {
      final engine = TimerEngine(clock: _FakeClock(DateTime(2026)));
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 5, workSeconds: 10, restSeconds: 5,
        rounds: 2,
      );
      engine.start(preset);
      expect(engine.state.phase, TimerPhase.prepare);
      expect(engine.state.currentRound, 1);
      expect(engine.state.currentSet, 1);
      expect(engine.state.isRunning, true);
    });

    test('skips prepare when prepareSeconds == 0', () {
      final engine = TimerEngine(clock: _FakeClock(DateTime(2026)));
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 0, workSeconds: 10, restSeconds: 5,
        rounds: 2,
      );
      engine.start(preset);
      expect(engine.state.phase, TimerPhase.work);
    });

    test('skipPhase advances prepare -> work -> rest -> work', () async {
      final clock = _FakeClock(DateTime(2026));
      final engine = TimerEngine(clock: clock);
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 5, workSeconds: 10, restSeconds: 5,
        rounds: 2,
      );
      engine.start(preset);
      expect(engine.state.phase, TimerPhase.prepare);

      engine.skipPhase();
      expect(engine.state.phase, TimerPhase.work);
      expect(engine.state.currentRound, 1);

      engine.skipPhase();
      expect(engine.state.phase, TimerPhase.rest);
      expect(engine.state.currentRound, 1);

      engine.skipPhase();
      expect(engine.state.phase, TimerPhase.work);
      expect(engine.state.currentRound, 2);

      engine.skipPhase();
      expect(engine.state.phase, TimerPhase.completed);
      expect(engine.state.isRunning, false);

      await engine.dispose();
    });

    test('multi-set: ends a set with restBetweenSets', () async {
      final engine = TimerEngine(clock: _FakeClock(DateTime(2026)));
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 0, workSeconds: 10, restSeconds: 5,
        rounds: 2, sets: 2, restBetweenSetsSeconds: 30,
      );
      engine.start(preset);
      expect(engine.state.phase, TimerPhase.work);

      engine.skipPhase(); // -> rest 1/1
      expect(engine.state.phase, TimerPhase.rest);

      engine.skipPhase(); // -> work 2/1
      expect(engine.state.phase, TimerPhase.work);
      expect(engine.state.currentRound, 2);

      engine.skipPhase(); // -> restBetweenSets
      expect(engine.state.phase, TimerPhase.restBetweenSets);

      engine.skipPhase(); // -> work 1/2
      expect(engine.state.phase, TimerPhase.work);
      expect(engine.state.currentRound, 1);
      expect(engine.state.currentSet, 2);

      await engine.dispose();
    });

    test('pause then resume keeps phase', () async {
      final engine = TimerEngine(clock: _FakeClock(DateTime(2026)));
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 0, workSeconds: 20, restSeconds: 10,
        rounds: 3,
      );
      engine.start(preset);
      engine.pause();
      expect(engine.state.isPaused, true);
      engine.resume();
      expect(engine.state.isPaused, false);
      expect(engine.state.phase, TimerPhase.work);

      await engine.dispose();
    });

    test('stop returns to idle', () async {
      final engine = TimerEngine(clock: _FakeClock(DateTime(2026)));
      const preset = TabataPreset(
        id: 'x', name: 'p',
        prepareSeconds: 0, workSeconds: 20, restSeconds: 10,
        rounds: 3,
      );
      engine.start(preset);
      engine.stop();
      expect(engine.state.phase, TimerPhase.idle);
      expect(engine.state.isRunning, false);

      await engine.dispose();
    });
  });
}
