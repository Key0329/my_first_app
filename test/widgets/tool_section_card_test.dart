import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

/// 將待測 widget 包裝在 MaterialApp + Scaffold 以確保 MediaQuery / Theme 可用
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: Scaffold(body: child),
  );
}

void main() {
  group('ToolSectionCard', () {
    // -----------------------------------------------------------------------
    // 1. 渲染時有正確的圓角和背景色
    // -----------------------------------------------------------------------
    testWidgets('light mode 下有正確的圓角和背景色', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            child: Text('content'),
          ),
        ),
      );

      // 找到 Container / DecoratedBox 的 BoxDecoration
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ToolSectionCard),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;

      // 背景色：DT.brandPrimaryBgLight
      expect(decoration.color, equals(DT.brandPrimaryBgLight));

      // 圓角：DT.toolSectionRadius (16dp)
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(DT.toolSectionRadius)),
      );
    });

    // -----------------------------------------------------------------------
    // 2. 有 label 時顯示品牌色文字
    // -----------------------------------------------------------------------
    testWidgets('有 label 時顯示品牌色文字', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            label: '測試標題',
            child: Text('content'),
          ),
        ),
      );

      // 找到 label 文字
      expect(find.text('測試標題'), findsOneWidget);

      // 驗證字體大小與顏色
      final labelWidget = tester.widget<Text>(find.text('測試標題'));
      final style = labelWidget.style!;
      expect(style.fontSize, equals(DT.fontToolLabel));
      expect(style.color, equals(DT.brandPrimary));
    });

    // -----------------------------------------------------------------------
    // 3. 沒有 label 時不顯示標題
    // -----------------------------------------------------------------------
    testWidgets('沒有 label 時不顯示標題', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            child: Text('content'),
          ),
        ),
      );

      // 確認子 widget 存在
      expect(find.text('content'), findsOneWidget);

      // 不應該有 Column（因為沒有 label 就不需要 Column 來排列標題和內容）
      // 改為驗證：widget tree 中只有 'content' 這個 Text，沒有額外的 label Text
      final textWidgets = tester.widgetList<Text>(
        find.descendant(
          of: find.byType(ToolSectionCard),
          matching: find.byType(Text),
        ),
      );
      // 只有 'content' 這個 Text
      expect(textWidgets.length, equals(1));
      expect(textWidgets.first.data, equals('content'));
    });

    // -----------------------------------------------------------------------
    // 4. 深色模式下使用 DT.brandPrimaryBgDark 背景色
    // -----------------------------------------------------------------------
    testWidgets('dark mode 下使用 DT.brandPrimaryBgDark 背景色', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            label: '深色標題',
            child: Text('dark content'),
          ),
          brightness: Brightness.dark,
        ),
      );

      // 背景色
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ToolSectionCard),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(DT.brandPrimaryBgDark));

      // label 顏色在 dark mode 下應為 DT.brandPrimarySoft
      final labelWidget = tester.widget<Text>(find.text('深色標題'));
      expect(labelWidget.style!.color, equals(DT.brandPrimarySoft));
    });

    // -----------------------------------------------------------------------
    // 5. 內邊距為 DT.toolSectionPadding
    // -----------------------------------------------------------------------
    testWidgets('內邊距為 DT.toolSectionPadding', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            child: Text('content'),
          ),
        ),
      );

      final paddingFinder = find.descendant(
        of: find.byType(ToolSectionCard),
        matching: find.byWidgetPredicate(
          (w) =>
              w is Padding &&
              w.padding == const EdgeInsets.all(DT.toolSectionPadding),
        ),
      );

      expect(paddingFinder, findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // 6. 標題與內容之間有 8dp 間距
    // -----------------------------------------------------------------------
    testWidgets('有 label 時，標題與內容之間有 8dp 間距', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            label: '間距測試',
            child: Text('content'),
          ),
        ),
      );

      // 有 label 時使用 Column，其中應含一個 SizedBox 作為間距
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(ToolSectionCard),
          matching: find.byWidgetPredicate(
            (w) => w is SizedBox && w.height == DT.spaceSm,
          ),
        ),
      );
      expect(sizedBox.height, equals(DT.spaceSm));
    });

    // -----------------------------------------------------------------------
    // 7. 無邊框
    // -----------------------------------------------------------------------
    testWidgets('無邊框', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ToolSectionCard(
            child: Text('content'),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ToolSectionCard),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNull);
    });
  });
}
