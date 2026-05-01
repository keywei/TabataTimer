import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../../domain/services/background_keepalive.dart';

/// Plays a near-inaudible looping silence track to keep the iOS audio
/// session active during a workout. iOS only grants background CPU time
/// while audio is being produced; without this, the Dart timer pauses as
/// soon as the app is backgrounded between TTS announcements.
class SilentLoopKeepAlive implements BackgroundKeepAlive {
  SilentLoopKeepAlive();

  final AudioPlayer _player = AudioPlayer();
  bool _prepared = false;
  bool _enabled = false;

  Future<void> _prepare() async {
    if (_prepared) return;
    await _player.setAsset('assets/audio/silence.wav');
    await _player.setLoopMode(LoopMode.all);
    await _player.setVolume(0.01);
    _prepared = true;
  }

  @override
  Future<void> enable() async {
    if (_enabled) return;
    _enabled = true;
    await _prepare();
    // play() returns a Future that completes when playback ends, not when it
    // starts — awaiting it would deadlock with LoopMode.all.
    unawaited(_player.play());
  }

  @override
  Future<void> disable() async {
    if (!_enabled) return;
    _enabled = false;
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
