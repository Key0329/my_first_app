## Summary

將單體 `AppSettings` class 拆分為獨立的 ThemeService / FavoritesService / UserPreferencesService，並快取 SharedPreferences instance 以消除重複 `getInstance()` 呼叫。

## Motivation

1. **SharedPreferences 重複取得**：`settings_service.dart` 中每個方法都呼叫 `SharedPreferences.getInstance()`（7 次），其他 service 再加 10 次。雖然 Flutter SDK 內部有快取，但語意上不必要，且增加樣板程式碼。
2. **God class**：`AppSettings` 同時管理主題、語系、收藏、onboarding、最近使用工具 — 職責過多，增改困難。
3. **MaterialApp 過度 rebuild**：`ListenableBuilder` 監聽整個 `AppSettings`，任何變更（如加收藏）都觸發 `MaterialApp.router` rebuild，但 MaterialApp 只需要 theme 和 locale。

## Proposed Solution

1. **SP 快取**：在 `init()` 時取得 SharedPreferences instance 並存為成員變數 `_prefs`，後續方法直接使用。
2. **拆分 Service**：
   - `ThemeService`：管理 themeMode、locale（MaterialApp 需要的）
   - `FavoritesService`：管理 favorites set
   - `UserPreferencesService`：管理 onboarding、recentTools
3. **保留 `AppSettings` 作為 facade**：AppSettings 持有三個 sub-service 的 reference，對外 API 不變（getter/setter 代理到 sub-service），確保既有呼叫端不需修改。`app.dart` 的 `ListenableBuilder` 只監聽 `ThemeService`。
4. **其他 SP 呼叫者**：`ReviewService`、`CalculatorHistoryService`、`CurrencyApi`、`ScreenRulerPage` 的 `getInstance()` 不在此次範圍（它們各自獨立，問題較小）。

## Impact

- 影響的 spec：`settings`（設定功能的 spec）
- 影響的程式碼：`lib/services/settings_service.dart`（重寫）、`lib/app.dart`（ListenableBuilder 改聽 ThemeService）
- 無 API 變更（AppSettings 對外 API 不變）
- 無 **BREAKING** 變更
