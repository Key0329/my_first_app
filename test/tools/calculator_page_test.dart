import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/calculator/calculator_page.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';

Widget _buildApp() {
  return const MaterialApp(
    home: CalculatorPage(),
  );
}

// CalculatorPage uses ImmersiveToolScaffold which needs a tall viewport.
const _testSurfaceSize = Size(414, 896);

void main() {
  group('Calculator button single event firing', () {
    testWidgets('tapping digit 5 appends exactly one "5" to expression',
        (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_buildApp());

      // Tap the "5" button
      await tester.tap(find.byKey(const Key('btn_5')));
      await tester.pump();

      // Expression should show "5", not "55"
      final expressionText = find.byKey(const Key('expression_display'));
      final textWidget = tester.widget<Text>(expressionText);
      expect(textWidget.data, equals('5'));
    });

    testWidgets('tapping multiple digits appends each exactly once',
        (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_buildApp());

      await tester.tap(find.byKey(const Key('btn_1')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_2')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_3')));
      await tester.pump();

      final textWidget = tester.widget<Text>(
        find.byKey(const Key('expression_display')),
      );
      expect(textWidget.data, equals('123'));
    });

    testWidgets('tapping equals after 2+3 evaluates exactly once',
        (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_buildApp());

      await tester.tap(find.byKey(const Key('btn_2')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_+')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_3')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_=')));
      await tester.pump();

      // Result should show "= 5"
      final resultWidget = tester.widget<AnimatedValueText>(
        find.byKey(const Key('result_display')),
      );
      expect(resultWidget.value, equals('= 5'));
    });

    testWidgets('operator button fires exactly once', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_buildApp());

      await tester.tap(find.byKey(const Key('btn_5')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('btn_+')));
      await tester.pump();

      final textWidget = tester.widget<Text>(
        find.byKey(const Key('expression_display')),
      );
      // Should be "5+", not "5++"
      expect(textWidget.data, equals('5+'));
    });
  });
}
