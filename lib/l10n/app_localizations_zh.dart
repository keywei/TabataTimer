// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Tabata 計時器';

  @override
  String get tabPresets => '預設';

  @override
  String get tabHistory => '紀錄';

  @override
  String get tabSettings => '設定';

  @override
  String get presetsEmpty => '還沒有預設。點 + 建立一個。';

  @override
  String get newPreset => '新增預設';

  @override
  String get editPreset => '編輯預設';

  @override
  String get actionStart => '開始';

  @override
  String get actionEdit => '編輯';

  @override
  String get actionSave => '儲存';

  @override
  String get actionCancel => '取消';

  @override
  String get actionDelete => '刪除';

  @override
  String get actionContinue => '繼續';

  @override
  String get actionStop => '停止';

  @override
  String deletePresetTitle(String name) {
    return '刪除「$name」?';
  }

  @override
  String get fieldName => '名稱';

  @override
  String get fieldPrepare => '準備時間(秒)';

  @override
  String get fieldWork => '訓練時間(秒)';

  @override
  String get fieldRest => '休息時間(秒)';

  @override
  String get fieldRounds => '回合數';

  @override
  String get fieldSets => '組數';

  @override
  String get fieldRestBetweenSets => '組間休息(秒)';

  @override
  String get untitled => '未命名';

  @override
  String get imagesSection => '圖片';

  @override
  String get imagesAdd => '加入圖片';

  @override
  String imagesLimitReached(int max) {
    return '最多 $max 張';
  }

  @override
  String get imagesEnable => '使用';

  @override
  String get imagesReplace => '更換';

  @override
  String get imagesDelete => '刪除';

  @override
  String get imagesEmpty => '尚未加入圖片。最多可加 10 張在訓練時顯示。';

  @override
  String get imageDeleteConfirm => '刪除這張圖片?';

  @override
  String get slideshowSection => '輪播';

  @override
  String get slideshowModeOff => '關閉';

  @override
  String get slideshowModeSequential => '依序';

  @override
  String get slideshowModeRandom => '隨機';

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
      other: '$sets 組 · ',
      one: '',
    );
    return '$_temp0$rounds 回合 · 訓練 ${work}s / 休息 ${rest}s · 總時長 $duration';
  }

  @override
  String get phasePrepare => '準備';

  @override
  String get phaseWork => '訓練';

  @override
  String get phaseRest => '休息';

  @override
  String get phaseSetBreak => '組間休息';

  @override
  String get phaseDone => '完成';

  @override
  String get ttsGetReady => '準備開始';

  @override
  String get ttsWork => '訓練開始';

  @override
  String get ttsRest => '休息';

  @override
  String ttsRoundWork(int round) {
    return '第 $round 回合,訓練開始';
  }

  @override
  String get ttsSetComplete => '本組完成';

  @override
  String get ttsWorkoutComplete => '訓練結束';

  @override
  String get ttsHalfway => '過半';

  @override
  String totalLabel(String time) {
    return '總計 $time';
  }

  @override
  String totalLabelWithDuration(String elapsed, String total) {
    return '總計 $elapsed / $total';
  }

  @override
  String get doneLabel => '完成!';

  @override
  String setRoundChip(int set, int totalSets) {
    return '第 $set / $totalSets 組';
  }

  @override
  String roundChip(int round, int totalRounds) {
    return '第 $round / $totalRounds 回合';
  }

  @override
  String get voiceVolumeLabel => '語音音量';

  @override
  String get stopWorkoutTitle => '停止訓練?';

  @override
  String get stopWorkoutBody => '進度將會遺失。';

  @override
  String get historyEmpty => '尚無完成的訓練紀錄。\n完成一次訓練後會顯示在這裡。';

  @override
  String get historyToday => '今天';

  @override
  String get historyYesterday => '昨天';

  @override
  String historyEntrySubtitle(int rounds, String duration) {
    return '$rounds 回合 · $duration';
  }

  @override
  String get historyClearTitle => '清除所有紀錄?';

  @override
  String get historyClearAction => '清除紀錄';

  @override
  String get historyDeleteConfirm => '刪除這筆紀錄?';

  @override
  String get historyExport => '匯出';

  @override
  String get historyImport => '匯入';

  @override
  String get historyExportEmpty => '目前沒有紀錄可匯出。';

  @override
  String get historyImportNothing => '檔案中沒有可匯入的紀錄。';

  @override
  String historyImportFailed(String message) {
    return '讀取檔案失敗:$message';
  }

  @override
  String historyImportTitle(int count) {
    return '要匯入 $count 筆紀錄嗎?';
  }

  @override
  String get historyImportMerge => '合併';

  @override
  String get historyImportReplace => '全部取代';

  @override
  String historyImportMergedToast(int count) {
    return '新增了 $count 筆紀錄。';
  }

  @override
  String historyImportReplacedToast(int count) {
    return '已用 $count 筆紀錄取代。';
  }

  @override
  String get historyImportNoNewToast => '所有紀錄都已存在。';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsTheme => '主題';

  @override
  String get settingsAbout => '關於';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '明亮';

  @override
  String get themeDark => '深色';

  @override
  String get languageSystem => '系統預設';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '繁體中文';

  @override
  String get notifWorkoutCompleteTitle => '訓練完成!';

  @override
  String get notifWorkoutCompleteBody => '做得好,你完成了這次 Tabata。';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'Tabata 計時器';

  @override
  String get tabPresets => '預設';

  @override
  String get tabHistory => '紀錄';

  @override
  String get tabSettings => '設定';

  @override
  String get presetsEmpty => '還沒有預設。點 + 建立一個。';

  @override
  String get newPreset => '新增預設';

  @override
  String get editPreset => '編輯預設';

  @override
  String get actionStart => '開始';

  @override
  String get actionEdit => '編輯';

  @override
  String get actionSave => '儲存';

  @override
  String get actionCancel => '取消';

  @override
  String get actionDelete => '刪除';

  @override
  String get actionContinue => '繼續';

  @override
  String get actionStop => '停止';

  @override
  String deletePresetTitle(String name) {
    return '刪除「$name」?';
  }

  @override
  String get fieldName => '名稱';

  @override
  String get fieldPrepare => '準備時間(秒)';

  @override
  String get fieldWork => '訓練時間(秒)';

  @override
  String get fieldRest => '休息時間(秒)';

  @override
  String get fieldRounds => '回合數';

  @override
  String get fieldSets => '組數';

  @override
  String get fieldRestBetweenSets => '組間休息(秒)';

  @override
  String get untitled => '未命名';

  @override
  String get imagesSection => '圖片';

  @override
  String get imagesAdd => '加入圖片';

  @override
  String imagesLimitReached(int max) {
    return '最多 $max 張';
  }

  @override
  String get imagesEnable => '使用';

  @override
  String get imagesReplace => '更換';

  @override
  String get imagesDelete => '刪除';

  @override
  String get imagesEmpty => '尚未加入圖片。最多可加 10 張在訓練時顯示。';

  @override
  String get imageDeleteConfirm => '刪除這張圖片?';

  @override
  String get slideshowSection => '輪播';

  @override
  String get slideshowModeOff => '關閉';

  @override
  String get slideshowModeSequential => '依序';

  @override
  String get slideshowModeRandom => '隨機';

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
      other: '$sets 組 · ',
      one: '',
    );
    return '$_temp0$rounds 回合 · 訓練 ${work}s / 休息 ${rest}s · 總時長 $duration';
  }

  @override
  String get phasePrepare => '準備';

  @override
  String get phaseWork => '訓練';

  @override
  String get phaseRest => '休息';

  @override
  String get phaseSetBreak => '組間休息';

  @override
  String get phaseDone => '完成';

  @override
  String get ttsGetReady => '準備開始';

  @override
  String get ttsWork => '訓練開始';

  @override
  String get ttsRest => '休息';

  @override
  String ttsRoundWork(int round) {
    return '第 $round 回合,訓練開始';
  }

  @override
  String get ttsSetComplete => '本組完成';

  @override
  String get ttsWorkoutComplete => '訓練結束';

  @override
  String get ttsHalfway => '過半';

  @override
  String totalLabel(String time) {
    return '總計 $time';
  }

  @override
  String totalLabelWithDuration(String elapsed, String total) {
    return '總計 $elapsed / $total';
  }

  @override
  String get doneLabel => '完成!';

  @override
  String setRoundChip(int set, int totalSets) {
    return '第 $set / $totalSets 組';
  }

  @override
  String roundChip(int round, int totalRounds) {
    return '第 $round / $totalRounds 回合';
  }

  @override
  String get voiceVolumeLabel => '語音音量';

  @override
  String get stopWorkoutTitle => '停止訓練?';

  @override
  String get stopWorkoutBody => '進度將會遺失。';

  @override
  String get historyEmpty => '尚無完成的訓練紀錄。\n完成一次訓練後會顯示在這裡。';

  @override
  String get historyToday => '今天';

  @override
  String get historyYesterday => '昨天';

  @override
  String historyEntrySubtitle(int rounds, String duration) {
    return '$rounds 回合 · $duration';
  }

  @override
  String get historyClearTitle => '清除所有紀錄?';

  @override
  String get historyClearAction => '清除紀錄';

  @override
  String get historyDeleteConfirm => '刪除這筆紀錄?';

  @override
  String get historyExport => '匯出';

  @override
  String get historyImport => '匯入';

  @override
  String get historyExportEmpty => '目前沒有紀錄可匯出。';

  @override
  String get historyImportNothing => '檔案中沒有可匯入的紀錄。';

  @override
  String historyImportFailed(String message) {
    return '讀取檔案失敗:$message';
  }

  @override
  String historyImportTitle(int count) {
    return '要匯入 $count 筆紀錄嗎?';
  }

  @override
  String get historyImportMerge => '合併';

  @override
  String get historyImportReplace => '全部取代';

  @override
  String historyImportMergedToast(int count) {
    return '新增了 $count 筆紀錄。';
  }

  @override
  String historyImportReplacedToast(int count) {
    return '已用 $count 筆紀錄取代。';
  }

  @override
  String get historyImportNoNewToast => '所有紀錄都已存在。';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsTheme => '主題';

  @override
  String get settingsAbout => '關於';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '明亮';

  @override
  String get themeDark => '深色';

  @override
  String get languageSystem => '系統預設';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '繁體中文';

  @override
  String get notifWorkoutCompleteTitle => '訓練完成!';

  @override
  String get notifWorkoutCompleteBody => '做得好,你完成了這次 Tabata。';
}
