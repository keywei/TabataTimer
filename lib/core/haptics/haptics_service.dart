import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

class HapticsService {
  Future<bool> get _hasVibrator async {
    try {
      return (await Vibration.hasVibrator());
    } catch (_) {
      return false;
    }
  }

  Future<void> workStart() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(duration: 350);
    } else {
      await HapticFeedback.heavyImpact();
    }
  }

  Future<void> restStart() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(duration: 120);
    } else {
      await HapticFeedback.lightImpact();
    }
  }

  Future<void> tick() => HapticFeedback.selectionClick();

  Future<void> completed() async {
    if (await _hasVibrator) {
      await Vibration.vibrate(pattern: [0, 200, 100, 200, 100, 400]);
    } else {
      await HapticFeedback.heavyImpact();
    }
  }
}

final hapticsServiceProvider = Provider<HapticsService>((_) => HapticsService());
