## Context

App 目前所有功能皆免費提供，無廣告、無付費牆。已完成的 `services-refactor` change 將 AppSettings 拆分為 ThemeService / FavoritesService / UserPreferencesService，服務層架構穩健。本 change 在此基礎上新增 ProService 管理付費狀態，並整合 AdMob 與平台內購 SDK。

目前受影響的現有服務：
- `UserPreferencesService`：持久化層，Pro 狀態需儲存於此
- `ImmersiveToolScaffold`：工具頁框架，需在底部嵌入 banner slot
- `SettingsPage`：設定頁，需新增 Pro 入口

## Goals / Non-Goals

**Goals:**
- 建立 `isPro` 的單一事實來源（ProService）
- 免費版工具頁底部顯示 AdMob banner，Pro 版完全隱藏
- 付費牆頁面（PaywallScreen）展示功能對比與 NT$90 定價
- iOS StoreKit2 + Android Play Billing 一次性購買與回復購買
- 自訂主題色、Home Screen Widget 設定入口標示 Pro 專屬（免費版 CTA）

**Non-Goals:**
- 訂閱制（僅一次性買斷）
- 服務端 receipt 驗證（MVP 採本地驗證，後續 change 補強）
- A/B 定價測試
- Android 側的自動 billing ack 排程（由套件處理）

## Decisions

### 使用 `in_app_purchase` 官方套件而非 RevenueCat

Flutter 官方 `in_app_purchase` 套件同時支援 StoreKit2（iOS 15+）和 Google Play Billing，無需額外 SDK 依賴與第三方服務費。RevenueCat 雖有更豐富的 analytics dashboard，但 MVP 階段無此需求，且增加每月訂閱成本。改用 RevenueCat 可於 Phase 7 作為 Change #23 的強化選項。

### Pro 狀態儲存於 SharedPreferences，不依賴網路

`isPro` 以 boolean 儲存於 SharedPreferences。優點：離線可用、無服務端依賴。風險：使用者清除 App 資料會失去 Pro 狀態，但「回復購買」功能可解決此問題。MVP 不需要帳號系統。

### AdMob banner 嵌入 ImmersiveToolScaffold 底部

在 `ImmersiveToolScaffold` 的 `bottomNavigationBar` slot 之上、工具 body 之下插入 `BannerAdWidget`，以 `Consumer<ProService>` 監聽 isPro 動態切換顯示/隱藏。好處：集中管理，所有工具頁一次搞定。

### 主題色與 Widget 採「軟鎖定」策略

免費版不直接隱藏入口，而是：
1. 顯示功能入口但加 Pro 徽章
2. 點擊後顯示 PaywallScreen（提升轉換機會）

避免「功能感知被抹除」，讓使用者知道 Pro 的價值。

### 付費牆定價固定 NT$90 一次性

符合 backlog 規劃，台灣市場低門檻策略。App Store 對應 Tier 1（USD $2.99），Play Store 對應相近定價。

## Risks / Trade-offs

- **[Risk] iOS StoreKit2 需 iOS 15+** → `in_app_purchase` 套件 fallback 至 StoreKit1 支援 iOS 12+，接受此 trade-off
- **[Risk] AdMob 初始化增加冷啟動時間** → 在 `main.dart` 背景初始化，不 block UI render
- **[Risk] App Store 審核可能要求 restore purchase 明顯入口** → PaywallScreen 必須有明顯的「回復購買」按鈕
- **[Risk] 本地 isPro 可被 hack（reverse engineering）** → MVP 接受；Phase 7 可補服務端驗證
- **[Risk] Google Play Billing API 版本升級** → 使用 `in_app_purchase` 官方套件，由 Flutter 團隊維護版本相容性
