## 1. i18n 字串

- [x] [P] 1.1 在 `app_zh.arb` 和 `app_en.arb` 新增 growth-engine 相關 i18n 字串（share hook localization、retention i18n support）

## 2. 留存邏輯

- [x] [P] 2.1 在 `UserPreferencesService` 新增 streak 追蹤邏輯（usage streak tracking、streak persistence）與 daily tool recommendation 方法（每日推薦工具）

## 3. 分享文案鉤子

- [x] 3.1 實作分享文案鉤子（share hook text for tools）— 在分享流程中加入工具專屬的比較鉤子文案

## 4. 首頁 UI

- [x] 4.1 在首頁新增每日推薦卡片（daily tool recommendation）和 streak display on homepage（火焰圖示 + 天數）

## 5. 測試

- [x] [P] 5.1 撰寫 streak tracking 與 daily recommendation 的 unit test（usage streak tracking、streak persistence、daily tool recommendation）
- [x] [P] 5.2 撰寫首頁 streak 顯示與推薦卡片的 widget test（streak display on homepage）
