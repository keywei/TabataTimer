import 'package:wakelock_plus/wakelock_plus.dart';

import '../../domain/services/wake_lock.dart';

class WakelockPlusLock implements WakeLock {
  const WakelockPlusLock();

  @override
  Future<void> enable() => WakelockPlus.enable();

  @override
  Future<void> disable() => WakelockPlus.disable();
}
