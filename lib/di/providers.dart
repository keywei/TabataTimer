import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../application/history/history_controller.dart';
import '../application/presets/presets_controller.dart';
import '../application/settings/settings_controller.dart';
import '../application/timer/workout_controller.dart';
import '../data/repositories/shared_prefs_history_repository.dart';
import '../data/repositories/shared_prefs_preset_repository.dart';
import '../data/repositories/shared_prefs_settings_repository.dart';
import '../data/services/flutter_local_workout_notifier.dart';
import '../data/services/flutter_tts_speaker.dart';
import '../data/services/system_audio_cue.dart';
import '../data/services/vibration_haptics.dart';
import '../data/services/wakelock_plus_lock.dart';
import '../domain/clock.dart';
import '../domain/entities/app_settings.dart';
import '../domain/entities/tabata_preset.dart';
import '../domain/entities/timer_snapshot.dart';
import '../domain/entities/workout_history_entry.dart';
import '../domain/repositories/history_repository.dart';
import '../domain/repositories/preset_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/services/audio_cue.dart';
import '../domain/services/haptics.dart';
import '../domain/services/tts_speaker.dart';
import '../domain/services/wake_lock.dart';
import '../domain/services/workout_notifier.dart';
import '../domain/timer/timer_engine.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((_) {
  return SharedPreferences.getInstance();
});

final clockProvider = Provider<Clock>((_) => const SystemClock());

final presetRepositoryProvider = FutureProvider<PresetRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SharedPrefsPresetRepository(prefs);
});

final historyRepositoryProvider = FutureProvider<HistoryRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SharedPrefsHistoryRepository(prefs);
});

final settingsRepositoryProvider =
    FutureProvider<SettingsRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SharedPrefsSettingsRepository(prefs);
});

final audioCueProvider = Provider<AudioCue>((_) => const SystemAudioCue());
final hapticsProvider = Provider<Haptics>((_) => VibrationHaptics());
final wakeLockProvider = Provider<WakeLock>((_) => const WakelockPlusLock());

final ttsSpeakerProvider = Provider<TtsSpeaker>((ref) {
  final s = FlutterTtsSpeaker();
  ref.onDispose(s.dispose);
  return s;
});

final workoutNotifierProvider = FutureProvider<WorkoutNotifier>((_) {
  return FlutterLocalWorkoutNotifier.create();
});

final timerEngineProvider = Provider<TimerEngine>((ref) {
  final engine = TimerEngine(clock: ref.watch(clockProvider));
  ref.onDispose(engine.dispose);
  return engine;
});

final presetsControllerProvider =
    AsyncNotifierProvider<PresetsController, List<TabataPreset>>(
  PresetsController.new,
);

final historyControllerProvider =
    AsyncNotifierProvider<HistoryController, List<WorkoutHistoryEntry>>(
  HistoryController.new,
);

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, AppSettings>(
  SettingsController.new,
);

final workoutControllerProvider =
    NotifierProvider<WorkoutController, TimerSnapshot>(WorkoutController.new);
