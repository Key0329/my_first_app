import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/favorites_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/bento_grid.dart';
import 'package:my_first_app/widgets/tool_card.dart';

/// 將 FavoritesPage 包裝在最基本的 MaterialApp 中以提供 Theme / MediaQuery。
Widget _wrap(AppSettings settings) {
  return MaterialApp(
    home: Scaffold(
      body: FavoritesPage(settings: settings),
    ),
  );
}

/// 建立一個已透過 SharedPreferences mock 初始化的 AppSettings。
Future<AppSettings> _makeSettings() async {
  SharedPreferences.setMockInitialValues({});
  final settings = AppSettings();
  await settings.init();
  return settings;
}

void main() {
  group('FavoritesPage', () {
    // -------------------------------------------------------------------------
    // 1. 空狀態
    // -------------------------------------------------------------------------
    group('empty state', () {
      testWidgets('沒有收藏時顯示空狀態 UI（圖示 + 提示文字）', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        // 應顯示 favorite_border 圖示
        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        // 應顯示提示文字
        expect(find.text('尚未收藏任何工具'), findsOneWidget);
        expect(find.text('長按工具卡片即可加入收藏'), findsOneWidget);
      });

      testWidgets('沒有收藏時不應顯示 BentoGrid 或 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(BentoGrid), findsNothing);
        expect(find.byType(ToolCard), findsNothing);
      });
    });

    // -------------------------------------------------------------------------
    // 2. 有收藏時使用 BentoGrid 顯示
    // -------------------------------------------------------------------------
    group('BentoGrid display', () {
      testWidgets('有收藏時應使用 BentoGrid 而非 GridView', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(BentoGrid), findsOneWidget);
        expect(find.byType(GridView), findsNothing);
      });

      testWidgets('有收藏時 BentoGrid 被 SingleChildScrollView 包裹', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        final bentoGrid = find.byType(BentoGrid);
        expect(bentoGrid, findsOneWidget);

        final bentoInScroll = find.ancestor(
          of: bentoGrid,
          matching: find.byType(SingleChildScrollView),
        );
        expect(bentoInScroll, findsOneWidget,
            reason: 'BentoGrid 應被 SingleChildScrollView 包裹');
      });

      testWidgets('收藏 1 個工具後顯示 1 個 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(ToolCard), findsOneWidget);
      });

      testWidgets('收藏 2 個工具後顯示 2 個 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');
        await settings.toggleFavorite('flashlight');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(ToolCard), findsNWidgets(2));
      });
    });

    // -------------------------------------------------------------------------
    // 3. 收藏工具全部使用 BentoSize.large
    // -------------------------------------------------------------------------
    group('large card size', () {
      testWidgets('收藏的工具 ToolCard 使用 BentoSize.large', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        final card = tester.widget<ToolCard>(find.byType(ToolCard));
        expect(card.bentoSize, equals(BentoSize.large),
            reason: '收藏頁面的工具卡片應全部使用 BentoSize.large');
      });

      testWidgets('收藏多個工具時，所有 ToolCard 均使用 BentoSize.large', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');
        await settings.toggleFavorite('flashlight');
        await settings.toggleFavorite('compass');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        final cards = tester.widgetList<ToolCard>(find.byType(ToolCard));
        for (final card in cards) {
          expect(card.bentoSize, equals(BentoSize.large),
              reason: '收藏頁面所有卡片應為 BentoSize.large');
        }
      });

      testWidgets('BentoGrid sizes 列表全部為 BentoSize.large', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');
        await settings.toggleFavorite('flashlight');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        final bentoGrid = tester.widget<BentoGrid>(find.byType(BentoGrid));
        expect(bentoGrid.itemCount, equals(2));
        expect(bentoGrid.sizes, everyElement(equals(BentoSize.large)),
            reason: 'sizes 應全部為 BentoSize.large');
      });
    });

    // -------------------------------------------------------------------------
    // 4. ListenableBuilder 反應收藏變更
    // -------------------------------------------------------------------------
    group('ListenableBuilder reactivity', () {
      testWidgets('FavoritesPage 使用 ListenableBuilder 以反應收藏變更', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(ListenableBuilder), findsWidgets);
      });

      testWidgets('移除收藏後恢復空狀態', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        // 初始應有 BentoGrid
        expect(find.byType(BentoGrid), findsOneWidget);

        // 移除收藏
        await settings.toggleFavorite('calculator');
        await tester.pump();

        // 應回到空狀態
        expect(find.byType(BentoGrid), findsNothing);
        expect(find.text('尚未收藏任何工具'), findsOneWidget);
      });

      testWidgets('新增收藏後 BentoGrid 立即更新顯示', (tester) async {
        final settings = await _makeSettings();

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        // 初始空狀態
        expect(find.byType(BentoGrid), findsNothing);

        // 新增收藏
        await settings.toggleFavorite('calculator');
        await tester.pump();

        // 應顯示 BentoGrid
        expect(find.byType(BentoGrid), findsOneWidget);
        expect(find.byType(ToolCard), findsOneWidget);
      });
    });
  });
}
