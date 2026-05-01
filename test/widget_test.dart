import 'package:flutter_test/flutter_test.dart';
import 'package:tabata_timer/features/presets/data/tabata_preset.dart';
import 'package:tabata_timer/features/timer/domain/timer_state.dart';

void main() {
  group('TabataPreset', () {
    test('totalSeconds includes prepare, work, rest, sets break', () {
      const p = TabataPreset(
        id: 'a',
        name: 'test',
        prepareSeconds: 10,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
        sets: 1,
      );
      // 10 prepare + 8*20 work + 7*10 rest = 10 + 160 + 70 = 240
      expect(p.totalSeconds, 240);
    });

    test('totalSeconds with multiple sets includes set rest', () {
      const p = TabataPreset(
        id: 'b',
        name: 'test2',
        prepareSeconds: 10,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
        sets: 2,
        restBetweenSetsSeconds: 60,
      );
      // per set: 8*20 + 7*10 = 230
      // 10 prepare + 2*230 + 1*60 = 530
      expect(p.totalSeconds, 530);
    });
  });

  group('TimerSnapshot', () {
    test('phaseProgress is 0 when phaseDurationMs is 0', () {
      const snap = TimerSnapshot();
      expect(snap.phaseProgress, 0);
    });

    test('phaseProgress reflects elapsed fraction', () {
      const snap = TimerSnapshot(
        phaseDurationMs: 10000,
        phaseRemainingMs: 2500,
      );
      expect(snap.phaseProgress, closeTo(0.75, 0.001));
    });

    test('phaseRemainingSeconds rounds up', () {
      const snap = TimerSnapshot(
        phaseDurationMs: 10000,
        phaseRemainingMs: 2400,
      );
      expect(snap.phaseRemainingSeconds, 3);
    });
  });
}
