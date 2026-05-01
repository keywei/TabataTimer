abstract class TtsSpeaker {
  Future<void> say(String message, {String? languageTag});
  Future<void> setVolume(double volume);
  Future<void> dispose();
}
