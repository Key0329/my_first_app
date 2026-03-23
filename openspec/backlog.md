# Product Backlog — Spectra 工具箱

> 由 CEO、PM、Engineering、QA、Marketing、Design 六角色分析產出（2026-03-22）
> 每個項目實作前用 `/spectra:propose` 建立正式 change

## 狀態說明

- [ ] 未開始
- [~] 進行中（已建立 Spectra change）
- [x] 已完成（已 archive）

---

## 依賴關係

```
#1 fix-quality-baseline ──┐
#2 app-review-prompt ─────┤ 無前置依賴
                          │
                          ├──▶ #3~#6  Phase 2 留存功能
                          ├──▶ #7~#10 Phase 3 工程基礎（平行）
                          │
#7 tool-registry ─────────┼──▶ #15~#19 Phase 5 新工具（需要自動註冊）
                          │
#9 services-refactor ─────┼──▶ #22 freemium-paywall（需要拆好的 service）
                          │
#22 freemium-paywall ─────┴──▶ #23 pro-plus-features
```

---

## Phase 1 — 品質底線 & 快速致勝（第 1-2 週）

### ~~Change #1: `fix-quality-baseline`~~ ✅ archived 2026-03-22

> 合併：1.1 Bug 修復 + 1.3 暗色對比度 | 預估：1 天
> 依賴：無

- [x] **匯率 fallback bug**：`CurrencyApi.convert()` 未知幣別靜默 fallback 為 1.0，應 throw error
- [x] **dart:io import**：`timer_notification_service.dart` 直接 import dart:io，Web build 會編譯失敗
- [x] **toolColor 不匹配**：calculator（綠 vs 紫）、compass（深橘 vs 綠）等工具的 toolColor 與 toolGradients 衝突
- [x] **Random Wheel OverlayEntry 洩漏**：返回鍵離開時 overlay 未正確移除
- [x] **darkSubtitle** 對比度 3.2:1 → 提升至 4.5:1+（改為 ~#9999BB）
- [x] **darkNavInactive** 對比度 2.1:1 → 提升至 4.5:1+（改為 ~#7777AA）

### ~~Change #2: `app-review-prompt`~~ ✅ archived 2026-03-22

> 預估：0.5 天 | 依賴：無

- [x] 整合 `in_app_review` 套件
- [x] 在 `addRecentTool` 計數達 3 時觸發評分彈窗
- [x] 觸發時機：工具完成結果後（正向情緒高點）

---

## Phase 2 — 留存核心（第 3-4 週）

### ~~Change #3: `home-screen-widgets`~~ ✅ archived 2026-03-22

> 預估：3 天 | 依賴：#1 | 備註：模擬器測試待補，iOS 需 Xcode 手動加 Widget Extension target

- [x] 計算機 Widget（iOS + Android）
- [x] 匯率 Widget（iOS + Android）

### ~~Change #4: `calculator-history`~~ ✅ archived 2026-03-22

> 預估：1 天 | 依賴：#1

- [x] 計算機 `_history` 持久化到 SharedPreferences
- [x] 歷史上限 100 筆
- [x] 支援搜尋歷史

### ~~Change #5: `tool-recommendations`~~ ✅ archived 2026-03-22

> 預估：1.5 天 | 依賴：#1

- [x] 建立工具關聯圖譜（計算機→單位換算、匯率→分帳 等）
- [x] 在工具結果頁底部顯示推薦卡片

### ~~Change #6: `share-result-cards`~~ ✅ archived 2026-03-22

> 預估：2 天 | 依賴：#1

- [x] 使用 `RepaintBoundary` + `toImage()` 生成結果卡片圖片
- [x] 卡片帶品牌漸層邊框 + App 水印
- [x] 優先支援：AA 分帳、BMI、轉盤結果、日期倒數

---

## Phase 3 — 工程基礎設施（第 3-6 週，與 Phase 2 平行）

### ~~Change #7: `tool-registry`~~ ✅ archived 2026-03-22

> 預估：2 天 | 依賴：#1 | 備註：Phase 5 新工具的前置條件

- [x] `ToolItem` 加入 `pageBuilder` 欄位
- [x] `app.dart` 路由從 `allTools` 自動生成（消除 4 處手動維護）
- [x] 新增工具只需改 1 處

### ~~Change #8: `ci-cd-pipeline`~~ ✅ archived 2026-03-22

> 預估：1.5 天 | 依賴：無

- [x] GitHub Actions：`flutter analyze` + `flutter test` + 格式化
- [x] 測試覆蓋率報告（lcov）+ 覆蓋率門檻
- [ ] 自動建構 APK/IPA（Fastlane）— 留待後續獨立 change

### ~~Change #9: `services-refactor`~~ ✅ archived 2026-03-22

> 合併：3.3 SP 快取 + 3.4 AppSettings 拆分 | 預估：2 天
> 依賴：#1 | 備註：Phase 6 freemium 的前置條件

- [x] `init()` 時保存 SharedPreferences instance 為成員變數，移除重複 `getInstance()` 呼叫
- [x] 拆為 ThemeService / FavoritesService / UserPreferencesService
- [x] 解決 MaterialApp.router 過度 rebuild 問題

### ~~Change #10: `i18n-completion`~~ ✅ archived 2026-03-23

> 預估：2-3 天 | 依賴：#1

- [x] 首頁、設定頁、所有工具頁面的 UI 文字接入 AppLocalizations
- [x] 移除所有硬編碼中文字串

---

## Phase 4 — 工具深度優化（第 5-8 週）

### ~~Change #11: `enhance-currency-converter`~~ ✅ archived 2026-03-23

> 預估：2 天 | 依賴：#1

- [x] 常用幣別置頂（TWD、USD、JPY、EUR）
- [x] 多幣別同時顯示（一對多）
- [x] API timeout 設定
- [x] 快取過期機制（24h 顯示警告）

### ~~Change #12: `enhance-split-bill`~~ ✅ archived 2026-03-23

> 預估：2 天 | 依賴：#1

- [x] 不等分模式（按比例分）
- [x] 小費百分比選項（0/5/10/15/20%）
- [x] 多項目拆分

### ~~Change #13: `enhance-color-picker`~~ ✅ archived 2026-03-23

> 預估：2 天 | 依賴：#1

- [x] 從相簿選圖取色
- [x] 色彩歷史記錄（持久化）
- [x] 色碼格式切換（HEX/RGB/HSL）

### ~~Change #14: `enhance-life-tools`~~ ✅ archived 2026-03-23

> 合併：碼錶強化 + 密碼產生器強化 + QR 產生器強化 | 預估：2 天
> 依賴：#1

**碼錶/計時器：**
- [x] 快捷時間按鈕（3/5/10/15/30min）
- [x] 「再來一次」按鈕
- [x] 分圈紀錄匯出

**密碼產生器：**
- [x] 密碼歷史（持久化儲存）
- [x] 易記密碼模式（word-based）

**QR 產生器：**
- [x] 支援 WiFi、Email 類型模板

---

## Phase 5 — 新工具 & 成長功能（第 7-12 週）

### ~~Change #15: `tool-word-counter`~~ ✅ archived 2026-03-23

> 預估：1 天 | 依賴：#7 tool-registry

- [x] 文字計數器（字數、字元數、段落數、預估閱讀時間）

### ~~Change #16: `tool-pomodoro`~~ ✅ archived 2026-03-23

> 預估：3 天 | 依賴：#7 tool-registry

- [x] 番茄鐘計時（25/5 循環，可自訂）
- [x] 白噪音播放（結合現有 audioplayers）
- [x] 專注統計

### ~~Change #17: `tool-quick-notes`~~ ✅ archived 2026-03-23

> 預估：2 天 | 依賴：#7 tool-registry

- [x] 快速筆記建立/編輯/刪除
- [x] 本地持久化

### Change #18: `tool-invoice-checker`

> 預估：2 天 | 依賴：#7 tool-registry | 備註：已有 spec `tool-invoice-checker`

- [ ] 統一發票對獎（手動輸入 + QR 掃描）
- [ ] 中獎結果顯示 + 分享

### Change #19: `tool-translator`

> 預估：2 天 | 依賴：#7 tool-registry

- [ ] 翻譯工具（免費 API 整合）
- [ ] 與匯率形成「旅行套裝」

### Change #20: `growth-engine`

> 合併：5.2 病毒傳播 + 5.3 留存機制 | 預估：3 天
> 依賴：#6 share-result-cards

**病毒傳播：**
- [ ] 噪音大挑戰（比較分貝）
- [ ] 日期倒數卡片分享
- [ ] 分帳挑戰語氣優化
- [ ] 分享文案加入「比較鉤子」

**留存機制：**
- [ ] 每日推薦工具（首頁頂部卡片）
- [ ] 使用連續天數 Streak
- [ ] 智慧通知（匯率波動、週五分帳提醒）

### Change #21: `personalization`

> 預估：3 天 | 依賴：#9 services-refactor

- [ ] 工具排序 / 拖曳排列
- [ ] 自訂 App Icon 樣式
- [ ] 自訂品牌色主題

---

## Phase 6 — 變現 & 規模化（第 10-16 週）

### Change #22: `freemium-paywall`

> 預估：3 天 | 依賴：#9 services-refactor

- [ ] `AppSettings` 加入 `isPro` 狀態
- [ ] 免費版底部 banner 廣告（不遮擋操作）
- [ ] Pro 一次性買斷 NT$90（去廣告 + 自訂主題 + Widget）
- [ ] StoreKit2 / Google Play Billing 整合

### Change #23: `pro-plus-features`

> 預估：3 天 | 依賴：#22 freemium-paywall

- [ ] 計算歷史雲端同步（iCloud）
- [ ] 匯率即時通知
- [ ] 發票自動對獎

### Change #24: `architecture-scaling`

> 預估：5 天 | 依賴：#7 tool-registry, #9 services-refactor

- [ ] Tool Plugin 化架構
- [ ] Deferred import 懶載入
- [ ] Remote Config / Feature Flags
- [ ] 分類系統升級（tag / 多標籤）
- [ ] iPad / Tablet 適配

---

## Phase 7 — 設計系統成熟化（持續進行，可穿插於任何 Phase）

### Change #25: `design-system-v2`

> 合併：7.1 Token 補齊 + 7.4 Accessibility | 預估：3 天
> 依賴：#1 fix-quality-baseline

**Design Token 補齊：**
- [ ] 完整 Typography Scale（Display/Headline/Title/Body/Caption）
- [ ] Shadow/Elevation Token
- [ ] Semantic Color Token（三層架構）
- [ ] Animation Curve Token
- [ ] Iconography 尺寸規範

**Accessibility：**
- [ ] 全工具 Semantics 標註
- [ ] 數值變化 liveRegion
- [ ] Slider semanticFormatterCallback
- [ ] 色彩對比度全面驗證

### Change #26: `ux-polish`

> 合併：7.2 首頁體驗 + 7.3 微互動 | 預估：3 天
> 依賴：#25 design-system-v2

**首頁體驗：**
- [ ] 搜尋改為 placeholder 搜尋欄
- [ ] Tab 切換加過渡動畫
- [ ] 最近使用只在「全部」tab 顯示
- [ ] 常用工具置頂大卡片 + 其餘 3 欄小格

**微互動：**
- [ ] Hero 飛行動畫優化（icon 容器展開為 header）
- [ ] 收藏 confetti 粒子效果
- [ ] 首頁 Shimmer 載入
- [ ] 標題區滾動縮小（SliverAppBar 風格）
- [ ] 結果展示「Hero Moment」+ 慶祝動畫

### Change #27: `brand-visual-upgrade`

> 預估：2 天 | 依賴：#25 design-system-v2

- [ ] App Icon 設計（幾何稜鏡 + 品牌漸層）
- [ ] Splash Screen 品牌化
- [ ] Onboarding 視覺升級（Lottie 動畫）

---

## 上架 Checklist（Phase 2-3 完成後啟動）

> 非程式碼 change，獨立追蹤

- [ ] ASO 素材：截圖 5 張（情境式）+ 文案 + 關鍵字
- [ ] 短影片 5 支存檔
- [ ] PTT / Dcard / FB 發文草稿
- [ ] Apple Developer 帳號
- [ ] App Store + Google Play 提交審核
- [ ] Deep Link deferred link（未安裝導向商店）
- [ ] Apple Search Ads 帳號開通

---

## 總覽

| # | Change 名稱 | Phase | 預估 | 依賴 |
|---|------------|-------|------|------|
| ~~1~~ | ~~`fix-quality-baseline`~~ ✅ | 1 | 1d | — |
| ~~2~~ | ~~`app-review-prompt`~~ ✅ | 1 | 0.5d | — |
| ~~3~~ | ~~`home-screen-widgets`~~ ✅ | 2 | 3d | #1 |
| ~~4~~ | ~~`calculator-history`~~ ✅ | 2 | 1d | #1 |
| ~~5~~ | ~~`tool-recommendations`~~ ✅ | 2 | 1.5d | #1 |
| ~~6~~ | ~~`share-result-cards`~~ ✅ | 2 | 2d | #1 |
| ~~7~~ | ~~`tool-registry`~~ ✅ | 3 | 2d | #1 |
| ~~8~~ | ~~`ci-cd-pipeline`~~ ✅ | 3 | 1.5d | — |
| ~~9~~ | ~~`services-refactor`~~ ✅ | 3 | 2d | #1 |
| ~~10~~ | ~~`i18n-completion`~~ ✅ | 3 | 2-3d | #1 |
| ~~11~~ | ~~`enhance-currency-converter`~~ ✅ | 4 | 2d | #1 |
| ~~12~~ | ~~`enhance-split-bill`~~ ✅ | 4 | 2d | #1 |
| ~~13~~ | ~~`enhance-color-picker`~~ ✅ | 4 | 2d | #1 |
| ~~14~~ | ~~`enhance-life-tools`~~ ✅ | 4 | 2d | #1 |
| ~~15~~ | ~~`tool-word-counter`~~ ✅ | 5 | 1d | #7 |
| ~~16~~ | ~~`tool-pomodoro`~~ ✅ | 5 | 3d | #7 |
| ~~17~~ | ~~`tool-quick-notes`~~ ✅ | 5 | 2d | #7 |
| 18 | `tool-invoice-checker` | 5 | 2d | #7 |
| 19 | `tool-translator` | 5 | 2d | #7 |
| 20 | `growth-engine` | 5 | 3d | #6 |
| 21 | `personalization` | 5 | 3d | #9 |
| 22 | `freemium-paywall` | 6 | 3d | #9 |
| 23 | `pro-plus-features` | 6 | 3d | #22 |
| 24 | `architecture-scaling` | 6 | 5d | #7, #9 |
| 25 | `design-system-v2` | 7 | 3d | #1 |
| 26 | `ux-polish` | 7 | 3d | #25 |
| 27 | `brand-visual-upgrade` | 7 | 2d | #25 |

**合計：27 changes ≈ 60 工作天 ≈ 16 週**

---

## 來源

此 Backlog 由以下角色分析產出：
- **CEO**：產品定位、商業模式、成長飛輪
- **PM**：功能缺口、工具優化、留存策略、用戶旅程
- **Engineering**：架構改進、效能優化、技術債、基礎設施
- **QA**：測試覆蓋、Bug 風險、跨平台問題、Accessibility
- **Marketing**：ASO、品牌命名、社群行銷、上架策略、競品分析
- **Design**：設計系統、首頁體驗、微互動、暗色模式、品牌視覺
