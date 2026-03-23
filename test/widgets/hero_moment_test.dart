import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/hero_moment.dart';

void main() {
  group('HeroMoment', () {
    testWidgets('可正常建構並顯示 child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(child: Text('結果'))),
        ),
      );

      expect(find.text('結果'), findsOneWidget);
      expect(find.byType(HeroMoment), findsOneWidget);
    });

    testWidgets('value 改變時觸發動畫，pump 後 widget 仍存在', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(value: 1, child: Text('數值'))),
        ),
      );

      expect(find.text('數值'), findsOneWidget);

      // 更新 value 觸發動畫
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(value: 2, child: Text('數值'))),
        ),
      );

      // pump 一些 frame 讓動畫進行
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('數值'), findsOneWidget);
      expect(find.byType(HeroMoment), findsOneWidget);

      // 等待動畫完全結束
      await tester.pumpAndSettle();
      expect(find.text('數值'), findsOneWidget);
    });

    testWidgets('value 為 null 時不觸發動畫', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(value: null, child: Text('空值'))),
        ),
      );

      expect(find.text('空值'), findsOneWidget);

      // 再次 rebuild 但 value 仍為 null
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(value: null, child: Text('空值'))),
        ),
      );

      // 不應有正在進行的動畫
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('空值'), findsOneWidget);

      // pumpAndSettle 應立即完成（無動畫）
      await tester.pumpAndSettle();
      expect(find.text('空值'), findsOneWidget);
    });

    testWidgets('初始 value 非 null 時不觸發動畫', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeroMoment(value: 42, child: Text('初始'))),
        ),
      );

      // pumpAndSettle 應立即完成，因為初始狀態不該觸發動畫
      await tester.pumpAndSettle();
      expect(find.text('初始'), findsOneWidget);
    });
  });
}
