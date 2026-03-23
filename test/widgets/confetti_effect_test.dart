import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/widgets/confetti_effect.dart';

void main() {
  group('ConfettiOverlay', () {
    testWidgets('可正常建構並渲染 child', (tester) async {
      final key = GlobalKey<ConfettiOverlayState>();
      await tester.pumpWidget(
        MaterialApp(
          home: ConfettiOverlay(key: key, child: const Text('Hello')),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
      expect(find.byType(ConfettiOverlay), findsOneWidget);
    });

    testWidgets('fire() 不會拋出例外', (tester) async {
      final key = GlobalKey<ConfettiOverlayState>();
      await tester.pumpWidget(
        MaterialApp(
          home: ConfettiOverlay(key: key, child: const SizedBox.shrink()),
        ),
      );

      // 呼叫 fire() 應正常執行
      expect(() => key.currentState!.fire(), returnsNormally);

      // pump 讓動畫進行，確認不會 crash
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('fire() 觸發後顯示 CustomPaint', (tester) async {
      final key = GlobalKey<ConfettiOverlayState>();
      await tester.pumpWidget(
        MaterialApp(
          home: ConfettiOverlay(key: key, child: const SizedBox.expand()),
        ),
      );

      // 觸發前不應有 CustomPaint（confetti 部分）
      // Stack 中只有 child
      final customPaintsBefore = find.byType(CustomPaint);
      final countBefore = tester.widgetList(customPaintsBefore).length;

      key.currentState!.fire();
      await tester.pump();

      // 觸發後應多出 CustomPaint
      final customPaintsAfter = find.byType(CustomPaint);
      final countAfter = tester.widgetList(customPaintsAfter).length;
      expect(countAfter, greaterThan(countBefore));

      // 等動畫結束
      await tester.pumpAndSettle();
    });
  });
}
