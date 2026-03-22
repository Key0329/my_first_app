## Context

Spectra 工具箱目前有 18 個工具，其中計算機和匯率換算使用頻率最高。App 使用 `go_router` 路由，支援 Deep Link（`spectra.app/tools/*`）。匯率資料透過 `CurrencyApi` 從 `frankfurter.app` 獲取並快取在 `SharedPreferences`。

iOS 專案使用 Swift（`AppDelegate.swift`），Android 使用 Kotlin（`build.gradle.kts`），bundle ID 為 `com.spectra.toolbox`。

`home_widget` 套件提供 Flutter 與原生 Widget 之間的資料橋接，透過 App Group（iOS）/ SharedPreferences（Android）共享資料。

## Goals / Non-Goals

**Goals:**

- 提供計算機快捷入口 Widget（點擊打開 App 計算機頁面）
- 提供匯率顯示 Widget（顯示最近匯率 + 點擊打開匯率工具）
- 同時支援 iOS（WidgetKit）和 Android（AppWidget）
- Widget 外觀符合 Spectra 品牌視覺（漸層色 + 品牌 icon）

**Non-Goals:**

- 不在 Widget 內做完整計算（只是快捷入口）
- 不做 Widget 內即時匯率更新（依賴 App 內操作後推送）
- 不支援 Widget 互動式輸入（僅顯示 + 點擊打開 App）
- 不支援 macOS/Windows/Linux Widget

## Decisions

### 使用 home_widget 套件而非純原生實作

`home_widget` 提供 Flutter ↔ 原生 Widget 的資料橋接，避免在兩個平台分別實作完整的資料層。Flutter 端透過 `HomeWidget.saveWidgetData()` 寫入資料，原生端讀取並渲染。

**替代方案**：純原生 WidgetKit + AppWidget → 需要在 Swift/Kotlin 中重複實作匯率快取讀取邏輯，維護成本高。

### 計算機 Widget 為靜態快捷入口

計算機 Widget 只顯示 App icon + 「計算機」標題 + Spectra 品牌色背景，點擊後透過 Deep Link 打開 `/tools/calculator`。不在 Widget 內嵌計算邏輯。

**原因**：iOS WidgetKit 不支援即時互動式輸入（iOS 17+ 的 Interactive Widget 僅支援按鈕/toggle），完整計算機體驗在 Widget 中不可行。作為快捷入口已足夠有價值。

### 匯率 Widget 顯示上次查詢結果

匯率 Widget 顯示：`{fromCurrency} → {toCurrency}`、匯率值、最後更新時間。資料來源是 Flutter 端在用戶完成匯率換算時透過 `HomeWidget.saveWidgetData()` 寫入的。

資料結構：
- `currency_from`: String（如 "USD"）
- `currency_to`: String（如 "TWD"）
- `currency_rate`: String（如 "32.15"）
- `currency_updated`: String（ISO 時間戳）

### iOS 使用 SwiftUI WidgetKit，兩個 Widget 合成一個 Extension

建立一個 Widget Extension target `SpectraWidgets`，內含 `CalculatorWidget` 和 `CurrencyWidget` 兩個 Widget。共用一個 App Group（`group.com.spectra.toolbox`）。

### Android 使用 XML layout + Kotlin AppWidgetProvider

每個 Widget 一個 `AppWidgetProvider` 子類 + 一個 layout XML + 一個 metadata XML。點擊行為透過 `PendingIntent` 導向 App 的對應 Deep Link route。

## Risks / Trade-offs

- **[風險] iOS App Group 配置需要 Xcode 手動操作** → 在 tasks 中明確列出 Xcode 配置步驟，並提供 entitlements 檔案範本
- **[風險] 匯率 Widget 在用戶從未使用匯率工具時為空** → 設計一個「尚未使用」的預設狀態，顯示 placeholder（如「打開匯率換算開始使用」）
- **[風險] Android Widget 在不同 launcher 上的渲染差異** → 使用標準 RemoteViews API，避免自訂繪製，確保相容性
- **[取捨] 不做 Widget 配置選項** → 簡化首版實作，後續可透過 Widget configuration intent 讓用戶選擇顯示哪個幣別對
