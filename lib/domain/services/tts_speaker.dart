abstract class TtsSpeaker {
  Future<void> say(String message, {String? languageTag});
  Future<void> dispose();
}
