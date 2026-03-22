## Why

目前新增一個工具需要同時修改 3 處程式碼：`tool_item.dart`（allTools 列表）、`app.dart`（import 語句）和 `app.dart`（GoRoute 定義）。18 條路由的 boilerplate 完全相同（CustomTransitionPage + FadeTransition），佔據 200+ 行重複程式碼。這不僅容易遺漏、產生 bug，也拖慢 Phase 5 新增 5 個工具的開發速度。

## What Changes

- `ToolItem` 新增 `pageBuilder` 欄位，讓每個工具自帶頁面建構函數
- `app.dart` 的工具路由從 `allTools` 列表自動生成，消除手動維護的 18 條 GoRoute
- `app.dart` 移除 18 個工具頁面的手動 import，改由 `tool_item.dart` 統一管理
- 新增工具只需在 `allTools` 中加一筆 `ToolItem`（含 `pageBuilder`），路由自動註冊

## Capabilities

### New Capabilities

- `tool-registry`: 工具自動註冊機制 — ToolItem 攜帶 pageBuilder，路由從 allTools 自動生成

### Modified Capabilities

- `app-shell`: 路由定義方式從手動列舉改為自動生成

## Impact

- 影響的程式碼：`lib/models/tool_item.dart`、`lib/app.dart`
- 影響的 spec：`app-shell`（路由機制變更）、新增 `tool-registry`
- 無 API 或依賴變更
- 無 **BREAKING** 變更（行為完全相同，僅內部結構重構）
