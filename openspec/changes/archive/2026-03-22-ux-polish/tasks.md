## 1. Onboarding 引導流程設計

- [x] [P] 1.1 在 `SettingsService` 中新增 `hasCompletedOnboarding` 布林值欄位與讀寫方法，實作 Onboarding completion persistence
- [x] [P] 1.2 建立 `OnboardingPage` widget，實作 Three-page onboarding flow（歡迎頁、功能介紹頁、開始使用頁），包含 PageView 與 Skip 按鈕
- [x] 1.3 實作 Onboarding page indicator — 使用 AnimatedContainer 的圓點動畫指示器
- [x] 1.4 在 `app.dart` 的 GoRouter 中新增 `/onboarding` 路由，啟動時根據 `hasCompletedOnboarding` 決定初始路由

## 2. 收藏改為可見愛心按鈕

- [x] 2.1 修改 `ToolCard` 元件，新增 Visible favorite heart button on tool cards（右上角愛心圖示按鈕，根據收藏狀態顯示 filled/outline）
- [x] 2.2 修改 `home_page.dart` 中 Add and remove favorites 邏輯 — 支援愛心按鈕點擊觸發收藏切換，並顯示 SnackBar 反饋
- [x] 2.3 實作 Favorite heart button animation — 在愛心按鈕點擊時觸發 AnimatedScale（scale 1.2 → 1.0）

## 3. 全域 Haptic Feedback 策略

- [x] [P] 3.1 建立 `HapticService` 工具類別，封裝 Global haptic feedback 的各層級方法（light/medium/heavy/selection）
- [x] 3.2 在 `BouncingButton` 中整合 lightImpact haptic feedback，使所有包裝按鈕自動具備觸覺反饋
- [x] [P] 3.3 在 `AppScaffold` 的 NavigationBar `onDestinationSelected` 中加入 selectionClick haptic feedback

## 4. 設定頁 Bento 風格重設計

- [x] 4.1 重新設計 `settings_page.dart`，實作 Settings page Bento layout — 使用 ToolSectionCard 將設定分為「外觀」「資料」「關於」三個區塊
- [x] 4.2 修改 Theme mode selection 為 SegmentedButton 樣式並放入 Bento 風格卡片中
- [x] 4.3 修改 Language selection 為 SegmentedButton 樣式並放入「外觀」區塊
- [x] 4.4 修改 About and legal links 區塊改用 Bento 風格 ToolSectionCard 包裝
- [x] 4.5 在設定頁新增 Clear recent tools data 功能 — 「資料」區塊中的清除最近使用按鈕與確認對話框

## 5. 最近使用區段設計

- [x] 5.1 擴展 `SettingsService`，實作 Recent tools tracking — 新增 `recentTools` 列表（最多 5 筆）與增刪方法
- [x] 5.2 實作 Recent tools persistence — 使用 shared_preferences 儲存 JSON 陣列
- [x] 5.3 在 `home_page.dart` 實作 Recent tools display on home page — 水平捲動區段，使用圓形漸層小卡片

## 6. 工具色彩統一方案

- [x] [P] 6.1 修改 `ToolItem` model，移除硬編碼 `color` 屬性，改為 getter 讀取 `toolGradients` 第一色，實作工具色彩統一方案
- [x] [P] 6.2 更新 `design_tokens.dart` 確保所有 16 個工具在 `toolGradients` 中都有對應的漸層定義

## 7. 隨機轉盤結果展示重設計

- [x] 7.1 建立 `WheelResultOverlay` widget，實作 Wheel result overlay animation — 半透明背景淡入 + 結果卡片 elasticOut 縮放彈跳
- [x] 7.2 將 `random_wheel_page.dart` 中的 AlertDialog 替換為 WheelResultOverlay，整合 heavyImpact haptic feedback

## 8. 測試與驗證

- [x] [P] 8.1 為 OnboardingPage 撰寫 widget test，驗證 Three-page onboarding flow 與 Onboarding completion persistence
- [x] [P] 8.2 為收藏愛心按鈕撰寫 widget test，驗證 Visible favorite heart button on tool cards 與 Add and remove favorites 的 SnackBar 反饋
- [x] [P] 8.3 為 Recent tools tracking 與 Recent tools display on home page 撰寫 unit/widget test
- [x] [P] 8.4 為 Settings page Bento layout 撰寫 widget test，驗證三個區塊與 Clear recent tools data 功能
