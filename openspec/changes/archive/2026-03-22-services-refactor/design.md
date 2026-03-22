## Context

`AppSettings` 是一個 God class，同時管理 theme、locale、favorites、onboarding、recentTools。每個 setter 方法都重新呼叫 `SharedPreferences.getInstance()`。`app.dart` 的 `ListenableBuilder` 監聽整個 `AppSettings`，導致任何變更都 rebuild `MaterialApp.router`。

## Goals / Non-Goals

**Goals:**

- 在 `init()` 時快取 SharedPreferences instance，消除重複 `getInstance()` 呼叫
- 拆分為 ThemeService / FavoritesService / UserPreferencesService
- AppSettings 保留為 facade，既有呼叫端 API 不變
- `app.dart` 的 ListenableBuilder 只監聽 ThemeService，減少不必要的 MaterialApp rebuild

**Non-Goals:**

- 不重構其他 service（ReviewService、CalculatorHistoryService、CurrencyApi）的 SP 用法
- 不引入 dependency injection 框架（GetIt 等）
- 不改變持久化機制（仍用 SharedPreferences）

## Decisions

### SP 快取策略

在 `AppSettings.init()` 中呼叫一次 `SharedPreferences.getInstance()`，存為 `late final SharedPreferences _prefs`，傳給三個 sub-service。Sub-service 的 constructor 接收 `SharedPreferences` 參數，不再自行取得。

### 三個 Sub-Service 的職責劃分

| Service | 職責 | SP Keys |
|---------|------|---------|
| `ThemeService` | themeMode, locale | `theme_mode`, `locale` |
| `FavoritesService` | favorites set | `favorites` |
| `UserPreferencesService` | onboarding, recentTools | `hasCompletedOnboarding`, `recent_tools` |

三個 service 都 extends `ChangeNotifier`，各自獨立 notify。

### AppSettings facade 保留

`AppSettings` 持有三個 sub-service，對外 API 不變（getter/setter 代理到對應 sub-service）。`AppSettings` 本身也 extends `ChangeNotifier`，在任何 sub-service 變更時 notify（給那些監聽 AppSettings 整體的 widget 用）。

### MaterialApp rebuild 優化

`app.dart` 的 `ListenableBuilder` 改為只監聯 `settings.themeService`（只有 theme/locale 變更才需要 rebuild MaterialApp）。其他頁面繼續使用 `settings`（AppSettings facade）。

## Risks / Trade-offs

**[facade 增加了一層間接]** → 可接受。對外 API 完全不變，呼叫端不需修改。facade 層很薄，只是代理。

**[三個 service 各自 notifyListeners 可能造成多次 rebuild]** → 不是問題。各 service 的 listener 是不同的 widget，不會重疊。AppSettings facade 的 notify 是為了向後相容。
