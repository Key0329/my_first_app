---
name: flutter-mcp-testing
description: "Flutter MCP 測試流程。定義如何使用 dart-tooling 和 mobile-mcp 進行靜態分析、unit/widget test、UI 自動化測試。Use when testing Flutter apps with MCP tools."
metadata:
  author: keycheng
  version: "1.0"
---

# Flutter MCP 測試流程

使用 dart-tooling 和 mobile-mcp 兩個 MCP Server 進行完整的 Flutter 應用測試。

## 測試階段

### 1. 靜態分析（dart-tooling）

先確保程式碼沒有靜態問題：

- `analyze_files` — 掃描錯誤和警告
- `dart_fix` — 自動修復可修正的問題
- `dart_format` — 格式化程式碼

### 2. Unit / Widget Test（dart-tooling）

- `run_tests` — 執行 `flutter test`，分析結果
- 若測試失敗，讀取相關原始碼找出原因
- `get_runtime_errors` — 取得 runtime 錯誤（需先有執行中的 app）

### 3. UI 自動化測試（mobile-mcp）

需要先有模擬器或實機在執行：

**裝置準備：**
- `mobile_list_available_devices` — 確認可用裝置
- `mobile_launch_app` — 啟動 App

**畫面驗證：**
- `mobile_take_screenshot` — 截圖當前畫面
- `mobile_list_elements_on_screen` — 列出 UI 元素及座標

**操作模擬：**
- `mobile_click_on_screen_at_coordinates` — 點擊
- `mobile_double_tap_on_screen` — 雙擊
- `mobile_long_press_on_screen_at_coordinates` — 長按
- `mobile_swipe_on_screen` — 滑動
- `mobile_type_keys` — 輸入文字
- `mobile_press_button` — 按裝置按鈕（HOME、BACK）

**收尾：**
- `mobile_terminate_app` — 關閉 App

### 4. Hot Reload 驗證（dart-tooling）

修改程式碼後快速驗證：

- `hot_reload` — 套用變更，保留 App 狀態
- `hot_restart` — 完整重啟（全域變更時使用）
- `get_app_logs` — 檢查日誌輸出

## 回報格式

測試完成後，用以下格式回報：

```
測試結果摘要
├── 靜態分析：通過/失敗（N errors, N warnings）
├── Unit Test：N/N 通過
├── Widget Test：N/N 通過
└── UI 測試：通過/失敗（附截圖）

失敗項目：
- [檔案:行號] 錯誤描述 → 建議修正
```

## 已知陷阱與解法

### mobile-mcp 座標點擊不可靠

元素密集頁面（如首頁 Grid）座標容易點錯，動態區段（「最近使用」）會推移其他元素座標。

**解法：** 精準導航改用 adb deep link：
```bash
/Users/keycheng/Library/Android/sdk/platform-tools/adb -s emulator-5554 shell am start \
  -a android.intent.action.VIEW -d "https://spectra.app/tools/bmi-calculator" com.spectra.toolbox
```
mobile-mcp 最適合**截圖驗證**，複雜互動優先用 `flutter test`。

### dart-tooling 必須用 launch_app 啟動 App

用 `flutter run` CLI 啟動的 App，`list_running_apps` 看不到，無法用 hot reload、widget tree。必須用 `mcp__dart-tooling__launch_app` 啟動。首次 build 可能超過 90 秒 timeout，需多試幾次。

### Android Build 已知問題

- **core library desugaring**：`flutter_local_notifications` 等套件需要 `isCoreLibraryDesugaringEnabled = true`（本專案已設定）
- **namespace vs applicationId**：`namespace` 對應 Kotlin package 結構（不能改），只改 `applicationId` 設定上架 bundle ID
- **Bundle ID 變更後**需先 `adb uninstall <舊package>` 再安裝

## 其他注意事項

- 執行 UI 測試前，確認模擬器已啟動且 App 已安裝
- `run_tests` 和 `create_project` 等工具預設為停用，需要時會自動啟用
- 截圖可搭配 `mobile_save_screenshot` 儲存到磁碟供後續比對
