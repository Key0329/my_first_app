## Context

目前應用程式具備 16 個工具、Bento Grid 首頁、收藏功能、設定頁、沉浸式工具頁面和動畫系統。UX 審查發現若干痛點：收藏功能依賴長按但無視覺提示、缺乏觸覺反饋、設定頁與首頁設計語言不一致、新使用者無引導流程、缺少最近使用快捷存取、工具色彩定義不一致、隨機轉盤結果展示過於粗糙。

技術棧：Flutter 3.41.4、Dart SDK ^3.11.1、GoRouter、shared_preferences、Material 3。

## Goals / Non-Goals

**Goals:**

- 提升新使用者的首次體驗（Onboarding）
- 使收藏功能可發現且有反饋
- 增加全域觸覺反饋提升操作質感
- 統一設定頁與首頁的設計語言
- 提供最近使用工具的快速存取
- 修正工具色彩不一致問題
- 改善隨機轉盤結果展示體驗

**Non-Goals:**

- 不重新設計首頁 Bento Grid 佈局
- 不修改工具頁面的核心功能邏輯
- 不新增工具或修改現有工具的計算邏輯
- 不變更路由架構或導航結構

## Decisions

### Onboarding 引導流程設計

採用 3 頁 PageView 引導設計：

1. **歡迎頁**：App Logo + 歡迎文字 + 簡短介紹
2. **功能介紹頁**：展示核心功能（工具箱、收藏、設定）
3. **開始使用頁**：「開始使用」按鈕，點擊後進入首頁

技術方案：
- 新增 `OnboardingPage` widget，使用 `PageView` + `PageController`
- 在 `AppSettings`（shared_preferences）新增 `hasCompletedOnboarding` 布林值
- 在 `app.dart` 的 GoRouter 中新增 `/onboarding` 路由，啟動時檢查是否需要引導
- 頁面指示器使用 `AnimatedContainer` 實作圓點動畫

替代方案：使用 `introduction_screen` 套件 — 不採用，因為需求簡單，自行實作可完全控制樣式。

### 收藏改為可見愛心按鈕

將收藏觸發方式從長按改為可見的愛心圖示按鈕：

- 在 `ToolCard` 右上角新增 `IconButton`，使用 `Icons.favorite` / `Icons.favorite_border`
- 點擊切換收藏狀態，已收藏顯示實心愛心（品牌色），未收藏顯示空心愛心
- 切換後顯示 `SnackBar` 反饋（「已加入收藏」/「已移除收藏」）
- 保留長按觸發收藏作為備用操作（向後相容）
- 愛心按鈕使用 `AnimatedScale` 提供點擊動畫

替代方案：使用滑動手勢收藏 — 不採用，愛心按鈕是最直覺的 UI 模式。

### 全域 Haptic Feedback 策略

為所有互動操作加入觸覺反饋：

- **輕觸反饋**（`HapticFeedback.lightImpact`）：一般按鈕點擊、Tab 切換
- **中等反饋**（`HapticFeedback.mediumImpact`）：收藏切換、Onboarding 頁面滑動
- **重反饋**（`HapticFeedback.heavyImpact`）：轉盤結果揭曉、重要操作確認
- **選擇反饋**（`HapticFeedback.selectionClick`）：滑桿拖動、選項切換

實作方式：
- 建立 `HapticService` 工具類別，封裝各層級的觸覺反饋方法
- 在 `BouncingButton` 中整合 `lightImpact`，使所有包裝的按鈕自動具備觸覺反饋
- 在 `AppScaffold` 的 NavigationBar `onDestinationSelected` 中加入 `selectionClick`
- 在個別場景（收藏切換、轉盤結果）中直接呼叫對應層級

替代方案：使用第三方 haptic 套件 — 不採用，Flutter 內建 `HapticFeedback` 已足夠。

### 設定頁 Bento 風格重設計

將設定頁從 ListTile 列表改為 Bento Grid 風格卡片：

- 使用 `ToolSectionCard` 元件（已存在）包裝各設定區塊
- 分為三個區塊：「外觀」（主題、語言）、「資料」（清除收藏、清除最近使用）、「關於」（版本、隱私、條款）
- 每個區塊使用 Bento 卡片樣式，圓角 + 微陰影 + 品牌色強調
- 設定項目使用 `SegmentedButton` 取代下拉選單（主題、語言）
- 套用 `StaggeredFadeIn` 動畫

替代方案：使用 `CupertinoSettings` 風格 — 不採用，需與首頁 Bento 風格統一。

### 最近使用區段設計

在首頁新增「最近使用」橫向捲動區段：

- 擴展 `AppSettings`（`SettingsService`）新增 `recentTools` 列表（最多 5 筆）
- 使用 `shared_preferences` 儲存，格式為工具 ID 的 JSON 陣列
- 每次開啟工具頁面時，將該工具 ID 推入列表頂部（去重複）
- 在首頁工具網格上方新增「最近使用」區段，使用水平 `ListView` 展示
- 使用圓形漸層小卡片樣式，點擊直接跳轉工具頁面
- 若無使用紀錄則隱藏此區段

替代方案：使用全域狀態管理（Riverpod）— 不採用，`SettingsService` 的 `ChangeNotifier` 已足夠。

### 工具色彩統一方案

修正 `ToolItem.color` 與 `toolGradients` 的色彩不一致：

- 移除 `ToolItem` 中的硬編碼 `color` 屬性
- 改為動態計算：`ToolItem.color` getter 直接取用 `toolGradients[id]` 的第一個色彩值
- 確保首頁卡片、收藏頁卡片、工具頁面 header 使用一致的色彩來源
- 更新 `design_tokens.dart` 中 `toolGradients` 的定義，確保所有 16 個工具都有對應的漸層

替代方案：在每個工具手動同步色彩 — 不採用，容易再次不同步。

### 隨機轉盤結果展示重設計

以自訂覆蓋動畫取代 `AlertDialog`：

- 建立 `WheelResultOverlay` widget，使用 `OverlayEntry` 或 `showGeneralDialog`
- 結果展示動畫：半透明暗色背景淡入 → 結果卡片從中心縮放彈跳出現（`Curves.elasticOut`）
- 結果卡片設計：圓角卡片 + 工具漸層色背景 + 大字體結果文字 + 紙花粒子效果（`ConfettiWidget`）
- 點擊背景或按鈕關閉，關閉時縮放淡出
- 加入 `HapticFeedback.heavyImpact` 在結果揭曉瞬間

替代方案：使用 `BottomSheet` 展示 — 不採用，覆蓋式動畫更有視覺衝擊力。

## Risks / Trade-offs

- [風險] Haptic Feedback 在 iOS Simulator 上無效 → 需在實體裝置測試
- [風險] Onboarding 流程可能被使用者快速跳過 → 頁面設計要精簡吸引，加入 Skip 按鈕
- [風險] 設定頁 Bento 重設計可能影響可用性 → 確保所有設定項目仍易於找到
- [風險] 最近使用列表在冷啟動時為空 → 區段自動隱藏，不影響首次體驗
- [取捨] 保留長按收藏作為備用操作增加程式碼複雜度 → 向後相容性值得
- [取捨] 紙花效果需額外套件（confetti_widget）→ 視覺效果顯著提升值得引入
