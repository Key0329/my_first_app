## 1. 修正 Flashlight toggle 水平置中

- [x] 1.1 明確設定 crossAxisAlignment：在 `FlashlightPage` 的 `Column` 加上 `crossAxisAlignment: CrossAxisAlignment.center`，修正 Flashlight toggle 置中問題

## 2. 驗證

- [x] 2.1 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 2.2 在模擬器上驗證手電筒頁面所有 UI 元件水平置中顯示
