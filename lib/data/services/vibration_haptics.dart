import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import '../../domain/services/haptics.dart';

class VibrationHaptics implements Haptics {
  Future<bool> get _hasVibrator async {
    try {
      return await Vibration.hasVibrator();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> workStart() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(duration: 350);
    } else {
      await HapticFeedback.heavyImpact();
    }
  }

  @override
  Future<void> restStart() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(duration: 120);
    } else {
      await HapticFeedback.lightImpact();
    }
  }

  @override
  Future<void> tick() => HapticFeedback.selectionClick();

  @override
  Future<void> completed() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(pattern: [0, 200, 100, 200, 100, 400]);
    } else {
      await HapticFeedback.heavyImpact();
    }
  }
}
