# Tabata Timer

一個 Tabata 間歇訓練 App,用 Flutter 寫,跑 iOS / Android。重點是 **離線可用、訓練中鎖屏不停、語音 / 震動 / 音效提示、可自訂預設、有歷史紀錄**。

> 這份 README 同時是一份「**這個專案怎麼設計**」的學習文件。每一層都解釋了**做什麼**、**為什麼這樣分**、**怎麼跟別層互動**,以及在哪些檔案裡。

---

## 目錄

1. [產品功能](#產品功能)
2. [技術棧](#技術棧)
3. [整體架構:Clean Architecture 四層](#整體架構clean-architecture-四層)
4. [Domain 層](#domain-層)
5. [Data 層](#data-層)
6. [Application 層](#application-層)
7. [Presentation 層](#presentation-層)
8. [DI(依賴注入)](#di依賴注入)
9. [一個請求穿過四層的完整範例](#一個請求穿過四層的完整範例)
10. [關鍵設計模式](#關鍵設計模式)
11. [檔案地圖](#檔案地圖)
12. [開發指令](#開發指令)

---

## 產品功能

| 模組 | 內容 |
|---|---|
| **Tabata 計時** | 準備 → 工作 → 休息,多回合多組,組間休息;可暫停 / 繼續 / 跳段 / 停止 |
| **預設管理** | 內建 3 套(Classic Tabata / HIIT 30/15 / Double Tabata);可新增、編輯、左滑刪除 |
| **歷史紀錄** | 完成訓練自動寫入,依「今天 / 昨天 / 日期」分組,上限 200 筆,可一鍵清空 |
| **多語系** | English + 繁體中文,語音提示也跟著切 |
| **主題** | Material 3 明亮 / 深色 / 跟隨系統 |
| **音效震動** | 區段切換 SystemSound + 震動,完成 TTS 語音「Workout complete」/「訓練結束」 |
| **離線** | 不用網路、不用後端,所有資料都在本機 (`shared_preferences`) |
| **鎖屏防睡** | 訓練中啟用 `WakelockPlus`,訓練結束自動解除 |

---

## 技術棧

| 層級 | 套件 | 為什麼 |
|---|---|---|
| Framework | Flutter 3.x + Dart 3.x | 一份程式碼跑 iOS / Android |
| 狀態管理 | `flutter_riverpod` 2.x | 型別安全、可組合、不依賴 BuildContext、好測試 |
| 路由 | `go_router` 14 | 宣告式、支援 ShellRoute / deep link |
| 不可變模型 | `freezed` 3.x + `json_serializable` | 編譯期生成 `copyWith` / equality / JSON,省大量樣板 |
| 本機儲存 | `shared_preferences` | Tabata 預設與歷史紀錄量小,JSON 陣列已綽綽有餘;沒上 Drift / Isar 是因為複雜度不值得 |
| 音效 | `flutter/services` 的 `SystemSound` + `flutter_tts` | 不用打包 mp3 資源,跨平台一致 |
| 震動 | `vibration` + `HapticFeedback` | 雙保險 |
| 鎖屏 | `wakelock_plus` | iOS / Android 雙平台 |
| 通知 | `flutter_local_notifications` 21 | 訓練完成可在 status bar 出現 |
| i18n | `flutter_localizations` + ARB | 官方方案 |
| 字型 | `google_fonts` (Inter + JetBrains Mono) | UI 用 Inter,大數字用等寬 mono |

---

## 整體架構:Clean Architecture 四層

```
┌────────────────────────────────────────────────┐
│  presentation/    Flutter Widgets, theme, l10n │  ← 使用者看到、摸到的
└──────────────────────────▲─────────────────────┘
                           │ 用 Riverpod 訂閱狀態 / 呼叫方法
┌──────────────────────────▼─────────────────────┐
│  application/     Riverpod controllers          │  ← 協調 domain 與 UI 的「中介者」
└──────────────────────────▲─────────────────────┘
                           │ 透過 abstract 介面呼叫
┌──────────────────────────▼─────────────────────┐
│  domain/          純 Dart;entities + 抽象介面  │  ← 業務規則的「靈魂」,沒有任何外部依賴
└──────────────────────────▲─────────────────────┘
                           │ 由 di/ 注入具體實作
┌──────────────────────────▼─────────────────────┐
│  data/            JSON、shared_preferences、套件包裝  │  ← 髒活累活
└────────────────────────────────────────────────┘
```

**核心約束(依賴方向只能往內)**:

- `domain` **不 import 任何**外部:不認識 Flutter、不認識 SharedPreferences、不認識 just_audio。完全是純 Dart。
- `data` import `domain`(因為要實作介面),同時 import 第三方套件。
- `application` import `domain`(用 entities 與 abstract 介面),不 import `data`。
- `presentation` import `domain` + `application`,**完全不 import `data`**。

```
presentation ──▶ application ──▶ domain ◀── data
                                  ▲
                                  │ 抽象介面
                            (data 提供具體實作)
```

> **為什麼這樣分**:你想換掉 `shared_preferences` 改用 `sqflite`?只動 `data/`。想把 just_audio 換掉?只動 `data/`。想加單元測試而不啟動 Flutter?直接測 `domain/`。**改一處不會牽動其他層**,這就是「低耦合」的具體意思。

---

## Domain 層

> 位置:[`lib/domain/`](lib/domain/)
> 規則:**只能 import `package:freezed_annotation/freezed_annotation.dart`**(純 Dart 套件)。**不准 import Flutter、不准 import shared_preferences、不准 import json_serializable**。

Domain 是業務規則的本體。如果你把 Flutter 整個拔掉,把 shared_preferences 整個換掉,**這層應該完全不需要動一行**。

### 1. Entities — 業務模型

| 檔案 | 是什麼 |
|---|---|
| [`entities/tabata_preset.dart`](lib/domain/entities/tabata_preset.dart) | 一個 Tabata 預設:名稱、prepare/work/rest 秒數、回合、組數。提供 `totalSeconds` getter 計算總時長 |
| [`entities/timer_phase.dart`](lib/domain/entities/timer_phase.dart) | enum:`idle / prepare / work / rest / restBetweenSets / completed` |
| [`entities/timer_snapshot.dart`](lib/domain/entities/timer_snapshot.dart) | 計時器當下的 immutable 快照(目前 phase、剩餘 ms、進度...) |
| [`entities/workout_history_entry.dart`](lib/domain/entities/workout_history_entry.dart) | 一筆完成的訓練紀錄 |
| [`entities/app_settings.dart`](lib/domain/entities/app_settings.dart) | 主題模式 + 語系偏好 |

> **為什麼用 `freezed`?** 一個 immutable class 自動生成 `==`、`hashCode`、`copyWith`、`toString`,不需要手寫。entities 改欄位 → codegen 一次重做完。
> **為什麼這層不放 JSON?** 因為「儲存格式」是 data 層的事;domain 只關心「這個東西的型別與業務邏輯」。今天可能存 SharedPrefs JSON、明天可能存 SQLite,domain 不該被綁死。

### 2. Repository 介面 — 資料的「合約」

| 檔案 | 合約內容 |
|---|---|
| [`repositories/preset_repository.dart`](lib/domain/repositories/preset_repository.dart) | `loadAll() / upsert(p) / delete(id) / newId()` |
| [`repositories/history_repository.dart`](lib/domain/repositories/history_repository.dart) | `loadAll() / add(e) / deleteOne(id) / clearAll()` |
| [`repositories/settings_repository.dart`](lib/domain/repositories/settings_repository.dart) | `load() / save(s)` |

```dart
// lib/domain/repositories/preset_repository.dart
abstract class PresetRepository {
  Future<List<TabataPreset>> loadAll();
  Future<TabataPreset> upsert(TabataPreset preset);
  Future<void> delete(String id);
  String newId();
}
```

> **為什麼是 abstract?** 這就是 **Repository Pattern**:domain 只說「我需要一個能存取預設的東西」,不在乎實作。data 層去實作它。controller 拿到的也是這個介面。
> **好處**:寫測試的時候可以丟一個 `InMemoryPresetRepository`(全用 List 模擬)進去,不用真的開 SharedPreferences。

### 3. Service 介面 — 副作用的「合約」

| 檔案 | 介面 |
|---|---|
| [`services/audio_cue.dart`](lib/domain/services/audio_cue.dart) | `phaseChange() / tick() / completed()` |
| [`services/haptics.dart`](lib/domain/services/haptics.dart) | `workStart() / restStart() / tick() / completed()` |
| [`services/tts_speaker.dart`](lib/domain/services/tts_speaker.dart) | `say(message, languageTag)` |
| [`services/wake_lock.dart`](lib/domain/services/wake_lock.dart) | `enable() / disable()` |
| [`services/workout_notifier.dart`](lib/domain/services/workout_notifier.dart) | `showCompleted(title, body)` |

> **為什麼把音效 / 震動 / TTS / 鎖屏抽成介面?** 這就是 **Strategy Pattern**:同一個「播音效」概念,可以用 SystemSound、可以用 just_audio、可以用 native plugin、測試環境可以用 NoOp。介面不變,實作可換。

### 4. Timer 狀態機 — 業務邏輯的核心

| 檔案 | 角色 |
|---|---|
| [`timer/timer_engine.dart`](lib/domain/timer/timer_engine.dart) | **純 Dart 計時狀態機**。不認識 Flutter,不認識 Riverpod。只知道 `Timer.periodic` 跟 `Stream` |
| [`timer/phase_transition.dart`](lib/domain/timer/phase_transition.dart) | phase 切換時發出的事件物件 |
| [`clock.dart`](lib/domain/clock.dart) | `Clock` 抽象 + `SystemClock` 實作。**讓測試可以注入假時鐘** |

`TimerEngine` 對外暴露:

```dart
class TimerEngine {
  TimerEngine({required Clock clock, ...});

  TimerSnapshot get state;                 // 當前狀態
  Stream<TimerSnapshot> get snapshots;     // 狀態流(每 100ms 更新)
  Stream<PhaseTransition> get transitions; // 區段切換事件流

  void start(TabataPreset preset);
  void pause();
  void resume();
  void stop();
  void skipPhase();
}
```

**關鍵設計**:剩餘時間用「目標時間戳 - 現在時間」算,不靠 `Timer.periodic` 累計 → **不會漂移**。`Clock` 用注入的,測試可以把時間「快轉」。

> **這層的測試** [`test/widget_test.dart`](test/widget_test.dart) 直接 new 一個 `TimerEngine(clock: FakeClock(...))`,呼叫 `skipPhase()` 驗證 phase 流轉。**不需要 Flutter test bindings**,跑很快。這就是純 domain 的好處。

---

## Data 層

> 位置:[`lib/data/`](lib/data/)
> 規則:**實作 domain 介面**,負責所有「跟外部世界互動」的髒活 — JSON 序列化、SharedPreferences、套件 API、原生 plugin。

### 1. DTOs — 儲存格式的「替身」

| 檔案 | 對應 entity |
|---|---|
| [`dtos/tabata_preset_dto.dart`](lib/data/dtos/tabata_preset_dto.dart) | `TabataPreset` |
| [`dtos/workout_history_entry_dto.dart`](lib/data/dtos/workout_history_entry_dto.dart) | `WorkoutHistoryEntry` |

DTO 跟 entity 長一樣,但**多帶 `fromJson` / `toJson`**(由 `json_serializable` 生成)。並且提供 mapper:

```dart
extension TabataPresetDtoX on TabataPresetDto {
  TabataPreset toEntity() => TabataPreset(id: id, name: name, ...);
}

extension TabataPresetMapper on TabataPreset {
  TabataPresetDto toDto() => TabataPresetDto(id: id, name: name, ...);
}
```

> **為什麼要分?** 你可能會問:「entity 跟 DTO 長得幾乎一樣,不是重複嗎?」
> 是,**現在**確實一樣。但只要哪天:
> - 儲存格式變了(換成 SQLite,欄位變 snake_case)
> - 加版本(`v1`、`v2` JSON 結構不同)
> - 從 API 取資料(雲端格式跟本機 entity 不同)
>
> ...你只動 DTO + mapper,**entity 跟 domain 不用碰**。沒有 DTO 的話,你的 domain 就會被儲存格式綁死。

### 2. Repositories — 介面的具體實作

| 檔案 | 實作的介面 |
|---|---|
| [`repositories/shared_prefs_preset_repository.dart`](lib/data/repositories/shared_prefs_preset_repository.dart) | `PresetRepository` |
| [`repositories/shared_prefs_history_repository.dart`](lib/data/repositories/shared_prefs_history_repository.dart) | `HistoryRepository` |
| [`repositories/shared_prefs_settings_repository.dart`](lib/data/repositories/shared_prefs_settings_repository.dart) | `SettingsRepository` |

每個都是:`SharedPreferences.getString(key)` → `jsonDecode` → `[Dto.fromJson(...).toEntity()]` → 回傳 `List<Entity>`。寫的時候反過來。

> **為什麼用 `SharedPreferences` 不用 `SQLite`?** Tabata 預設量小(個位數~數十筆),歷史紀錄上限 200 筆,JSON 陣列序列化夠快、夠簡單。檔案在 `~/Documents/com.example.tabata_timer/...`。
> **如果以後要換 SQLite**:寫一個 `SqfliteHistoryRepository` 實作同一個介面,改 `lib/di/providers.dart` 一行就行。

### 3. Services — 第三方套件的「轉接頭」

| 檔案 | 實作介面 | 包裝套件 |
|---|---|---|
| [`services/system_audio_cue.dart`](lib/data/services/system_audio_cue.dart) | `AudioCue` | `flutter/services.dart` 的 `SystemSound` |
| [`services/vibration_haptics.dart`](lib/data/services/vibration_haptics.dart) | `Haptics` | `vibration` + `HapticFeedback` |
| [`services/flutter_tts_speaker.dart`](lib/data/services/flutter_tts_speaker.dart) | `TtsSpeaker` | `flutter_tts` |
| [`services/wakelock_plus_lock.dart`](lib/data/services/wakelock_plus_lock.dart) | `WakeLock` | `wakelock_plus` |
| [`services/flutter_local_workout_notifier.dart`](lib/data/services/flutter_local_workout_notifier.dart) | `WorkoutNotifier` | `flutter_local_notifications` |

> **這就是 Adapter Pattern**:每個套件 API 不同,但對外都長成 domain 介面那個樣子。換掉 `wakelock_plus` 改用 `screen` → 只動這一個檔案。

---

## Application 層

> 位置:[`lib/application/`](lib/application/)
> 角色:**Riverpod controllers**,扮演 UI 跟 domain 之間的協調者。它持有狀態、處理動作、決定何時呼叫哪個 service / repository。

### 為什麼需要這一層?

如果 UI 直接呼叫 repository,會發生:

- ❌ UI 變胖:既要顯示又要管狀態
- ❌ 商業邏輯散落:多個頁面重複「按下 + → 寫入 → 刷新」
- ❌ 難測試:UI 跟邏輯黏死

`AsyncNotifier` / `Notifier` 把這些抽出來,**UI 只負責看狀態跟發指令**。

### Controllers

| 檔案 | 對應狀態 | 職責 |
|---|---|---|
| [`presets/presets_controller.dart`](lib/application/presets/presets_controller.dart) | `AsyncValue<List<TabataPreset>>` | CRUD 預設、刷新列表 |
| [`history/history_controller.dart`](lib/application/history/history_controller.dart) | `AsyncValue<List<WorkoutHistoryEntry>>` | 載入紀錄、刪除單筆、清空 |
| [`settings/settings_controller.dart`](lib/application/settings/settings_controller.dart) | `AsyncValue<AppSettings>` | 切主題 / 切語系,寫回 repository |
| [`timer/workout_controller.dart`](lib/application/timer/workout_controller.dart) | `TimerSnapshot`(同步,因 engine 已建好) | **訂閱 TimerEngine 狀態流;在區段切換時播音效 / 震動 / 寫歷史 / 開關鎖屏** |

`WorkoutController` 是這層最複雜的:

```dart
class WorkoutController extends Notifier<TimerSnapshot> {
  @override
  TimerSnapshot build() {
    _engine = ref.watch(timerEngineProvider);   // 從 DI 拿到 engine
    _audio = ref.watch(audioCueProvider);        // 拿到 AudioCue 介面實例
    _haptics = ref.watch(hapticsProvider);
    // ...

    _engine.snapshots.listen((s) => state = s);  // 把 engine 狀態流轉給 Riverpod
    _engine.transitions.listen(_onTransition);   // 訂閱區段切換,觸發副作用
    return _engine.state;
  }

  Future<void> _onTransition(PhaseTransition ev) async {
    switch (ev.to) {
      case TimerPhase.work:
        unawaited(_audio.phaseChange());
        unawaited(_haptics.workStart());
      case TimerPhase.completed:
        unawaited(_audio.completed());
        await _recordHistory();           // ← 寫紀錄
        await _wakeLock.disable();
      // ...
    }
  }
}
```

> **重點觀察**:這裡呼叫的是 `AudioCue`、`Haptics` 這些**抽象介面**,不是 `flutter_tts`、`vibration`。controller 不知道它在用哪個套件,DI 才知道。

---

## Presentation 層

> 位置:[`lib/presentation/`](lib/presentation/)
> 規則:**只認 application + domain entities + l10n**。**不准 import data/、不准 import shared_preferences**。

### 結構

```
presentation/
├── theme/app_theme.dart       # 線條風格主題定義(光 / 暗)
├── shell/home_shell.dart      # 底部導航容器
├── routing/router.dart        # go_router + StatefulShellRoute
├── shared/                    # 跨頁共用 widget
│   └── section_header.dart
├── timer/
│   ├── timer_page.dart
│   └── widgets/circular_countdown.dart
├── presets/
│   ├── preset_list_page.dart
│   └── preset_editor_page.dart
├── history/history_page.dart
├── settings/settings_page.dart
└── app.dart                   # MaterialApp.router 進入點
```

### Page 怎麼寫:範例

```dart
class PresetListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final async = ref.watch(presetsControllerProvider);   // ← 訂閱 controller

    return Scaffold(
      appBar: AppBar(title: Text(t.appTitle)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (presets) => /* 繪製列表 */,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/presets/edit'),
        // ...
      ),
    );
  }
}
```

UI 做的事只有三件:
1. `ref.watch(...)` 訂閱狀態
2. 把狀態畫出來
3. 使用者操作時 `ref.read(...).method()` 發指令給 controller

> **為什麼 UI 這麼薄?** 因為複雜邏輯都被推到 application 層了。UI 越薄,改 UI 越容易,改 UI 不會動到邏輯。

### 線條風格主題

[`theme/app_theme.dart`](lib/presentation/theme/app_theme.dart) 集中定義:

- 強調色 `#E85D04`(深橘),其他全 monochrome
- Hairline 1px 邊框取代陰影
- Card 為 `Border.all(1)` + 圓角 12,**沒有填色**
- 大數字字型 `JetBrains Mono` weight 200
- AppBar、Scaffold 平面,無陰影、無 surface tint
- BottomNavigationBar 無 indicator pill,以顏色 + 字重區分選中

---

## DI(依賴注入)

> 位置:[`lib/di/providers.dart`](lib/di/providers.dart)
> 角色:**唯一一處決定「abstract 介面對應到哪個具體實作」的地方**。改 provider 就等於換實作。

```dart
// 抽象 Repository 對應到具體實作
final presetRepositoryProvider = FutureProvider<PresetRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SharedPrefsPresetRepository(prefs);   // ← 「合約」對應到 SharedPrefs 實作
});

// 抽象 Service 對應到具體實作
final audioCueProvider = Provider<AudioCue>((_) => const SystemAudioCue());
final hapticsProvider = Provider<Haptics>((_) => VibrationHaptics());
final wakeLockProvider = Provider<WakeLock>((_) => const WakelockPlusLock());
```

注意 **Provider 的型別是 abstract `PresetRepository`**,不是 `SharedPrefsPresetRepository`。所以 controller `ref.watch(presetRepositoryProvider)` 拿到的編譯期型別是介面,只能呼叫介面定義的方法,**根本接觸不到 SharedPreferences 細節**。

> **要換 SQLite?** 加一個 `SqflitePresetRepository implements PresetRepository`,把上面那行改成 `return SqflitePresetRepository(db)`。其他全部不動。
> **要寫測試?** 在測試裡 `overrideWith` 換成 `InMemoryPresetRepository`。

---

## 一個請求穿過四層的完整範例

**情境**:使用者按下「新增預設」→ 填表 → 按 SAVE。

```
┌─ presentation/preset_editor_page.dart ─────────────────────┐
│  按 SAVE → ref.read(presetsControllerProvider.notifier)    │
│           .upsert(TabataPreset(...))                       │
└──────────────────────┬─────────────────────────────────────┘
                       ▼
┌─ application/presets_controller.dart ──────────────────────┐
│  Future<TabataPreset> upsert(TabataPreset preset) async {  │
│    final saved = await _repository.upsert(preset);         │
│    ref.invalidateSelf();    // ← 通知 UI 重新載入           │
│    return saved;                                           │
│  }                                                         │
└──────────────────────┬─────────────────────────────────────┘
                       ▼
┌─ domain/repositories/preset_repository.dart ───────────────┐
│  abstract class PresetRepository {                         │
│    Future<TabataPreset> upsert(TabataPreset preset);       │
│  }                                                         │
└──────────────────────┬─────────────────────────────────────┘
                       │ DI 把這個介面綁到 ↓ 實作
                       ▼
┌─ data/repositories/shared_prefs_preset_repository.dart ────┐
│  Future<TabataPreset> upsert(TabataPreset preset) async {  │
│    final list = await loadAll();                           │
│    list.add(preset);                                       │
│    final json = jsonEncode(list.map((p) => p.toDto()       │
│                                          .toJson()));      │
│    await _prefs.setString('presets_v1', json);             │
│    return preset;                                          │
│  }                                                         │
└────────────────────────────────────────────────────────────┘
```

寫完後 `ref.invalidateSelf()` 觸發 `PresetsController.build()` 重新跑一次,Riverpod 通知所有 `ref.watch(presetsControllerProvider)` 的 UI 重繪 → 列表頁立刻看到新預設。

---

## 關鍵設計模式

| 模式 | 在哪裡 | 做什麼 |
|---|---|---|
| **Repository Pattern** | `domain/repositories/*` (抽象) + `data/repositories/*` (實作) | 把「資料怎麼存」隔離成介面 |
| **Strategy Pattern** | `domain/services/*` + `data/services/*` | 同一個能力(播音、震動、TTS)可以有多種實作 |
| **DTO Pattern** | `data/dtos/*` | entity 與 JSON 解耦 |
| **State Machine** | `domain/timer/timer_engine.dart` | Tabata phase 流轉的純邏輯 |
| **Observer Pattern** | `TimerEngine.snapshots` / `TimerEngine.transitions` Stream | 廣播狀態變化 |
| **Adapter Pattern** | `data/services/*` | 把第三方套件 API 包成 domain 介面 |
| **Dependency Injection** | `di/providers.dart` | Riverpod 集中綁定 |
| **Single Responsibility** | 整個分層 | 每個檔案只做一件事 |

---

## 檔案地圖

```
lib/
├── main.dart                           # ProviderScope + runApp
│
├── domain/                             # 純 Dart,無外部依賴
│   ├── clock.dart
│   ├── entities/
│   │   ├── app_settings.dart
│   │   ├── tabata_preset.dart
│   │   ├── timer_phase.dart
│   │   ├── timer_snapshot.dart
│   │   └── workout_history_entry.dart
│   ├── repositories/                   # 抽象介面
│   │   ├── history_repository.dart
│   │   ├── preset_repository.dart
│   │   └── settings_repository.dart
│   ├── services/                       # 抽象介面
│   │   ├── audio_cue.dart
│   │   ├── haptics.dart
│   │   ├── tts_speaker.dart
│   │   ├── wake_lock.dart
│   │   └── workout_notifier.dart
│   └── timer/
│       ├── phase_transition.dart
│       └── timer_engine.dart           # 純 Dart 計時狀態機
│
├── data/                               # 與外部世界互動
│   ├── dtos/
│   │   ├── tabata_preset_dto.dart
│   │   └── workout_history_entry_dto.dart
│   ├── repositories/                   # 介面具體實作
│   │   ├── shared_prefs_history_repository.dart
│   │   ├── shared_prefs_preset_repository.dart
│   │   └── shared_prefs_settings_repository.dart
│   └── services/                       # 第三方套件包裝
│       ├── flutter_local_workout_notifier.dart
│       ├── flutter_tts_speaker.dart
│       ├── system_audio_cue.dart
│       ├── vibration_haptics.dart
│       └── wakelock_plus_lock.dart
│
├── application/                        # Riverpod controllers
│   ├── history/history_controller.dart
│   ├── presets/presets_controller.dart
│   ├── settings/settings_controller.dart
│   └── timer/workout_controller.dart
│
├── presentation/                       # 純 UI
│   ├── app.dart
│   ├── routing/router.dart
│   ├── shell/home_shell.dart
│   ├── theme/app_theme.dart
│   ├── shared/section_header.dart
│   ├── timer/
│   │   ├── timer_page.dart
│   │   └── widgets/circular_countdown.dart
│   ├── presets/
│   │   ├── preset_editor_page.dart
│   │   └── preset_list_page.dart
│   ├── history/history_page.dart
│   └── settings/settings_page.dart
│
├── di/providers.dart                   # 唯一 DI 集中點
│
└── l10n/                               # 翻譯
    ├── app_en.arb
    ├── app_zh_TW.arb
    └── app_zh.arb
```

---

## 開發指令

| 動作 | 指令 |
|---|---|
| 安裝相依 | `flutter pub get` |
| 跑 codegen(改 `freezed` / `json_serializable` 標註後) | `dart run build_runner build` |
| 重新產生翻譯(改 `.arb` 後) | `flutter gen-l10n`(`pub get` 也會自動跑) |
| 靜態分析 | `flutter analyze` |
| 跑單元測試 | `flutter test` |
| 在 Android 模擬器跑 | `flutter run -d emulator-5554` |
| 列出可用裝置 / 模擬器 | `flutter devices` / `flutter emulators` |
| 建 release APK | `flutter build apk --release` |
| 建 iOS(需 Mac) | `flutter build ios --release` |

開發過程中 `flutter run` 是 attached mode,按:
- `r` — Hot reload(改 widget tree、樣式)
- `R` — Hot restart(改 state / DI / 全域變數)
- `q` — 結束

---

## 如何擴充(實戰演練)

**情境 1:把預設儲存從 SharedPreferences 換成 SQLite**

1. 加入 `sqflite` 套件:`flutter pub add sqflite path`
2. 在 `lib/data/repositories/` 寫一個新檔 `sqflite_preset_repository.dart`,`implements PresetRepository`
3. 改 `lib/di/providers.dart`:`presetRepositoryProvider` 回傳新類別
4. **完工**。`domain` / `application` / `presentation` 一行不用動,測試也不用改。

**情境 2:訓練完成發送雲端統計**

1. 在 `lib/domain/services/` 加 `analytics_reporter.dart` 抽象介面
2. 在 `lib/data/services/` 寫具體實作(例:`firebase_analytics_reporter.dart`)
3. `WorkoutController._onTransition` 在 `case completed` 多呼叫一行
4. `lib/di/providers.dart` 多註冊一個 provider
5. **完工**。UI 完全不用動。

**情境 3:加單元測試**

```dart
test('skipPhase advances prepare -> work', () {
  final engine = TimerEngine(clock: FakeClock(DateTime(2026)));
  engine.start(const TabataPreset(id: 'x', name: 't', prepareSeconds: 5, workSeconds: 10, restSeconds: 5, rounds: 2));
  expect(engine.state.phase, TimerPhase.prepare);

  engine.skipPhase();
  expect(engine.state.phase, TimerPhase.work);
});
```

**完全不需要 Flutter test bindings**,跑超快。這就是把純邏輯放 domain 的紅利。

---

## 知道的限制

- **背景持續計時**:目前只用 `WakelockPlus` 防鎖屏,沒上 `flutter_background_service` 與預先排程通知。iOS 鎖屏背景倒數會被 OS 凍結,需要靠「預排多個本地通知」來補。實機測試確認需求後再加。
- **iOS 出包**:Windows 環境無法編譯 iOS,需要 Mac 或 Codemagic / GitHub Actions macOS runner。
- **TTS 中文發音**:依賴系統內建 TTS 引擎,Android 預設可能要使用者去「設定 → 語言」下載中文 voice pack。
