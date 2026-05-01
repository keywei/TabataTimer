import 'package:flutter/material.dart';

import '../../domain/entities/timer_phase.dart';

class PhaseColors {
  const PhaseColors({required this.foreground, required this.container});

  final Color foreground;
  final Color container;

  static PhaseColors of(TimerPhase phase, ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    switch (phase) {
      case TimerPhase.prepare:
        return PhaseColors(
          foreground: const Color(0xFFD4A017),
          container: isDark
              ? const Color(0xFFD4A017).withValues(alpha: 0.10)
              : const Color(0xFFD4A017).withValues(alpha: 0.08),
        );
      case TimerPhase.work:
        return PhaseColors(
          foreground: const Color(0xFFE85D04),
          container: isDark
              ? const Color(0xFFE85D04).withValues(alpha: 0.12)
              : const Color(0xFFE85D04).withValues(alpha: 0.08),
        );
      case TimerPhase.rest:
        return PhaseColors(
          foreground: const Color(0xFF1F8A4C),
          container: isDark
              ? const Color(0xFF1F8A4C).withValues(alpha: 0.12)
              : const Color(0xFF1F8A4C).withValues(alpha: 0.08),
        );
      case TimerPhase.restBetweenSets:
        return PhaseColors(
          foreground: const Color(0xFF2860C4),
          container: isDark
              ? const Color(0xFF2860C4).withValues(alpha: 0.12)
              : const Color(0xFF2860C4).withValues(alpha: 0.08),
        );
      case TimerPhase.completed:
        return PhaseColors(
          foreground: scheme.primary,
          container: scheme.primary.withValues(alpha: isDark ? 0.10 : 0.06),
        );
      case TimerPhase.idle:
        return PhaseColors(
          foreground: scheme.onSurfaceVariant,
          container: Colors.transparent,
        );
    }
  }
}
