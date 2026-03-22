## Context

目前 18 個工具的路由在 `app.dart` 中逐一手動定義，每條路由都是完全相同的 boilerplate（GoRoute + CustomTransitionPage + FadeTransition）。`ToolItem` model 只存放靜態資訊（id、名稱、icon、routePath、category），不包含頁面建構邏輯。新增一個工具需要修改 3 處：`tool_item.dart` 的 allTools、`app.dart` 的 import 和 GoRoute。

## Goals / Non-Goals

**Goals:**

- 新增工具只需改 1 處（`tool_item.dart` 的 `allTools` 列表）
- `app.dart` 的工具路由從 `allTools` 自動生成
- 消除 `app.dart` 中 18 個工具頁面的手動 import
- 保持現有 Hero 動畫與 FadeTransition 行為不變

**Non-Goals:**

- 不改變工具頁面本身的實作
- 不引入 code generation 或 annotation-based 方案
- 不改變非工具的路由（onboarding、home、favorites、settings）
- 不變更 `ToolCategory` 或工具排序邏輯

## Decisions

### `ToolItem` 加入 `pageBuilder` 欄位

在 `ToolItem` class 新增 `pageBuilder` 欄位，型別為 `Widget Function()` — 一個無參數回傳 Widget 的函數。

```dart
class ToolItem {
  final String id;
  final String nameKey;
  final String fallbackName;
  final IconData icon;
  final String routePath;
  final ToolCategory category;
  final Widget Function() pageBuilder;
  // ...
}
```

**為什麼用 `Widget Function()` 而非 `Widget`：** lazy construction — 頁面只在路由命中時才建構，不會在 allTools 初始化時就建構 18 個頁面實例。

**為什麼不用 `GoRouterWidgetBuilder`（含 context, state）：** 目前沒有工具頁面使用路由參數，保持簡單。未來若需要可擴展。

`allTools` 改為使用函數型別後不能再是 `const`，改為 `final`。每個 ToolItem 的 `pageBuilder` 傳入對應頁面的 constructor（例如 `() => const CalculatorPage()`）。

### 路由從 `allTools` 自動生成

在 `app.dart` 的 `_buildRouter()` 中，工具路由改為從 `allTools` map 生成：

```dart
...allTools.map((tool) => GoRoute(
  path: tool.routePath,
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: tool.pageBuilder(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
)),
```

`app.dart` 只需 import `tool_item.dart`，不再 import 個別工具頁面。

### Import 集中到 `tool_item.dart`

所有工具頁面的 import 移到 `tool_item.dart`，因為 `allTools` 的 `pageBuilder` 需要引用各頁面 class。`app.dart` 的 18 個 import 全部移除。

## Risks / Trade-offs

**[import 集中化導致 tool_item.dart 變大]** → 可接受。18 個 import 是無邏輯的引用，不影響可讀性。未來 Phase 6 可用 deferred import 做懶載入。

**[allTools 不再是 const]** → 微乎其微的效能差異。`final` + top-level 變數只初始化一次。

**[無法用 const ToolItem]** → `Function` 型別不能用在 const context。但 ToolItem 只有一個全域 list，沒有 rebuild 議題。
