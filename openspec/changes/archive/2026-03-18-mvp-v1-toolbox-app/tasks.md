## 1. 專案架構與 App Shell

- [x] [P] 1.1 建立專案分層目錄結構（pages, tools, widgets, services, models, theme, utils）並安裝套件依賴（go_router, sensors_plus, mobile_scanner, torch_light, noise_meter, http, shared_preferences）
- [x] 1.2 實作 App entry point and root widget — 主題系統：Material 3 + ColorScheme.fromSeed（teal seed color）
- [x] 1.3 實作 Bottom navigation with three tabs — 導航架構：GoRouter + ShellRoute 底部導航（工具、收藏、設定）
- [x] 1.4 實作 Tool list displayed as grid — 首頁 2 欄 GridView 工具卡片 + 搜尋列
- [x] 1.5 實作 Tool pages open in full screen — 工具頁面全螢幕 push 路由框架
- [x] [P] 1.6 實作狀態管理：ChangeNotifier + ListenableBuilder — 建立 AppSettings（themeMode, locale, favorites），本地儲存：shared_preferences
- [x] 1.7 實作 Dark mode support — 亮色/暗色/跟隨系統三種模式切換與持久化

## 2. 純軟體工具（Phase 1 — 開發順序：先純軟體後硬體）

- [x] [P] 2.1 實作 Basic arithmetic operations — 計算機四則運算、小數點、括號、運算優先順序（依檔案拆分原則拆出 calculator_logic.dart）
- [x] [P] 2.2 實作 Calculator display — 計算機 UI（輸入表達式、結果顯示、C 清除、退格鍵）
- [x] 2.3 實作 Calculation history — 計算機歷史記錄（檢視與清除）
- [x] [P] 2.4 實作 Unit conversion categories — 單位換算器（長度/重量/面積/溫度類別、下拉選單）（拆分 units_data.dart）
- [x] 2.5 實作 Taiwan-specific units — 台灣在地單位（坪↔平方公尺、台斤↔公斤、民國年↔西元年）
- [x] 2.6 實作 Real-time conversion — 單位換算即時更新（輸入時立即轉換）
- [x] [P] 2.7 實作 Password generation — 密碼產生器（自訂長度/字元類型、隨機產生）
- [x] 2.8 實作 One-tap copy — 密碼一鍵複製到剪貼簿
- [x] 2.9 實作 Password strength indicator — 密碼強度視覺指示器
- [x] [P] 2.10 實作 Stopwatch functionality — 碼錶（開始/停止/重置、HH:MM:SS.mm 顯示）
- [x] 2.11 實作 Lap recording — 碼錶圈速記錄
- [x] 2.12 實作 Countdown timer — 倒數計時（設定時長、歸零鬧鈴）

## 3. 相機與掃描工具（Phase 2）

- [x] 3.1 實作 QR Code and Barcode scanning — QR 掃描器（相機即時掃描、解碼顯示）
- [x] 3.2 實作 QR Code generation — QR Code 產生器（文字輸入產生 QR Code）
- [x] 3.3 實作 Camera permission handling — QR 掃描器相機權限請求與拒絕處理
- [x] 3.4 實作 Camera color picking — 色彩擷取器（相機即時取色、十字準心）
- [x] 3.5 實作 Color value display — 色彩值 HEX/RGB 顯示與一鍵複製
- [x] 3.6 實作 Color history palette — 色彩歷史調色盤（最多 20 筆）
- [x] 3.7 實作 Invoice QR Code scanning — 統一發票 QR Code 掃描與號碼解析（拆分 invoice_parser.dart）
- [x] 3.8 實作 Manual invoice number input — 統一發票手動輸入號碼
- [x] 3.9 實作 Winning number retrieval — 統一發票 API：財政部電子發票整合服務平台中獎號碼串接（拆分 invoice_api.dart）
- [x] 3.10 實作 Prize matching — 統一發票比對中獎與獎金顯示

## 4. 感測器工具（Phase 3）

- [x] [P] 4.1 實作 Flashlight toggle — 手電筒開關控制
- [x] 4.2 實作 SOS mode — 手電筒 SOS 閃爍模式
- [x] [P] 4.3 實作 Level detection — 水平儀加速度計偵測與角度顯示
- [x] 4.4 實作 Vibration feedback — 水平儀水平震動回饋
- [x] [P] 4.5 實作 Compass heading display — 指南針磁力計方位角與旋轉錶盤
- [x] 4.6 實作 Cardinal direction display — 指南針方位方向顯示（N/NE/E/SE/S/SW/W/NW）
- [x] [P] 4.7 實作 Decibel measurement — 噪音計分貝偵測
- [x] 4.8 實作 Real-time chart — 噪音計即時折線圖
- [x] 4.9 實作 Reference value comparison — 噪音計參考噪音值對照
- [x] 4.10 實作 Microphone permission handling — 噪音計麥克風權限請求與拒絕處理

## 5. 特殊 UI 工具（Phase 4）

- [x] 5.1 實作 Touch-based angle measurement — 量角器觸控量角（CustomPainter + GestureDetector）
- [x] 5.2 實作 Angle display — 量角器角度即時顯示

## 6. 收藏與設定

- [x] [P] 6.1 實作 Add and remove favorites — 長按工具卡片加入/移除收藏
- [x] 6.2 實作 Favorites page — 收藏頁 GridView 顯示 + 空狀態佔位訊息
- [x] 6.3 實作 Favorites persistence — 收藏列表 shared_preferences 持久化
- [x] [P] 6.4 實作 Theme mode selection — 設定頁主題模式選擇器
- [x] 6.5 實作 Language selection — 設定頁語言選擇器
- [x] 6.6 實作 About and legal links — 設定頁版本資訊與隱私政策/使用條款連結

## 7. 多語系（Localization）

- [x] 7.1 實作 Multi-language support — Flutter 官方 i18n（flutter_localizations + ARB 檔案、繁中 + 英文）
- [x] 7.2 實作 Locale persistence — 語言設定 shared_preferences 持久化與系統語言偵測

## 8. 平台設定與上架準備

- [x] [P] 8.1 設定 Android 權限（AndroidManifest.xml — CAMERA, RECORD_AUDIO, INTERNET）
- [x] [P] 8.2 設定 iOS 權限（Info.plist — NSCameraUsageDescription, NSMicrophoneUsageDescription）
- [x] 8.3 產生 App Icon（flutter_launcher_icons）
- [x] 8.4 多機型測試與修 bug
