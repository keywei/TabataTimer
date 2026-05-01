import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService() {
    _tts = FlutterTts();
    _init();
  }

  late final FlutterTts _tts;
  bool _ready = false;
  String? _currentLang;

  Future<void> _init() async {
    try {
      await _tts.setSpeechRate(0.55);
      await _tts.setVolume(1.0);
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

  Future<void> say(String message, {String? languageTag}) async {
    if (!_ready) return;
    try {
      await _ensureLanguage(languageTag);
      await _tts.stop();
      await _tts.speak(message);
    } catch (_) {}
  }

  Future<void> dispose() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}

final ttsServiceProvider = Provider<TtsService>((ref) {
  final s = TtsService();
  ref.onDispose(s.dispose);
  return s;
});
