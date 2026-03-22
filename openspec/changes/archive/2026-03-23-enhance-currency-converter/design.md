## Context

匯率換算工具使用 `frankfurter.app` API，支援 ~33 種幣別。目前幣別按字母排序，沒有 timeout，快取無過期提醒。頁面使用 ImmersiveToolScaffold 架構。

## Goals / Non-Goals

**Goals:**

- 常用幣別（TWD、USD、JPY、EUR）置頂顯示
- 新增一對多換算模式
- API request 加入 timeout
- 快取超過 24h 顯示過期警告

**Non-Goals:**

- 不更換 API 來源
- 不新增離線匯率計算（已有離線快取）
- 不支援歷史匯率圖表

## Decisions

### 常用幣別置頂排序

在 `_currencyCodes` getter 中，將 `['TWD', 'USD', 'JPY', 'EUR']` 提取到頂部（只要存在於 rates 中）。幣別選擇器用 ListView 分兩段：置頂段 + 分隔線 + 其餘按字母排序。

### 一對多換算模式

在現有的一對一模式旁新增一個「多幣別」tab 或 toggle。使用者選擇一個來源幣別和金額，勾選多個目標幣別（預設 TWD、USD、JPY、EUR），以卡片列表顯示所有換算結果。結果直接從已載入的 rates 計算，不需額外 API call。

### API timeout 設定

在 `CurrencyApi.fetchRates()` 的 `http.get()` 加入 `timeout: Duration(seconds: 10)`。timeout 時拋出 `CurrencyApiException` 並顯示錯誤訊息。

### 快取過期警告機制

`CurrencyCache` 已儲存 `_cacheTimestamp`。在 UI 層檢查 `DateTime.now().difference(_cacheTimestamp!) > Duration(hours: 24)` 時，在結果區上方顯示一個 amber warning chip：「匯率資料已超過 24 小時，建議重新整理」，附帶重新整理按鈕。

## Risks / Trade-offs

**[一對多模式增加 UI 複雜度]** → 用 SegmentedButton 切換模式，兩個模式共用同一份 rates，不增加 API 請求。

**[timeout 10 秒可能過短]** → 10 秒是合理預設。frankfurter.app 正常回應 < 2 秒，10 秒足以容納慢網路。
