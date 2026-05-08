import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tabata Timer'**
  String get appTitle;

  /// No description provided for @tabPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get tabPresets;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @presetsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No presets yet. Tap + to create one.'**
  String get presetsEmpty;

  /// No description provided for @newPreset.
  ///
  /// In en, this message translates to:
  /// **'New preset'**
  String get newPreset;

  /// No description provided for @editPreset.
  ///
  /// In en, this message translates to:
  /// **'Edit preset'**
  String get editPreset;

  /// No description provided for @actionStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get actionStart;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get actionStop;

  /// No description provided for @deletePresetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String deletePresetTitle(String name);

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldPrepare.
  ///
  /// In en, this message translates to:
  /// **'Prepare (seconds)'**
  String get fieldPrepare;

  /// No description provided for @fieldWork.
  ///
  /// In en, this message translates to:
  /// **'Work (seconds)'**
  String get fieldWork;

  /// No description provided for @fieldRest.
  ///
  /// In en, this message translates to:
  /// **'Rest (seconds)'**
  String get fieldRest;

  /// No description provided for @fieldRounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get fieldRounds;

  /// No description provided for @fieldSets.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get fieldSets;

  /// No description provided for @fieldRestBetweenSets.
  ///
  /// In en, this message translates to:
  /// **'Rest between sets (seconds)'**
  String get fieldRestBetweenSets;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @imagesSection.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get imagesSection;

  /// No description provided for @imagesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get imagesAdd;

  /// No description provided for @imagesLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} images'**
  String imagesLimitReached(int max);

  /// No description provided for @imagesEnable.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get imagesEnable;

  /// No description provided for @imagesReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get imagesReplace;

  /// No description provided for @imagesDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get imagesDelete;

  /// No description provided for @imagesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No images yet. Add up to 10 to display during workouts.'**
  String get imagesEmpty;

  /// No description provided for @imageDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this image?'**
  String get imageDeleteConfirm;

  /// No description provided for @slideshowSection.
  ///
  /// In en, this message translates to:
  /// **'Slideshow'**
  String get slideshowSection;

  /// No description provided for @slideshowModeOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get slideshowModeOff;

  /// No description provided for @slideshowModeSequential.
  ///
  /// In en, this message translates to:
  /// **'Sequential'**
  String get slideshowModeSequential;

  /// No description provided for @slideshowModeRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get slideshowModeRandom;

  /// No description provided for @presetSummary.
  ///
  /// In en, this message translates to:
  /// **'{sets, plural, =1{} other{{sets} sets · }}{rounds} rounds · {work}s work / {rest}s rest · total {duration}'**
  String presetSummary(
    int sets,
    int rounds,
    int work,
    int rest,
    String duration,
  );

  /// No description provided for @phasePrepare.
  ///
  /// In en, this message translates to:
  /// **'GET READY'**
  String get phasePrepare;

  /// No description provided for @phaseWork.
  ///
  /// In en, this message translates to:
  /// **'WORK'**
  String get phaseWork;

  /// No description provided for @phaseRest.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get phaseRest;

  /// No description provided for @phaseSetBreak.
  ///
  /// In en, this message translates to:
  /// **'SET BREAK'**
  String get phaseSetBreak;

  /// No description provided for @phaseDone.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get phaseDone;

  /// No description provided for @ttsGetReady.
  ///
  /// In en, this message translates to:
  /// **'Get ready'**
  String get ttsGetReady;

  /// No description provided for @ttsWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get ttsWork;

  /// No description provided for @ttsRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get ttsRest;

  /// No description provided for @ttsRoundWork.
  ///
  /// In en, this message translates to:
  /// **'Round {round}, work'**
  String ttsRoundWork(int round);

  /// No description provided for @ttsSetComplete.
  ///
  /// In en, this message translates to:
  /// **'Set complete'**
  String get ttsSetComplete;

  /// No description provided for @ttsWorkoutComplete.
  ///
  /// In en, this message translates to:
  /// **'Workout complete'**
  String get ttsWorkoutComplete;

  /// No description provided for @ttsHalfway.
  ///
  /// In en, this message translates to:
  /// **'Halfway'**
  String get ttsHalfway;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total {time}'**
  String totalLabel(String time);

  /// No description provided for @totalLabelWithDuration.
  ///
  /// In en, this message translates to:
  /// **'Total {elapsed} / {total}'**
  String totalLabelWithDuration(String elapsed, String total);

  /// No description provided for @doneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get doneLabel;

  /// No description provided for @setRoundChip.
  ///
  /// In en, this message translates to:
  /// **'Set {set} / {totalSets}'**
  String setRoundChip(int set, int totalSets);

  /// No description provided for @roundChip.
  ///
  /// In en, this message translates to:
  /// **'Round {round} / {totalRounds}'**
  String roundChip(int round, int totalRounds);

  /// No description provided for @voiceVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Voice volume'**
  String get voiceVolumeLabel;

  /// No description provided for @stopWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop workout?'**
  String get stopWorkoutTitle;

  /// No description provided for @stopWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress will be lost.'**
  String get stopWorkoutBody;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No completed workouts yet.\nFinish a session and it will show up here.'**
  String get historyEmpty;

  /// No description provided for @historyToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get historyToday;

  /// No description provided for @historyYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get historyYesterday;

  /// No description provided for @historyEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{rounds} rounds · {duration}'**
  String historyEntrySubtitle(int rounds, String duration);

  /// No description provided for @historyClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all history?'**
  String get historyClearTitle;

  /// No description provided for @historyClearAction.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get historyClearAction;

  /// No description provided for @historyDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get historyDeleteConfirm;

  /// No description provided for @historyExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get historyExport;

  /// No description provided for @historyImport.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get historyImport;

  /// No description provided for @historyExportEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history to export.'**
  String get historyExportEmpty;

  /// No description provided for @historyImportNothing.
  ///
  /// In en, this message translates to:
  /// **'No entries found in file.'**
  String get historyImportNothing;

  /// No description provided for @historyImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read file: {message}'**
  String historyImportFailed(String message);

  /// No description provided for @historyImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import {count} entries?'**
  String historyImportTitle(int count);

  /// No description provided for @historyImportMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get historyImportMerge;

  /// No description provided for @historyImportReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace all'**
  String get historyImportReplace;

  /// No description provided for @historyImportMergedToast.
  ///
  /// In en, this message translates to:
  /// **'Added {count} new entries.'**
  String historyImportMergedToast(int count);

  /// No description provided for @historyImportReplacedToast.
  ///
  /// In en, this message translates to:
  /// **'Replaced with {count} entries.'**
  String historyImportReplacedToast(int count);

  /// No description provided for @historyImportNoNewToast.
  ///
  /// In en, this message translates to:
  /// **'All entries already in history.'**
  String get historyImportNoNewToast;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsPasswordSection.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsPasswordSection;

  /// No description provided for @settingsPasswordSet.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get settingsPasswordSet;

  /// No description provided for @settingsPasswordChange.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsPasswordChange;

  /// No description provided for @settingsPasswordRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove password'**
  String get settingsPasswordRemove;

  /// No description provided for @settingsPasswordExplain.
  ///
  /// In en, this message translates to:
  /// **'Required to delete history entries.'**
  String get settingsPasswordExplain;

  /// No description provided for @passwordPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordPromptTitle;

  /// No description provided for @passwordSetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get passwordSetTitle;

  /// No description provided for @passwordCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get passwordCurrentLabel;

  /// No description provided for @passwordNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get passwordNewLabel;

  /// No description provided for @passwordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirmLabel;

  /// No description provided for @passwordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get passwordIncorrect;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordMismatch;

  /// No description provided for @passwordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password can\'t be empty'**
  String get passwordEmpty;

  /// No description provided for @passwordSetToast.
  ///
  /// In en, this message translates to:
  /// **'Password set.'**
  String get passwordSetToast;

  /// No description provided for @passwordRemovedToast.
  ///
  /// In en, this message translates to:
  /// **'Password removed.'**
  String get passwordRemovedToast;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'繁體中文'**
  String get languageChinese;

  /// No description provided for @notifWorkoutCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout complete!'**
  String get notifWorkoutCompleteTitle;

  /// No description provided for @notifWorkoutCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'Great job — you finished your Tabata.'**
  String get notifWorkoutCompleteBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
