import 'package:clock/clock.dart' as pkg;

/// Abstraction over wall-clock reads so that domain code never calls
/// `DateTime.now()` directly. The default [SystemClock] delegates to
/// `package:clock`, which means tests using `fakeAsync` automatically get
/// the fake time without having to inject a different clock.
abstract class Clock {
  DateTime now();
}

class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => pkg.clock.now();
}
