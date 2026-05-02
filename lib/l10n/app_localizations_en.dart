// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tabata Timer';

  @override
  String get tabPresets => 'Presets';

  @override
  String get tabHistory => 'History';

  @override
  String get tabSettings => 'Settings';

  @override
  String get presetsEmpty => 'No presets yet. Tap + to create one.';

  @override
  String get newPreset => 'New preset';

  @override
  String get editPreset => 'Edit preset';

  @override
  String get actionStart => 'Start';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionSave => 'SAVE';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionStop => 'Stop';

  @override
  String deletePresetTitle(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get fieldName => 'Name';

  @override
  String get fieldPrepare => 'Prepare (seconds)';

  @override
  String get fieldWork => 'Work (seconds)';

  @override
  String get fieldRest => 'Rest (seconds)';

  @override
  String get fieldRounds => 'Rounds';

  @override
  String get fieldSets => 'Sets';

  @override
  String get fieldRestBetweenSets => 'Rest between sets (seconds)';

  @override
  String get untitled => 'Untitled';

  @override
  String get imagesSection => 'Images';

  @override
  String get imagesAdd => 'Add image';

  @override
  String imagesLimitReached(int max) {
    return 'Maximum $max images';
  }

  @override
  String get imagesEnable => 'Use';

  @override
  String get imagesReplace => 'Replace';

  @override
  String get imagesDelete => 'Delete';

  @override
  String get imagesEmpty =>
      'No images yet. Add up to 10 to display during workouts.';

  @override
  String get imageDeleteConfirm => 'Delete this image?';

  @override
  String get slideshowSection => 'Slideshow';

  @override
  String get slideshowModeOff => 'Off';

  @override
  String get slideshowModeSequential => 'Sequential';

  @override
  String get slideshowModeRandom => 'Random';

  @override
  String get slideshowInterval => 'Interval (seconds)';

  @override
  String presetSummary(
    int sets,
    int rounds,
    int work,
    int rest,
    String duration,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      sets,
      locale: localeName,
      other: '$sets sets · ',
      one: '',
    );
    return '$_temp0$rounds rounds · ${work}s work / ${rest}s rest · total $duration';
  }

  @override
  String get phasePrepare => 'GET READY';

  @override
  String get phaseWork => 'WORK';

  @override
  String get phaseRest => 'REST';

  @override
  String get phaseSetBreak => 'SET BREAK';

  @override
  String get phaseDone => 'DONE';

  @override
  String get ttsGetReady => 'Get ready';

  @override
  String get ttsWork => 'Work';

  @override
  String get ttsRest => 'Rest';

  @override
  String ttsRoundWork(int round) {
    return 'Round $round, work';
  }

  @override
  String get ttsSetComplete => 'Set complete';

  @override
  String get ttsWorkoutComplete => 'Workout complete';

  @override
  String get ttsHalfway => 'Halfway';

  @override
  String totalLabel(String time) {
    return 'Total $time';
  }

  @override
  String totalLabelWithDuration(String elapsed, String total) {
    return 'Total $elapsed / $total';
  }

  @override
  String get doneLabel => 'Done!';

  @override
  String setRoundChip(int set, int totalSets) {
    return 'Set $set / $totalSets';
  }

  @override
  String roundChip(int round, int totalRounds) {
    return 'Round $round / $totalRounds';
  }

  @override
  String get voiceVolumeLabel => 'Voice volume';

  @override
  String get stopWorkoutTitle => 'Stop workout?';

  @override
  String get stopWorkoutBody => 'Your progress will be lost.';

  @override
  String get historyEmpty =>
      'No completed workouts yet.\nFinish a session and it will show up here.';

  @override
  String get historyToday => 'Today';

  @override
  String get historyYesterday => 'Yesterday';

  @override
  String historyEntrySubtitle(int rounds, String duration) {
    return '$rounds rounds · $duration';
  }

  @override
  String get historyClearTitle => 'Clear all history?';

  @override
  String get historyClearAction => 'Clear history';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsAbout => 'About';

  @override
  String get themeSystem => 'Follow system';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '繁體中文';

  @override
  String get notifWorkoutCompleteTitle => 'Workout complete!';

  @override
  String get notifWorkoutCompleteBody =>
      'Great job — you finished your Tabata.';
}
