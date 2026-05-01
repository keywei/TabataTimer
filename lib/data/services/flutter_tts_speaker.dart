import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/services/tts_speaker.dart';

class FlutterTtsSpeaker implements TtsSpeaker {
  FlutterTtsSpeaker() {
    _tts = FlutterTts();
    _init();
  }

  late final FlutterTts _tts;
  bool _ready = false;
  String? _currentLang;

  Future<void> _init() async {
    try {
      await _tts.setSharedInstance(true);
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        ],
        IosTextToSpeechAudioMode.spokenAudio,
      );
      await _tts.setSpeechRate(0.55);
      await _tts.setVolume(0.5);
      await _tts.setPitch(1.0);
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  Future<void> _ensureLanguage(String? bcp47) async {
    if (bcp47 == null || bcp47 == _currentLang) return;
    try {
      await _tts.setLanguage(bcp47);
      _currentLang = bcp47;
    } catch (_) {}
  }

  @override
  Future<void> say(String message, {String? languageTag}) async {
    if (!_ready) return;
    try {
      await _ensureLanguage(languageTag);
      await _tts.stop();
      await _tts.speak(message);
    } catch (_) {}
  }

  @override
  Future<void> dispose() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}
