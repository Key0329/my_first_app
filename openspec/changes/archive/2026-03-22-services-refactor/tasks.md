## 1. 建立三個 Sub-Service 實現 service separation

- [x] 1.1 [P] 建立 `lib/services/theme_service.dart`，實現 ThemeService（themeMode、locale），接收 SharedPreferences 參數，extends ChangeNotifier，依照三個 sub-service 的職責劃分作為 service separation 的一部分
- [x] 1.2 [P] 建立 `lib/services/favorites_service.dart`，實現 FavoritesService（favorites set），接收 SharedPreferences 參數，extends ChangeNotifier，作為 service separation 的一部分
- [x] 1.3 [P] 建立 `lib/services/user_preferences_service.dart`，實現 UserPreferencesService（onboarding、recentTools），接收 SharedPreferences 參數，extends ChangeNotifier，作為 service separation 的一部分

## 2. 重構 AppSettings facade 實現 SP 快取策略

- [x] 2.1 重構 `lib/services/settings_service.dart`，實現 SharedPreferences cached instance — init() 中快取 SP 實例並傳給三個 sub-service。AppSettings facade 保留既有 API（backward compatibility），消除重複 `getInstance()` 呼叫

## 3. MaterialApp rebuild 優化

- [x] 3.1 修改 `lib/app.dart`，ListenableBuilder 改為只監聽 ThemeService，實現 MaterialApp rebuild 優化 — theme mode selection 變更觸發 rebuild，其他變更不觸發

## 4. 驗證

- [x] 4.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 4.2 [P] 執行 `flutter test` 確認所有測試通過
