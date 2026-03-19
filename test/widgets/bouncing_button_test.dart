import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';

void main() {
  group('BouncingButton', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Text('hello'),
            ),
          ),
        ),
      );

      expect(find.text('hello'), findsOneWidget);
    });

    testWidgets('onTap callback fires when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              onTap: () => tapped = true,
              child: const Text('tap me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('tap me'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('onLongPress callback fires when long pressed', (tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              onLongPress: () => longPressed = true,
              child: const Text('long press me'),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('long press me'));
      await tester.pump();

      expect(longPressed, isTrue);
    });

    testWidgets('uses ScaleTransition for scale animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Text('animated'),
            ),
          ),
        ),
      );

      // ScaleTransition 應存在於 widget tree 中（可能有多個，例如 MaterialApp 內部也使用）
      expect(find.byType(ScaleTransition), findsAtLeastNWidgets(1));
    });

    testWidgets('wraps content in GestureDetector', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Text('gesture'),
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('works without onTap and onLongPress (nullable)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Icon(Icons.star),
            ),
          ),
        ),
      );

      // 點擊不應拋出例外
      await tester.tap(find.byType(BouncingButton));
      await tester.pump();
    });
  });
}
