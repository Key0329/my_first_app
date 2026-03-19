## Problem

手電筒工具頁面中的主要元件（開關按鈕、狀態文字、SOS 按鈕）在水平方向未置中，全部偏向螢幕左側顯示。

## Root Cause

`FlashlightPage` 的 `Column` 未明確設定 `crossAxisAlignment: CrossAxisAlignment.center`，導致子元件在某些裝置上未正確水平置中。

## Proposed Solution

在 `FlashlightPage` 的 `Column` widget 明確加上 `crossAxisAlignment: CrossAxisAlignment.center`，確保所有子元件在水平方向置中對齊。

## Success Criteria

- 手電筒開關按鈕在頁面水平方向置中顯示
- 「已開啟」/「已關閉」狀態文字置中
- SOS 模式按鈕置中
- 在不同螢幕尺寸下均維持置中對齊

## Impact

- Affected code: `lib/tools/flashlight/flashlight_page.dart`
