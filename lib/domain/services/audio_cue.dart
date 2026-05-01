abstract class AudioCue {
  Future<void> phaseChange();
  Future<void> tick();
  Future<void> completed();
}
