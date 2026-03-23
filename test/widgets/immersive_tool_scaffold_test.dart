import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';

/// 輔助函式：以指定 brightness 包裝待測 widget
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: child,
  );
}

void main() {
  group('ImmersiveToolScaffold', () {
    const testColor = Color(0xFF4CAF50); // 綠色作為測試工具色

    // ─── 基本渲染 ───────────────────────────────────────────────
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '測試工具',
            headerChild: const Text('header'),
            bodyChild: const Text('body'),
          ),
        ),
      );
      expect(find.byType(ImmersiveToolScaffold), findsOneWidget);
    });

    // ─── AppBar 標題 ────────────────────────────────────────────
    testWidgets('AppBar shows title text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '我的工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );
      expect(find.text('我的工具'), findsOneWidget);
    });

    // ─── 子 widget 渲染 ─────────────────────────────────────────
    testWidgets('renders headerChild and bodyChild', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const Text('header content'),
            bodyChild: const Text('body content'),
          ),
        ),
      );
      expect(find.text('header content'), findsOneWidget);
      expect(find.text('body content'), findsOneWidget);
    });

    // ─── 漸層背景（使用 toolColor） ──────────────────────────────
    testWidgets('gradient background uses toolColor in light mode', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );

      // 應存在帶有 LinearGradient 的 Container（漸層背景）
      final containers = tester.widgetList<Container>(find.byType(Container));
      final gradientContainer = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.gradient is LinearGradient;
        }
        return false;
      }).toList();

      expect(
        gradientContainer,
        isNotEmpty,
        reason: '應有至少一個帶 LinearGradient 的 Container',
      );

      // 取第一個漸層並驗證顏色包含 toolColor
      final gradient =
          (gradientContainer.first.decoration! as BoxDecoration).gradient!
              as LinearGradient;

      // Light mode: [toolColor.withValues(alpha: 0.8), toolColor.withValues(alpha: 0.4)]
      expect(gradient.colors.length, 2);
      // 比較 RGB channel（使用新版 .r/.g/.b API）
      expect(
        (gradient.colors[0].r * 255.0).round(),
        (testColor.r * 255.0).round(),
      );
      expect(
        (gradient.colors[0].g * 255.0).round(),
        (testColor.g * 255.0).round(),
      );
      expect(
        (gradient.colors[0].b * 255.0).round(),
        (testColor.b * 255.0).round(),
      );
      // 起始 opacity ≈ 0.8（tolerance ±0.02）
      expect(
        gradient.colors[0].a,
        closeTo(0.8, 0.02),
        reason: 'light mode 起始顏色 opacity 應為 0.8',
      );
      // 結尾 opacity ≈ 0.4
      expect(
        gradient.colors[1].a,
        closeTo(0.4, 0.02),
        reason: 'light mode 結尾顏色 opacity 應為 0.4',
      );
    });

    testWidgets('gradient uses lower opacity in dark mode', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
          brightness: Brightness.dark,
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      final gradientContainer = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.gradient is LinearGradient;
        }
        return false;
      }).toList();

      expect(gradientContainer, isNotEmpty);

      final gradient =
          (gradientContainer.first.decoration! as BoxDecoration).gradient!
              as LinearGradient;

      // Dark mode: [toolColor.withValues(alpha: 0.5), toolColor.withValues(alpha: 0.2)]
      expect(
        gradient.colors[0].a,
        closeTo(0.5, 0.02),
        reason: 'dark mode 起始顏色 opacity 應為 0.5',
      );
      expect(
        gradient.colors[1].a,
        closeTo(0.2, 0.02),
        reason: 'dark mode 結尾顏色 opacity 應為 0.2',
      );
    });

    // ─── 預設 flex ratio 2:3 ─────────────────────────────────────
    testWidgets('default flex ratio is headerFlex=2 bodyFlex=3', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );

      // 找出所有 Expanded，驗證 flex 值為 2 與 3
      final expandedWidgets = tester
          .widgetList<Expanded>(find.byType(Expanded))
          .toList();

      final flexValues = expandedWidgets.map((e) => e.flex).toSet();
      expect(
        flexValues,
        containsAll([2, 3]),
        reason: '預設應存在 flex=2 和 flex=3 的 Expanded',
      );
    });

    // ─── 自訂 flex ratio ──────────────────────────────────────────
    testWidgets('custom flex ratios are applied', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
            headerFlex: 1,
            bodyFlex: 4,
          ),
        ),
      );

      final expandedWidgets = tester
          .widgetList<Expanded>(find.byType(Expanded))
          .toList();
      final flexValues = expandedWidgets.map((e) => e.flex).toSet();
      expect(
        flexValues,
        containsAll([1, 4]),
        reason: '自訂後應存在 flex=1 和 flex=4 的 Expanded',
      );
    });

    // ─── body 圓角（24px） ───────────────────────────────────────
    testWidgets('body section has rounded top corners with radius 24', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );

      // 尋找帶有 BorderRadius 包含 topLeft/topRight Radius(24) 的 Container
      final containers = tester.widgetList<Container>(find.byType(Container));
      final roundedBodyContainers = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          final br = decoration.borderRadius;
          if (br is BorderRadius) {
            return br.topLeft == const Radius.circular(24) &&
                br.topRight == const Radius.circular(24);
          }
        }
        return false;
      }).toList();

      expect(
        roundedBodyContainers,
        isNotEmpty,
        reason: 'body Container 應有 topLeft/topRight radius = 24',
      );
    });

    // ─── extendBodyBehindAppBar ──────────────────────────────────
    testWidgets('Scaffold has extendBodyBehindAppBar set to true', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(
        scaffold.extendBodyBehindAppBar,
        isTrue,
        reason: 'extendBodyBehindAppBar 必須為 true 使漸層延伸至 AppBar 後方',
      );
    });

    // ─── Hero 動畫支援 ───────────────────────────────────────────
    testWidgets('without heroTag, no Hero widget exists', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );
      // 未提供 heroTag，不應存在 Hero widget
      expect(find.byType(Hero), findsNothing);
    });

    testWidgets('with heroTag, Hero widget with correct tag exists', (
      tester,
    ) async {
      const tag = 'tool_hero_calculator';
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
            heroTag: tag,
          ),
        ),
      );
      // 提供 heroTag 後，應存在一個 Hero widget
      final heroes = tester.widgetList<Hero>(find.byType(Hero)).toList();
      expect(heroes, hasLength(1), reason: '應存在一個 Hero widget');
      expect(
        heroes.first.tag,
        equals(tag),
        reason: 'Hero.tag 應與傳入的 heroTag 相同',
      );
    });

    // ─── 漸層方向（top to bottom） ───────────────────────────────
    testWidgets('gradient direction is top to bottom', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ImmersiveToolScaffold(
            toolColor: testColor,
            title: '工具',
            headerChild: const SizedBox(),
            bodyChild: const SizedBox(),
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      final gradientContainer = containers.firstWhere((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.gradient is LinearGradient;
        }
        return false;
      });

      final gradient =
          (gradientContainer.decoration! as BoxDecoration).gradient!
              as LinearGradient;

      expect(gradient.begin, Alignment.topCenter);
      expect(gradient.end, Alignment.bottomCenter);
    });
  });
}
