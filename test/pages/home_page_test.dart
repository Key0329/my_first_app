import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/bento_grid.dart';
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
    // 1. 搜尋列渲染
    // -------------------------------------------------------------------------
    group('search bar', () {
      testWidgets('應顯示 SearchBar widget', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        expect(find.byType(SearchBar), findsOneWidget);
      });

      testWidgets('SearchBar 不可捲動（位於 BentoGrid 上方）', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // SearchBar 不應位於 SingleChildScrollView 內
        final scrollView = find.byType(SingleChildScrollView);
        final searchBar = find.byType(SearchBar);

        // 確認 SearchBar 存在
        expect(searchBar, findsOneWidget);

        // SearchBar 的 ancestor 中不應有 SingleChildScrollView
        final searchBarInScroll = find.ancestor(
          of: searchBar,
          matching: scrollView,
        );
        expect(searchBarInScroll, findsNothing,
            reason: 'SearchBar 不應被 SingleChildScrollView 包裹');
      });
    });

    // -------------------------------------------------------------------------
    // 2. BentoGrid 渲染所有工具
    // -------------------------------------------------------------------------
    group('BentoGrid display', () {
      testWidgets('應使用 BentoGrid widget（而非 GridView）', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        expect(find.byType(BentoGrid), findsOneWidget);
        expect(find.byType(GridView), findsNothing);
      });

      testWidgets('無搜尋時應顯示全部 12 個工具的 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // 滾動到底確保所有 ToolCard 都渲染
        await tester.pumpAndSettle();

        expect(find.byType(ToolCard), findsNWidgets(allTools.length));
      });

      testWidgets('BentoGrid 被 SingleChildScrollView 包裹', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        final bentoGrid = find.byType(BentoGrid);
        expect(bentoGrid, findsOneWidget);

        // BentoGrid 應位於 SingleChildScrollView 內
        final bentoInScroll = find.ancestor(
          of: bentoGrid,
          matching: find.byType(SingleChildScrollView),
        );
        expect(bentoInScroll, findsOneWidget,
            reason: 'BentoGrid 應被 SingleChildScrollView 包裹');
      });
    });

    // -------------------------------------------------------------------------
    // 3. 搜尋過濾
    // -------------------------------------------------------------------------
    group('search filtering', () {
      testWidgets('輸入搜尋字詞後，可見的 ToolCard 數量減少', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // 初始應有 12 個工具
        expect(find.byType(ToolCard), findsNWidgets(allTools.length));

        // 搜尋「計算機」只應找到 1 個
        await tester.enterText(find.byType(SearchBar), '計算機');
        await tester.pump();

        expect(find.byType(ToolCard), findsOneWidget);
        // 確認剩下的那張卡片是計算機（從 ToolCard widget 的 tool.id 驗證）
        final card = tester.widget<ToolCard>(find.byType(ToolCard));
        expect(card.tool.id, equals('calculator'));
      });

      testWidgets('搜尋不存在的字詞時，不顯示任何 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        await tester.enterText(find.byType(SearchBar), 'zzz不存在zzz');
        await tester.pump();

        expect(find.byType(ToolCard), findsNothing);
      });

      testWidgets('清除搜尋後恢復顯示全部 12 個工具', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // 先搜尋
        await tester.enterText(find.byType(SearchBar), '計算機');
        await tester.pump();
        expect(find.byType(ToolCard), findsOneWidget);

        // 清除搜尋
        await tester.enterText(find.byType(SearchBar), '');
        await tester.pump();
        expect(find.byType(ToolCard), findsNWidgets(allTools.length));
      });
    });

    // -------------------------------------------------------------------------
    // 4. 收藏工具使用 BentoSize.large
    // -------------------------------------------------------------------------
    group('favorite tools bento size', () {
      testWidgets('未收藏時，工具卡片使用 defaultBentoSize', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // 所有工具預設為 medium，不應有 large
        final toolCards = tester.widgetList<ToolCard>(find.byType(ToolCard));
        for (final card in toolCards) {
          expect(card.bentoSize, isNot(BentoSize.large),
              reason: '無收藏時不應有 large 卡片');
        }
      });

      testWidgets('收藏工具後，該工具的 ToolCard 使用 BentoSize.large', (tester) async {
        final settings = await _makeSettings();

        // 預先收藏「計算機」（id: 'calculator'）
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        // 找到計算機的卡片
        final toolCards =
            tester.widgetList<ToolCard>(find.byType(ToolCard)).toList();
        final calculatorCard = toolCards.firstWhere(
          (card) => card.tool.id == 'calculator',
        );

        expect(calculatorCard.bentoSize, equals(BentoSize.large),
            reason: '已收藏的工具應使用 BentoSize.large');
      });

      testWidgets('未收藏工具使用其 defaultBentoSize（而非 large）', (tester) async {
        final settings = await _makeSettings();

        // 只收藏計算機
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        final toolCards =
            tester.widgetList<ToolCard>(find.byType(ToolCard)).toList();

        // 其他工具不應是 large
        final nonFavoriteCards = toolCards.where(
          (card) => card.tool.id != 'calculator',
        );
        for (final card in nonFavoriteCards) {
          expect(card.bentoSize, isNot(BentoSize.large),
              reason: '未收藏的工具不應使用 BentoSize.large');
        }
      });

      testWidgets('BentoGrid sizes 列表的長度與過濾後工具數量相同', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        final bentoGrid = tester.widget<BentoGrid>(find.byType(BentoGrid));
        expect(bentoGrid.sizes.length, equals(allTools.length),
            reason: 'sizes 長度應與工具數量相符');
        expect(bentoGrid.itemCount, equals(allTools.length),
            reason: 'itemCount 應與工具數量相符');
      });

      testWidgets('搜尋後 BentoGrid sizes 長度與過濾後工具數量一致', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrapHomePage(settings));
        await tester.pump();

        await tester.enterText(find.byType(SearchBar), '計算機');
        await tester.pump();

        final bentoGrid = tester.widget<BentoGrid>(find.byType(BentoGrid));
        expect(bentoGrid.sizes.length, equals(1));
        expect(bentoGrid.itemCount, equals(1));
      });
    });

    // -------------------------------------------------------------------------
    // 5. ListenableBuilder 反應收藏變更
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
