import 'package:flutter/services.dart';

import '../../domain/services/audio_cue.dart';

class SystemAudioCue implements AudioCue {
  const SystemAudioCue();

  @override
  Future<void> phaseChange() => SystemSound.play(SystemSoundType.alert);

  @override
  Future<void> tick() => SystemSound.play(SystemSoundType.click);

  @override
  Future<void> completed() async {
    await SystemSound.play(SystemSoundType.alert);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    await SystemSound.play(SystemSoundType.alert);
  }
}
