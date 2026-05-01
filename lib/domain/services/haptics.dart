abstract class Haptics {
  Future<void> workStart();
  Future<void> restStart();
  Future<void> tick();
  Future<void> completed();
}
