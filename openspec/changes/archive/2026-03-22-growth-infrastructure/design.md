## Context

「工具箱」App 有 15+ 個工具，使用 GoRouter + Material 3 + 靛紫品牌色，已在首頁實現均勻 Grid 佈局。目前完全沒有任何數據追蹤、分享機制或 deep link 功能。bundle ID 仍為預設的 `com.example.my_first_app`，無法直接上架。

現有架構：
- 路由：GoRouter，ShellRoute（底部導航）+ 獨立 GoRoute（工具全螢幕）
- 主題：靛紫品牌色 `#6C5CE7`，Material 3
- 工具頁：每個工具獨立 Page，使用 `ImmersiveToolScaffold`
- 4 個有明確「結果」的工具：分帳（SplitBill）、隨機轉盤（RandomWheel）、BMI 計算器、QR Code 產生器

## Goals / Non-Goals

**Goals:**

- 整合 Firebase Analytics + Crashlytics，建立數據追蹤基礎
- 為 4 個結果導向工具加入分享功能
- 配置 Deep Link 路由支援
- 修正 bundle ID 和 App 名稱，完成 ASO 基礎準備

**Non-Goals:**

- 不實作自訂 Analytics Dashboard 或後台
- 不做 A/B testing 框架
- 不實作 referral 獎勵系統
- 不做 push notification
- 不更換 App icon 或 splash screen
- 不做 App Store / Google Play 上架流程（只做準備）

## Decisions

### Decision: AnalyticsService 抽象層設計

建立 `AnalyticsService` 作為 Firebase Analytics 的抽象層，使用 singleton pattern。所有事件透過統一介面記錄，方便日後替換 analytics provider 或新增多個 provider。

核心事件設計：
- `tool_open`: 使用者開啟工具時觸發，參數 `{tool_id, source}`
- `tool_complete`: 使用者完成操作時觸發（如 BMI 計算完成），參數 `{tool_id, result_type}`
- `tool_share`: 使用者分享結果時觸發，參數 `{tool_id, share_method}`
- `app_open`: App 啟動，自動記錄
- `tab_switch`: 切換底部導航 tab，參數 `{tab_name}`

使用 `AnalyticsRouteObserver extends NavigatorObserver` 自動記錄頁面瀏覽。

**替代方案：**
- 直接呼叫 FirebaseAnalytics — 耦合太高，測試困難
- 使用第三方抽象層（如 analytics package）— 過度工程，目前只需 Firebase

### Decision: 分享文本模板設計

每個工具定義自己的分享文本模板，透過 `ShareService.shareToolResult()` 統一處理。文本末尾附帶 Deep Link。

分享文本格式：
- **分帳**：「AA 分帳結果 💰\n總金額：NT$1,200\n每人：NT$300（4人）\n\n用 Spectra 工具箱快速分帳 👉 https://spectra.app/tools/split-bill」
- **轉盤**：「🎯 轉盤結果：{選中項目}\n\n用 Spectra 工具箱隨機決定 👉 https://spectra.app/tools/random-wheel」
- **BMI**：「📊 我的 BMI：{數值}（{分類}）\n身高：{身高}cm / 體重：{體重}kg\n\n用 Spectra 工具箱計算 BMI 👉 https://spectra.app/tools/bmi-calculator」
- **QR Code**：直接分享產生的 QR Code 圖片 + 文字「用 Spectra 工具箱產生 QR Code 👉 https://spectra.app/tools/qr-generator」

使用 `share_plus` 套件處理系統分享 sheet。分享按鈕統一使用 `ShareButton` widget，放在 `ImmersiveToolScaffold` 的 actions 區域。

**替代方案：**
- 每個工具各自實作分享 — 程式碼重複，風格不一致
- 使用剪貼簿複製而非系統分享 — 病毒傳播效果差

### Decision: Deep Link 路由配置

使用 GoRouter 內建的 deep link 支援。URL 格式：`https://spectra.app/tools/{tool-id}`，對應現有路由 `/tools/{tool-id}`。

平台配置：
- **iOS**: Universal Links — 在 `Runner.entitlements` 加入 Associated Domains `applinks:spectra.app`，部署 `apple-app-site-association` 到 web server
- **Android**: App Links — 在 `AndroidManifest.xml` 加入 `<intent-filter>` 處理 `https://spectra.app/tools/*`，部署 `assetlinks.json` 到 web server

GoRouter 已有 `/tools/{id}` 格式的路由，deep link 只需配置平台層即可自動匹配。

**替代方案：**
- 自訂 URL scheme（如 spectra://）— 不夠專業，無法在瀏覽器中 fallback
- Firebase Dynamic Links — 已 deprecated，不建議使用

### Decision: ASO 基礎準備與 bundle ID 修正

修正 bundle ID：
- Android: `com.spectra.toolbox`（修改 `android/app/build.gradle` 的 `applicationId`）
- iOS: `com.spectra.toolbox`（修改 Xcode project 的 `PRODUCT_BUNDLE_IDENTIFIER`）

App 名稱修正：
- Android: `android:label` 改為「Spectra 工具箱」
- iOS: `CFBundleDisplayName` 改為「Spectra 工具箱」

首頁副標題改為更行銷導向：「15+ 實用工具，一個 App 搞定」

**替代方案：**
- 保留 my_first_app bundle ID — 不專業，影響 App Store 審核
- 使用純英文名稱 — 目標市場為台灣，中文名更有親和力

## Risks / Trade-offs

- **[風險] Firebase 初始化增加 App 啟動時間** → Firebase 使用 lazy initialization，Analytics 在背景初始化，不阻塞 UI。Crashlytics 同理。
- **[風險] Deep Link 需要 web server 部署驗證檔** → 初期可先完成 App 端配置，server 端的 `apple-app-site-association` 和 `assetlinks.json` 在正式上架前部署即可。
- **[風險] bundle ID 變更導致重新安裝** → 開發階段 bundle ID 變更需要解除安裝舊 App 再重新安裝。透過 git commit 紀錄變更時間點。
- **[取捨] 只在 4 個工具加分享** → 優先選擇有「結果」可分享的工具。其他工具（如手電筒、水平儀）分享價值低，日後再評估。
- **[取捨] 分享文本硬編碼** → 初期直接在程式碼中定義模板，不做遠端配置。上架後若需 A/B 測試分享文案再改用 Remote Config。
