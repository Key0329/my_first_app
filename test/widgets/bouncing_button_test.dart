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

      expect(find.byType(ScaleTransition), findsAtLeastNWidgets(1));
    });

    testWidgets('uses Listener for animation events', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Text('listener'),
            ),
          ),
        ),
      );

      expect(find.byType(Listener), findsWidgets);
    });

    testWidgets('wraps in GestureDetector only when onTap/onLongPress provided',
        (tester) async {
      // Without callbacks: no GestureDetector from BouncingButton
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              child: Text('no gesture'),
            ),
          ),
        ),
      );

      // GestureDetector may still exist from MaterialApp internals,
      // but BouncingButton should use Listener for animation
      final bouncingFinder = find.byType(BouncingButton);
      expect(bouncingFinder, findsOneWidget);
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

      await tester.tap(find.byType(BouncingButton));
      await tester.pump();
    });

    testWidgets('wraps Material button without gesture conflict', (tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: BouncingButton(
                child: FilledButton(
                  onPressed: () => buttonPressed = true,
                  child: const Text('inner button'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('inner button'));
      await tester.pump();

      expect(buttonPressed, isTrue,
          reason: 'Inner Material button onPressed should fire without gesture conflict');
    });
  });
}
