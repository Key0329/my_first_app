import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/widgets/tool_card.dart';

// 測試用的固定 ToolItem
final _testTool = ToolItem(
  id: 'test_tool',
  nameKey: 'tool_test',
  fallbackName: '測試工具',
  icon: Icons.build,
  routePath: '/tools/test',
  category: ToolCategory.life,
  pageBuilder: () => const SizedBox(),
);

/// 將待測 widget 包裝在 MaterialApp + Scaffold 以確保 MediaQuery / Theme 可用
Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(body: SizedBox(width: 200, height: 200, child: child)),
  );
}

void main() {
  group('ToolCard', () {
    // -------------------------------------------------------------------------
    // 1. 顯示工具名稱與圖示
    // -------------------------------------------------------------------------
    group('tool name and icon', () {
      testWidgets('顯示 tool.fallbackName 文字', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        expect(find.text('測試工具'), findsOneWidget);
      });

      testWidgets('顯示 tool.icon', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.build), findsOneWidget);
      });
    });

    // -------------------------------------------------------------------------
    // 2. Hero 包裝
    // -------------------------------------------------------------------------
    group('Hero wrapper', () {
      testWidgets('以 tool_hero_<id> 為 tag 包裝在 Hero widget 中', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        final heroFinder = find.byType(Hero);
        expect(heroFinder, findsOneWidget);

        final hero = tester.widget<Hero>(heroFinder);
        expect(hero.tag, equals('tool_hero_test_tool'));
      });
    });

    // -------------------------------------------------------------------------
    // 3. 收藏愛心按鈕
    // -------------------------------------------------------------------------
    group('favorite heart button', () {
      testWidgets('isFavorite=true 時顯示實心愛心', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: true,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('isFavorite=false 時顯示空心愛心', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      });

      testWidgets('點擊愛心按鈕觸發 onFavoriteToggle', (tester) async {
        var toggled = false;
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              onFavoriteToggle: () => toggled = true,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.favorite_border));
        expect(toggled, isTrue);
      });
    });

    // -------------------------------------------------------------------------
    // 4. InkWell 點擊互動
    // -------------------------------------------------------------------------
    group('tap interactions', () {
      testWidgets('點擊時觸發 onTap', (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () => tapped = true,
              onLongPress: () {},
              onFavoriteToggle: () {},
            ),
          ),
        );

        await tester.tap(find.byType(ToolCard));
        expect(tapped, isTrue);
      });

      testWidgets('長按時觸發 onLongPress', (tester) async {
        var longPressed = false;

        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () => longPressed = true,
              onFavoriteToggle: () {},
            ),
          ),
        );

        await tester.longPress(find.byType(ToolCard));
        expect(longPressed, isTrue);
      });
    });
  });
}
