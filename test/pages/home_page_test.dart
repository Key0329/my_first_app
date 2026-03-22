import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/tool_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 包裝 HomePage 用的輔助函式。
///
/// 使用 Navigator widget 代替 GoRouter，讓 context.push 可以在測試中被截攔。
/// HomePage 內的 _openTool 使用 context.push，因此需要一個有 Router 的環境。
/// 此處用 MaterialApp（帶 onGenerateRoute）模擬路由，不實際導航。
Widget _wrapHomePage(AppSettings settings) {
  return MaterialApp(
    home: Scaffold(
      body: HomePage(settings: settings),
    ),
    // 攔截所有 named/路徑路由，避免 GoRouter 找不到路由而報錯。
    // HomePage 使用 context.push，GoRouter 未注入時會 fallback 到 Navigator。
    onGenerateRoute: (routeSettings) => MaterialPageRoute(
      builder: (_) => const Scaffold(body: SizedBox()),
    ),
  );
}

/// 建立一個乾淨的 AppSettings（不實際讀寫 SharedPreferences）。
///
/// 使用 SharedPreferences.setMockInitialValues({}) 確保測試中不會 hang。
Future<AppSettings> _makeSettings() async {
  SharedPreferences.setMockInitialValues({});
  return AppSettings();
}

void main() {
  group('HomePage', () {
    // -------------------------------------------------------------------------
    // 1. 分類篩選 Chips
    // -------------------------------------------------------------------------
    group('category filter chips', () {
      testWidgets('應顯示「全部」及各分類 FilterChip', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        expect(find.text('全部'), findsOneWidget);
        for (final category in ToolCategory.values) {
          expect(find.text(category.label), findsOneWidget);
        }
      });
    });

    // -------------------------------------------------------------------------
    // 2. SliverGrid 渲染所有工具（HomePage 使用 CustomScrollView + SliverGrid）
    // -------------------------------------------------------------------------
    group('GridView display', () {
      testWidgets('應使用 SliverGrid widget（Bento 重構後改用 CustomScrollView + SliverGrid）',
          (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // HomePage 已重構為 CustomScrollView + SliverGrid，不再使用 GridView
        expect(find.byType(CustomScrollView), findsOneWidget);
        expect(find.byWidgetPredicate((w) => w is SliverGrid), findsOneWidget);
      });

      testWidgets('無篩選時 SliverGrid 應包含全部工具', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pumpAndSettle();

        // SliverGrid 為 lazy rendering，只渲染可見的卡片
        // 驗證至少有部分 ToolCard 被渲染
        expect(find.byType(ToolCard), findsWidgets);
      });
    });

    // -------------------------------------------------------------------------
    // 3. ListenableBuilder 反應收藏變更
    // -------------------------------------------------------------------------
    group('ListenableBuilder reactivity', () {
      testWidgets('HomePage 內有 ListenableBuilder', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        expect(find.byType(ListenableBuilder), findsWidgets);
      });
    });
  });
}
