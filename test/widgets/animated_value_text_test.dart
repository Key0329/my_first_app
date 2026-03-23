import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';

void main() {
  group('AnimatedValueText', () {
    testWidgets('初始渲染顯示正確的文字', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AnimatedValueText(value: '42')),
        ),
      );

      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('值改變後顯示新文字', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AnimatedValueText(value: '10')),
        ),
      );

      expect(find.text('10'), findsOneWidget);

      // 更新值
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AnimatedValueText(value: '20')),
        ),
      );

      // 等待動畫完成（200ms 過渡時長）
      await tester.pumpAndSettle();

      expect(find.text('20'), findsOneWidget);
      expect(find.text('10'), findsNothing);
    });

    testWidgets('套用傳入的 TextStyle', (tester) async {
      const style = TextStyle(fontSize: 32, color: Colors.red);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedValueText(value: '99', style: style),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('99'));
      expect(textWidget.style?.fontSize, 32);
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('找到 AnimatedSwitcher widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AnimatedValueText(value: '0')),
        ),
      );

      expect(find.byType(AnimatedSwitcher), findsOneWidget);
    });
  });
}
