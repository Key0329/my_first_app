import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/widgets/tool_card.dart';

// 測試用的固定 ToolItem
const _testTool = ToolItem(
  id: 'test_tool',
  nameKey: 'tool_test',
  fallbackName: '測試工具',
  icon: Icons.build,
  color: Color(0xFF4CAF50),
  routePath: '/tools/test',
);

/// 將待測 widget 包裝在 MaterialApp + Scaffold 以確保 MediaQuery / Theme 可用
Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(
      body: SizedBox(
        width: 200,
        height: 200,
        child: child,
      ),
    ),
  );
}

void main() {
  group('ToolCard', () {
    // -------------------------------------------------------------------------
    // 1. 漸層背景
    // -------------------------------------------------------------------------
    group('gradient background', () {
      testWidgets('light mode：卡片擁有以 tool.color 為基礎的漸層裝飾', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
            ),
            theme: ThemeData(brightness: Brightness.light),
          ),
        );

        // 找到帶有 LinearGradient 的 Container（漸層背景）
        final containers = tester.widgetList<Container>(find.byType(Container));
        final hasGradient = containers.any((c) {
          final decoration = c.decoration;
          if (decoration is BoxDecoration) {
            final gradient = decoration.gradient;
            if (gradient is LinearGradient) {
              // 漸層應包含 tool.color 的變體色（以 opacity 變化）
              return gradient.colors.isNotEmpty;
            }
          }
          return false;
        });

        expect(hasGradient, isTrue,
            reason: '應有至少一個 Container 使用 LinearGradient 作為裝飾');
      });

      testWidgets('dark mode：卡片仍有漸層背景', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
            ),
            theme: ThemeData(brightness: Brightness.dark),
          ),
        );

        final containers = tester.widgetList<Container>(find.byType(Container));
        final hasGradient = containers.any((c) {
          final decoration = c.decoration;
          if (decoration is BoxDecoration) {
            return decoration.gradient is LinearGradient;
          }
          return false;
        });

        expect(hasGradient, isTrue,
            reason: 'dark mode 仍應有 LinearGradient');
      });
    });

    // -------------------------------------------------------------------------
    // 2. 顯示工具名稱與圖示
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
            ),
          ),
        );

        expect(find.byIcon(Icons.build), findsOneWidget);
      });
    });

    // -------------------------------------------------------------------------
    // 3. Hero 包裝
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
    // 4. 收藏圖示
    // -------------------------------------------------------------------------
    group('favorite icon', () {
      testWidgets('isFavorite=true 時顯示愛心圖示', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: true,
              onTap: () {},
              onLongPress: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('isFavorite=false 時不顯示愛心圖示', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsNothing);
      });
    });

    // -------------------------------------------------------------------------
    // 5. BentoSize 尺寸變體
    // -------------------------------------------------------------------------
    group('BentoSize variants', () {
      testWidgets('bentoSize 預設為 BentoSize.medium（不傳參數仍可 render）', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              // 不傳 bentoSize，應使用預設值
            ),
          ),
        );

        expect(find.text('測試工具'), findsOneWidget);
      });

      testWidgets('large card 在提供 miniPreview 時顯示它', (tester) async {
        const previewKey = Key('mini_preview_widget');

        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              bentoSize: BentoSize.large,
              miniPreview: const SizedBox(key: previewKey, width: 40, height: 40),
            ),
          ),
        );

        expect(find.byKey(previewKey), findsOneWidget);
      });

      testWidgets('medium card 不顯示 miniPreview（即便提供）', (tester) async {
        const previewKey = Key('mini_preview_should_not_show');

        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              bentoSize: BentoSize.medium,
              miniPreview: const SizedBox(key: previewKey, width: 40, height: 40),
            ),
          ),
        );

        expect(find.byKey(previewKey), findsNothing);
      });

      testWidgets('small card 不顯示 miniPreview（即便提供）', (tester) async {
        const previewKey = Key('mini_preview_small_should_not_show');

        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              bentoSize: BentoSize.small,
              miniPreview: const SizedBox(key: previewKey, width: 40, height: 40),
            ),
          ),
        );

        expect(find.byKey(previewKey), findsNothing);
      });

      testWidgets('large card 不提供 miniPreview 時不崩潰', (tester) async {
        await tester.pumpWidget(
          _wrap(
            ToolCard(
              tool: _testTool,
              isFavorite: false,
              onTap: () {},
              onLongPress: () {},
              bentoSize: BentoSize.large,
              // miniPreview 為 null
            ),
          ),
        );

        expect(find.text('測試工具'), findsOneWidget);
      });
    });

    // -------------------------------------------------------------------------
    // 6. InkWell 點擊互動
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
            ),
          ),
        );

        await tester.longPress(find.byType(ToolCard));
        expect(longPressed, isTrue);
      });
    });
  });
}
