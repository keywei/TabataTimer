import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/timer_phase.dart';

part 'phase_transition.freezed.dart';

@freezed
abstract class PhaseTransition with _$PhaseTransition {
  const factory PhaseTransition({
    required TimerPhase from,
    required TimerPhase to,
    required int round,
    required int set,
  }) = _PhaseTransition;
}
