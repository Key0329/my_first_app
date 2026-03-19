import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/pages/favorites_page.dart';
import 'package:my_first_app/services/settings_service.dart';
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

      testWidgets('沒有收藏時不應顯示 GridView 或 ToolCard', (tester) async {
        final settings = await _makeSettings();
        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(GridView), findsNothing);
        expect(find.byType(ToolCard), findsNothing);
      });
    });

    // -------------------------------------------------------------------------
    // 2. 有收藏時使用 GridView 顯示
    // -------------------------------------------------------------------------
    group('GridView display', () {
      testWidgets('有收藏時應使用 GridView', (tester) async {
        final settings = await _makeSettings();
        await settings.toggleFavorite('calculator');

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        expect(find.byType(GridView), findsOneWidget);
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
    // 3. ListenableBuilder 反應收藏變更
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

        // 初始應有 GridView
        expect(find.byType(GridView), findsOneWidget);

        // 移除收藏
        await settings.toggleFavorite('calculator');
        await tester.pump();

        // 應回到空狀態
        expect(find.byType(GridView), findsNothing);
        expect(find.text('尚未收藏任何工具'), findsOneWidget);
      });

      testWidgets('新增收藏後 GridView 立即更新顯示', (tester) async {
        final settings = await _makeSettings();

        await tester.pumpWidget(_wrap(settings));
        await tester.pump();

        // 初始空狀態
        expect(find.byType(GridView), findsNothing);

        // 新增收藏
        await settings.toggleFavorite('calculator');
        await tester.pump();

        // 應顯示 GridView
        expect(find.byType(GridView), findsOneWidget);
        expect(find.byType(ToolCard), findsOneWidget);
      });
    });
  });
}
