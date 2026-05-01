import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioCueService {
  Future<void> tick() => SystemSound.play(SystemSoundType.click);
  Future<void> phaseChange() => SystemSound.play(SystemSoundType.alert);
  Future<void> completed() async {
    await SystemSound.play(SystemSoundType.alert);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    await SystemSound.play(SystemSoundType.alert);
  }
}

final audioCueServiceProvider = Provider<AudioCueService>((_) => AudioCueService());
