import 'package:freezed_annotation/freezed_annotation.dart';

import 'tabata_preset.dart';
import 'timer_phase.dart';

part 'timer_snapshot.freezed.dart';

@freezed
abstract class TimerSnapshot with _$TimerSnapshot {
  const TimerSnapshot._();

  const factory TimerSnapshot({
    TabataPreset? preset,
    @Default(TimerPhase.idle) TimerPhase phase,
    @Default(1) int currentRound,
    @Default(1) int currentSet,
    @Default(0) int phaseRemainingMs,
    @Default(0) int phaseDurationMs,
    @Default(0) int totalElapsedMs,
    @Default(false) bool isRunning,
    @Default(false) bool isPaused,
  }) = _TimerSnapshot;

  factory TimerSnapshot.idle() => const TimerSnapshot();

  bool get isActive =>
      isRunning &&
      !isPaused &&
      phase != TimerPhase.idle &&
      phase != TimerPhase.completed;

  double get phaseProgress {
    if (phaseDurationMs == 0) return 0;
    return (1 - (phaseRemainingMs / phaseDurationMs)).clamp(0.0, 1.0);
  }

  int get phaseRemainingSeconds => (phaseRemainingMs / 1000).ceil();
}
