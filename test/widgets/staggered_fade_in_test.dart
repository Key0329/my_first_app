import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';

void main() {
  group('StaggeredFadeIn', () {
    testWidgets('渲染子 widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 12,
              animate: true,
              child: Text('test child'),
            ),
          ),
        ),
      );

      expect(find.text('test child'), findsOneWidget);
    });

    testWidgets('animate: true 時使用 FadeTransition', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 12,
              animate: true,
              child: Text('animated'),
            ),
          ),
        ),
      );

      // 在 StaggeredFadeIn 內部尋找 FadeTransition
      expect(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });

    testWidgets('animate: true 時使用 SlideTransition', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 12,
              animate: true,
              child: Text('slide'),
            ),
          ),
        ),
      );

      // 在 StaggeredFadeIn 內部尋找 SlideTransition
      expect(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(SlideTransition),
        ),
        findsOneWidget,
      );
    });

    testWidgets('animate: false 時子 widget 立即顯示，不套動畫 transition', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 12,
              animate: false,
              child: Text('no animation'),
            ),
          ),
        ),
      );

      // 在 StaggeredFadeIn 內部不應有 FadeTransition 或 SlideTransition
      expect(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(FadeTransition),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(SlideTransition),
        ),
        findsNothing,
      );
      // 子 widget 應該可見
      expect(find.text('no animation'), findsOneWidget);
    });

    testWidgets('animate: true 時初始 opacity 為 0，動畫進行後 opacity 增加', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 12,
              animate: true,
              child: Text('fading'),
            ),
          ),
        ),
      );

      // 初始狀態：delay 還未完成，opacity 應為 0
      final fadeTransition = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(FadeTransition),
        ),
      );
      expect(fadeTransition.opacity.value, 0.0);

      // 推進完整動畫時間後，opacity 應為 1
      await tester.pumpAndSettle();
      final fadeTransitionAfter = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(FadeTransition),
        ),
      );
      expect(fadeTransitionAfter.opacity.value, 1.0);
    });

    testWidgets('後面的 index 有更長的 stagger 延遲', (tester) async {
      // index 5 的 stagger delay 應大於 index 0
      const staggerDelay = Duration(milliseconds: 50);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const StaggeredFadeIn(
                  index: 0,
                  totalItems: 12,
                  animate: true,
                  staggerDelay: staggerDelay,
                  child: Text('card 0'),
                ),
                const StaggeredFadeIn(
                  index: 5,
                  totalItems: 12,
                  animate: true,
                  staggerDelay: staggerDelay,
                  child: Text('card 5'),
                ),
              ],
            ),
          ),
        ),
      );

      // 推進 100ms：index 0 的動畫已在播放，index 5 (250ms delay) 尚未開始
      await tester.pump(const Duration(milliseconds: 100));

      final staggeredWidgets = tester
          .widgetList<StaggeredFadeIn>(find.byType(StaggeredFadeIn))
          .toList();

      final fadeCard0 = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byWidget(staggeredWidgets[0]),
          matching: find.byType(FadeTransition),
        ),
      );
      final fadeCard5 = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byWidget(staggeredWidgets[1]),
          matching: find.byType(FadeTransition),
        ),
      );

      // index 0 的 opacity 應大於 index 5 的 opacity
      expect(fadeCard0.opacity.value, greaterThan(fadeCard5.opacity.value));
    });

    testWidgets('支援自訂 staggerDelay 和 itemDuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredFadeIn(
              index: 0,
              totalItems: 5,
              animate: true,
              staggerDelay: Duration(milliseconds: 100),
              itemDuration: Duration(milliseconds: 400),
              child: Text('custom duration'),
            ),
          ),
        ),
      );

      expect(find.text('custom duration'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(StaggeredFadeIn),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });
  });
}
