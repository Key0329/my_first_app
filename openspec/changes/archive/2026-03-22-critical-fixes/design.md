## Context

App 在 QA 和 UX 審查中發現 4 個 Critical/High 等級問題，需在上架前修復。這些問題涵蓋：功能正確性（計時器漂移、按鈕雙重觸發）、用戶信任（假搜尋按鈕）、平台穩定性（跨平台崩潰）。

## Goals / Non-Goals

**Goals:**

- 修復計時器精度漂移，確保長時間計時誤差 < 1 秒
- 修復計算機按鈕雙重觸發問題
- 實作首頁搜尋功能
- 所有使用硬體感測器的工具在 Web/桌面平台顯示 fallback UI

**Non-Goals:**

- 不改動工具的功能邏輯（除了修復 bug 的最小改動）
- 不改動 UI 設計風格
- 不新增工具
- 搜尋功能不需要模糊匹配或搜尋歷史（Phase 1 基本版即可）

## Decisions

### 計時器改用 Stopwatch 計算剩餘時間

將 `_TimerTabState` 的計時方式從「每 100ms 減去固定值」改為「記錄開始時間，用 Stopwatch.elapsed 計算已過時間」。Timer.periodic 僅用於觸發 UI 更新（頻率不變）。

```dart
// Before: 累積漂移
_remaining = _remaining - Duration(milliseconds: 100);

// After: 基於實際時間
_remaining = _totalDuration - _stopwatch.elapsed;
```

需處理暫停/繼續的場景：暫停時記錄 `_pausedRemaining`，繼續時用新的 Stopwatch 從 0 開始，剩餘 = `_pausedRemaining` - stopwatch.elapsed。

### 計算機 BouncingButton 移除 onTap

BouncingButton 包裹 FilledButton 時，BouncingButton 只負責縮放動畫（`onTapDown`/`onTapUp`），不設定 `onTap`。FilledButton 的 `onPressed` 單獨處理事件。

```dart
// Before: 雙重觸發
BouncingButton(
  onTap: onPressed,  // ← 觸發一次
  child: FilledButton(onPressed: onPressed, ...), // ← 又觸發一次
)

// After: 只觸發一次
BouncingButton(
  // onTap 不設定，僅保留動畫效果
  child: FilledButton(onPressed: onPressed, ...),
)
```

### 搜尋功能使用 showSearch + SearchDelegate

點擊搜尋圖示後使用 Flutter 內建的 `showSearch()` + 自訂 `ToolSearchDelegate`，即時過濾工具列表。匹配欄位包含：工具名稱（中英文）、分類名稱。搜尋結果使用現有的 `ToolCard` 元件展示。

### 跨平台防護使用共用 PlatformCheck 工具

建立一個輕量的平台判斷工具函式 `isMobilePlatform()`，在 6 個使用硬體的工具頁面中調用。不支援時顯示統一的 fallback UI（圖示 + 「此功能需要行動裝置」文字 + 返回按鈕）。

受影響的工具頁面：水平儀、指南針、手電筒、噪音計、色彩擷取、螢幕尺規。

## Risks / Trade-offs

- [計時器改動較大] → 碼錶 tab 已使用 `Stopwatch` 類（正確做法），計時器 tab 只需參考同一模式
- [搜尋功能需要 i18n 支援] → 目前工具名稱已有中英文定義在 `ToolItem`，搜尋匹配中文名和英文 route path 即可
- [平台判斷可能遺漏某些套件] → 以 `kIsWeb` + `Platform.isAndroid || Platform.isIOS` 作為標準判斷條件，涵蓋所有非手機平台
