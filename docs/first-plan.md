# 多合一工具箱 — Software Design Document (SDD)

> **版本**：v1.0  
> **日期**：2026-03-18  
> **作者**：Key Cheng  
> **狀態**：MVP 開發中

---

## 1. 產品概要

### 1.1 一句話定義

一款繁體中文的多合一實用工具 app，內含 12 個精品工具 + 台灣統一發票 QR Code 自動對獎，用 Flutter 同時上架 iOS 和 Android。

### 1.2 為什麼做這個

| 維度 | 說明 |
|------|------|
| **市場驗證** | CurioMate（Google Play 4.5★）和 Smart Tools（1.2M 下載、4.17★）證明品類有需求 |
| **競品痛點** | Smart Tools 付費版仍有廣告（高頻一星抱怨）、無繁中、僅 Android、UI 過時 |
| **差異化** | 台灣在地工具（統一發票對獎、坪/台斤/民國年換算）、免費暗黑模式、買斷制無廣告、跨 iOS + Android |
| **護城河** | 原 app 2025 年後未重大更新，處於維護模式；付費版有廣告是商業決策，不太可能改 |
| **可行性** | 工具型 app 技術難度低，維護成本極低（每週 < 30 分鐘），適合一人開發者 |

### 1.3 目標用戶

- **主要**：台灣 Android / iOS 用戶，需要日常實用工具但不想裝多個 app
- **次要**：其他繁中市場（香港、海外台灣人）
- **用戶現在怎麼解決**：拼裝多個 app、用 Google 內建功能、或忍受 Smart Tools 的廣告轟炸

---

## 2. 功能規格

### 2.1 MVP 功能清單（12 + 1）

#### Tier 1 — 基礎工具（Week 1-2）

| # | 工具 | 核心功能 | 關鍵技術 | 離線？ |
|---|------|---------|---------|--------|
| 1 | **計算機** | 四則運算、小數點、括號、歷史記錄 | 純 Dart 邏輯 | ✅ |
| 2 | **單位換算器** | 長度/重量/面積/溫度/貨幣 + 台灣單位（坪、台斤、民國年） | TextEditingController、DropdownButton | ✅（貨幣除外） |
| 3 | **QR Code 掃描器** | 掃描 + 產生 QR Code / Barcode | `mobile_scanner` | ✅ |
| 4 | **手電筒** | 開關 + 亮度調節 + SOS 閃爍 | `torch_light` | ✅ |
| 5 | **水平儀** | 水平 / 垂直偵測、角度顯示、震動回饋 | `sensors_plus`（加速度計） | ✅ |

#### Tier 2 — 進階工具（Week 2-3）

| # | 工具 | 核心功能 | 關鍵技術 | 離線？ |
|---|------|---------|---------|--------|
| 6 | **指南針** | 方位角、磁北/真北切換 | `sensors_plus`（磁力計） | ✅ |
| 7 | **碼錶 / 倒數計時** | 碼錶 + 圈速記錄、倒數計時 + 鬧鈴 | Timer、Stream | ✅ |
| 8 | **噪音計** | 分貝偵測、即時圖表、參考值對照 | `noise_meter`、麥克風權限 | ✅ |
| 9 | **密碼產生器** | 自訂長度/字元、一鍵複製、強度指示 | `dart:math`、Clipboard | ✅ |
| 10 | **色彩擷取器** | 從相機即時取色、HEX/RGB 值、調色盤歷史 | Camera + 像素取色 | ✅ |
| 11 | **量角器** | 觸控量角、角度顯示 | CustomPainter、GestureDetector | ✅ |

#### Tier 3 — 殺手功能（Week 3）

| # | 工具 | 核心功能 | 關鍵技術 | 離線？ |
|---|------|---------|---------|--------|
| 12 | **統一發票對獎** | 掃描發票 QR Code → 解析發票號碼 → 自動比對中獎號碼 | `mobile_scanner` + 財政部 API | ❌ 需連線 |

### 2.2 台灣在地化功能

- **單位換算器內建**：
  - 坪 ↔ 平方公尺（1 坪 = 3.305785 m²）
  - 台斤 ↔ 公斤（1 台斤 = 0.6 kg）
  - 民國年 ↔ 西元年（民國年 + 1911 = 西元年）
- **統一發票 QR Code 對獎**：
  - 財政部電子發票整合服務平台 API（需申請免費 API key）
  - QR Code 解析格式：前 10 碼 = 發票號碼（2 碼英文 + 8 碼數字）
  - 自動抓取最新一期中獎號碼
  - 顯示中獎金額和兌獎方式

### 2.3 App 架構功能

| 功能 | 說明 |
|------|------|
| **底部導航** | 三個 Tab：工具列表、收藏、設定 |
| **工具列表** | GridView 顯示工具卡片，支援搜尋 |
| **收藏功能** | 長按工具加入收藏，收藏頁快速存取 |
| **暗黑模式** | 免費提供（競品收費，這是我們的優勢） |
| **多語系** | MVP 先做繁中 + 英文 |
| **設定頁** | 主題切換、語言切換、關於、隱私政策 |

### 2.4 免費版 vs Pro 版

| 功能 | 免費版 | Pro 版（NT$60 買斷） |
|------|--------|---------------------|
| 基礎工具（#1-8） | ✅ | ✅ |
| 進階工具（#9-12） | ❌ | ✅ |
| 統一發票對獎 | ❌ | ✅ |
| 暗黑模式 | ✅ | ✅ |
| 廣告 | 底部 banner | 永久無廣告 |

---

## 3. 技術架構

### 3.1 技術棧

| 層級 | 選擇 | 理由 |
|------|------|------|
| **框架** | Flutter 3.41.x（Stable） | 一套 code 上架 iOS + Android |
| **語言** | Dart | Flutter 原生語言 |
| **狀態管理** | setState（MVP 階段） | 工具型 app 狀態簡單，不需要 Riverpod/Bloc |
| **本地儲存** | shared_preferences | 設定、收藏列表 |
| **網路請求** | http 套件 | 統一發票 API、匯率 API |
| **導航** | go_router | 類似 Vue Router 的宣告式路由 |
| **廣告** | google_mobile_ads（AdMob） | Google 官方 |
| **內購** | in_app_purchase | Google/Apple 官方 |
| **IDE** | VS Code + Flutter/Dart Extension | 開發者熟悉 |

### 3.2 專案結構

```
lib/
├── main.dart                         # App 入口
├── app.dart                          # MaterialApp + GoRouter 設定
├── theme/
│   └── app_theme.dart                # Material 3 主題（亮/暗色）
├── models/
│   └── tool_item.dart                # 工具資料模型（id, name, icon, category, isPro）
├── pages/
│   ├── home_page.dart                # 工具列表 GridView
│   ├── favorites_page.dart           # 收藏頁
│   └── settings_page.dart            # 設定頁
├── tools/
│   ├── calculator/
│   │   ├── calculator_page.dart      # UI
│   │   └── calculator_logic.dart     # 運算邏輯
│   ├── unit_converter/
│   │   ├── unit_converter_page.dart
│   │   └── units_data.dart           # 單位定義（含台灣單位）
│   ├── qr_scanner/
│   │   └── qr_scanner_page.dart
│   ├── flashlight/
│   │   └── flashlight_page.dart
│   ├── level/
│   │   └── level_page.dart
│   ├── compass/
│   │   └── compass_page.dart
│   ├── stopwatch_timer/
│   │   └── stopwatch_timer_page.dart
│   ├── noise_meter/
│   │   └── noise_meter_page.dart
│   ├── password_generator/
│   │   └── password_generator_page.dart
│   ├── color_picker/
│   │   └── color_picker_page.dart
│   ├── protractor/
│   │   └── protractor_page.dart
│   └── invoice_checker/
│       ├── invoice_checker_page.dart
│       ├── invoice_parser.dart        # QR Code 解析
│       └── invoice_api.dart           # 財政部 API 串接
├── widgets/
│   ├── tool_card.dart                # 工具卡片元件
│   └── app_scaffold.dart             # 共用外框（AppBar + 底部導航）
├── services/
│   ├── favorites_service.dart        # 收藏管理（shared_preferences）
│   ├── settings_service.dart         # 設定管理
│   └── ad_service.dart               # 廣告管理
└── utils/
    ├── constants.dart                # 常數定義
    └── permissions.dart              # 權限請求統一處理
```

### 3.3 套件依賴

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter

  # 導航
  go_router: ^14.0.0

  # 感測器
  sensors_plus: ^6.0.0                # 水平儀、指南針

  # 相機 / 掃描
  mobile_scanner: ^6.0.0             # QR Code 掃描 + 發票掃描

  # 硬體控制
  torch_light: ^1.0.0                # 手電筒

  # 音訊
  noise_meter: ^6.0.0                # 噪音計

  # 網路
  http: ^1.1.0                       # 發票 API、匯率 API

  # 本地儲存
  shared_preferences: ^2.2.0         # 設定、收藏

  # 廣告（Week 4）
  google_mobile_ads: ^5.0.0

  # 內購（Week 4）
  in_app_purchase: ^3.1.0

dev_dependencies:
  flutter_launcher_icons: ^0.14.0    # App icon 自動生成
```

### 3.4 權限需求

| 權限 | 用途 | Android | iOS |
|------|------|---------|-----|
| 相機 | QR 掃描、色彩擷取 | `CAMERA` | NSCameraUsageDescription |
| 麥克風 | 噪音計 | `RECORD_AUDIO` | NSMicrophoneUsageDescription |
| 網路 | 發票 API、匯率、廣告 | `INTERNET` | 預設允許 |

### 3.5 資料流

```
┌─────────────┐     ┌──────────────────┐     ┌───────────────┐
│  工具列表頁   │────→│   各工具頁面       │────→│   感測器 / 相機  │
│ (GridView)   │     │  (StatefulWidget)│     │   (硬體 API)    │
└─────────────┘     └──────────────────┘     └───────────────┘
       │                     │
       │                     ▼
       │              ┌──────────────────┐
       │              │ shared_preferences│
       │              │   (收藏、設定)     │
       │              └──────────────────┘
       │
       ▼
┌─────────────┐     ┌──────────────────┐
│  統一發票     │────→│   財政部 API       │
│  對獎頁面     │     │  (中獎號碼查詢)    │
└─────────────┘     └──────────────────┘
```

---

## 4. UI / UX 設計規範

### 4.1 設計語言

- **Material 3**（Flutter 內建，無需額外套件）
- **色彩系統**：使用 `ColorScheme.fromSeed()` 生成一致的色彩主題
- **字型**：系統預設字型（Noto Sans CJK TC 在中文環境下）
- **動畫**：工具切換用 Hero animation，數值變化用 AnimatedSwitcher

### 4.2 關鍵畫面

**首頁（工具列表）**
- 頂部搜尋列
- GridView 2 欄顯示工具卡片
- 每張卡片：icon + 工具名稱 + Pro 標記（如適用）
- 長按卡片 → 加入/移除收藏

**工具頁面（通用框架）**
- AppBar 顯示工具名稱 + 返回鍵
- 全螢幕工具介面
- 針對各工具最佳化的操作流程

**設定頁**
- 主題切換（亮/暗/跟隨系統）
- 語言切換（繁中/英文）
- 升級 Pro 入口
- 隱私政策、使用條款連結
- App 版本資訊

### 4.3 暗黑模式

- **免費提供**——這是核心差異化，不設付費牆
- 使用 Material 3 的 `ThemeData` 亮/暗色主題
- 支援「跟隨系統」選項

---

## 5. 變現策略

### 5.1 定價

| 方案 | 價格 | 內容 |
|------|------|------|
| 免費版 | $0 | 8 個基礎工具 + 底部 banner 廣告 + 暗黑模式 |
| Pro 買斷 | NT$60（~$1.99 USD） | 全部 12 個工具 + 統一發票對獎 + 永久無廣告 |

### 5.2 廣告策略

- **僅底部 banner**，不做插頁式廣告（interstitial）
- 不做開 app 就跳廣告
- 不做點工具就跳廣告
- **原則：廣告應該讓人「想付費移除」，而不是「想解除安裝」**

### 5.3 預估收入

| 情境 | 月下載 | 免費留存 | Pro 轉換率 | 廣告收入 | Pro 收入 | 月總收入 |
|------|--------|---------|-----------|---------|---------|---------|
| 保守 | 500 | 30% | 3% | $30 | $30 | ~$60 |
| 中等 | 2,000 | 30% | 5% | $120 | $200 | ~$320 |
| 樂觀 | 5,000 | 30% | 7% | $300 | $700 | ~$1,000 |

---

## 6. 開發時程（4 週 MVP）

### Week 1：學 Flutter + 搭框架

| 天 | 任務 | 產出 |
|----|------|------|
| Day 1-2 | 環境安裝 + 基礎練手（計算機 UI） | ✅ 已完成 |
| Day 3-4 | 專案結構 + 底部導航 + 工具列表頁 + 路由 | 可運行的 app 框架 |
| Day 5-7 | 計算機完整實作（四則運算 + UI） | 第一個完整工具 |

### Week 2：核心工具開發

| 天 | 任務 | 產出 |
|----|------|------|
| Day 1 | 單位換算器（含台灣單位） | 工具 #2 |
| Day 2 | 碼錶 / 倒數計時 | 工具 #7 |
| Day 3 | 手電筒 | 工具 #4 |
| Day 4 | 水平儀 | 工具 #5 |
| Day 5 | 指南針 | 工具 #6 |

### Week 3：進階工具 + 殺手功能

| 天 | 任務 | 產出 |
|----|------|------|
| Day 1 | QR Code 掃描器 | 工具 #3 |
| Day 2 | 密碼產生器 | 工具 #9 |
| Day 3 | 噪音計 | 工具 #8 |
| Day 4 | 色彩擷取器 | 工具 #10 |
| Day 5 | 量角器 | 工具 #11 |
| Day 6-7 | 統一發票對獎（API 串接 + QR 解析 + 比對邏輯） | 工具 #12 |

### Week 4：打磨 + 上架

| 天 | 任務 | 產出 |
|----|------|------|
| Day 1-2 | Material 3 主題統一 + 暗黑模式 + App Icon | 完整 UI |
| Day 3 | 廣告整合（AdMob）+ 內購整合 | 變現機制 |
| Day 4 | 多機型測試 + 修 bug | 穩定版本 |
| Day 5 | Google Play 上架素材（截圖、描述、隱私政策） | 上架準備 |
| Day 6-7 | 送審 Google Play + App Store（如已裝 Xcode） | 上架 |

---

## 7. 上架資訊

### 7.1 App 基本資訊

| 項目 | 內容 |
|------|------|
| **App 名稱（中文）** | 工具箱 Pro — 多合一實用工具 |
| **App 名稱（英文）** | Toolbox Pro — All-in-One Utility |
| **Package Name** | `com.appfactory.toolbox` |
| **分類** | Tools / Utilities |
| **最低 Android 版本** | Android 8.0（API 26） |
| **最低 iOS 版本** | iOS 14.0 |

### 7.2 上架費用

| 平台 | 費用 | 類型 |
|------|------|------|
| Google Play | $25 USD | 一次性 |
| App Store | $99 USD/年 | 年費 |

### 7.3 ASO 關鍵字（台灣市場）

- 多合一工具
- 工具箱
- 統一發票對獎
- QR Code 掃描
- 單位換算
- 計算機
- 水平儀
- 指南針
- 手電筒
- 實用工具

---

## 8. 風險與對策

| 風險 | 可能性 | 影響 | 對策 |
|------|--------|------|------|
| Flutter 學習曲線比預期長 | 中 | 時程延遲 | 用 Claude Code 加速、先做簡單工具建立信心 |
| 財政部 API 申請困難 | 低 | 統一發票功能延後 | 先做離線版（手動輸入發票號碼比對），API 後補 |
| 感測器在不同手機表現不一致 | 中 | 水平儀/指南針體驗差異 | 加入校準功能、多機型測試 |
| 台灣市場付費意願低 | 高 | Pro 收入低於預期 | 廣告收入為保底、觀察轉換率再調價 |
| App 審核被拒 | 低 | 上架延遲 | 遵守 Google/Apple 審核指南、先上 Google Play |

---

## 9. 維護計畫

### 上線後

| 任務 | 頻率 | 預估時間 |
|------|------|---------|
| 統一發票中獎號碼更新（API 自動） | 每 2 個月 | 0 分鐘（自動） |
| 匯率 API 監控 | 每月檢查 | 10 分鐘 |
| 用戶回饋回覆 | 每週 | 15 分鐘 |
| Bug fix（如有） | 視情況 | 不定 |
| **每週總計** | | **< 30 分鐘** |

### 後續迭代方向（MVP 後再評估）

- 更多工具（尺規、BMI 計算、匯率即時查詢）
- Widget 支援（常用工具放桌面）
- Apple Watch 版本（指南針、碼錶）
- 日文版在地化（打入日本市場）

---

## 10. 成功指標

| 指標 | 1 個月目標 | 3 個月目標 | 6 個月目標 |
|------|-----------|-----------|-----------|
| 下載量 | 500 | 3,000 | 10,000 |
| Google Play 評分 | > 4.3 | > 4.3 | > 4.5 |
| Pro 轉換率 | 3% | 5% | 7% |
| 月收入 | $60 | $320 | $1,000 |
| Crash-free rate | > 99% | > 99.5% | > 99.5% |