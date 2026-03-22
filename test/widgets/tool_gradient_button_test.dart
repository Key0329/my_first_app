import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/theme/design_tokens.dart';

void main() {
  const testGradientColors = [Color(0xFF6C5CE7), Color(0xFFA855F7)];

  Widget buildSubject({
    List<Color> gradientColors = testGradientColors,
    String label = '測試按鈕',
    VoidCallback? onPressed,
    IconData? icon,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ToolGradientButton(
          gradientColors: gradientColors,
          label: label,
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }

  group('ToolGradientButton', () {
    testWidgets('渲染時有正確的漸層背景', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: () {}));

      // 找到包含漸層的 Container / DecoratedBox
      final decoratedBox = tester.widget<DecoratedBox>(
        find.byWidgetPredicate((widget) {
          if (widget is DecoratedBox) {
            final decoration = widget.decoration;
            if (decoration is BoxDecoration) {
              final gradient = decoration.gradient;
              if (gradient is LinearGradient) {
                return gradient.colors.length == testGradientColors.length &&
                    gradient.colors[0] == testGradientColors[0] &&
                    gradient.colors[1] == testGradientColors[1];
              }
            }
          }
          return false;
        }),
      );

      final boxDecoration = decoratedBox.decoration as BoxDecoration;
      final gradient = boxDecoration.gradient as LinearGradient;

      // 驗證漸層角度為 135°
      // 135° 對應 begin: topLeft, end: bottomRight
      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);
      expect(gradient.colors, testGradientColors);
    });

    testWidgets('文字為白色、16dp、w600', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: () {}));

      final textWidget = tester.widget<Text>(find.text('測試按鈕'));
      final style = textWidget.style!;

      expect(style.color, Colors.white);
      expect(style.fontSize, DT.fontToolButton);
      expect(style.fontWeight, FontWeight.w600);
    });

    testWidgets('有 icon 時顯示圖標', (tester) async {
      await tester.pumpWidget(buildSubject(
        onPressed: () {},
        icon: Icons.play_arrow,
      ));

      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.play_arrow));
      expect(iconWidget.color, Colors.white);
    });

    testWidgets('沒有 icon 時不顯示圖標', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: () {}));

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('被 BouncingButton 包裹', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: () {}));

      expect(find.byType(BouncingButton), findsOneWidget);
    });

    testWidgets('onPressed 為 null 時按鈕禁用（降低不透明度）', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: null));

      // 找到 Opacity widget
      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, lessThan(1.0));
    });

    testWidgets('onPressed 不為 null 時不透明度為 1.0', (tester) async {
      await tester.pumpWidget(buildSubject(onPressed: () {}));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 1.0);
    });
  });
}
