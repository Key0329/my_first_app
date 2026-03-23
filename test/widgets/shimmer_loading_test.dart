import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/widgets/shimmer_loading.dart';

/// 將待測 widget 包裝在 MaterialApp + Scaffold 以確保 MediaQuery / Theme 可用
Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(body: child),
  );
}

void main() {
  group('ShimmerLoading', () {
    testWidgets('可正常建構並顯示 child', (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerLoading(child: SizedBox(width: 100, height: 100))),
      );

      expect(find.byType(ShimmerLoading), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('enabled=false 時不顯示 ShaderMask', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const ShimmerLoading(
            enabled: false,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(ShimmerLoading), findsOneWidget);
      expect(find.byType(ShaderMask), findsNothing);
    });

    testWidgets('動畫持續運行不會拋出錯誤', (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerLoading(child: SizedBox(width: 100, height: 100))),
      );

      // 推進數個動畫幀，確保不會崩潰
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(ShimmerLoading), findsOneWidget);
    });
  });

  group('ShimmerToolGrid', () {
    testWidgets('渲染 8 個 placeholder', (tester) async {
      await tester.pumpWidget(_wrap(const ShimmerToolGrid()));

      // ShimmerToolGrid 內含 8 個 placeholder 卡片，
      // 每個卡片的最外層是一個帶有 BoxDecoration 的 Container。
      // GridView 會產生 8 個 item。
      final gridFinder = find.byType(GridView);
      expect(gridFinder, findsOneWidget);

      // 尋找 ShimmerToolGrid 下的所有 placeholder（以最外層 Container 計算）
      // 每個 _ShimmerPlaceholderCard 的 root 是一個有 BoxDecoration 的 Container，
      // 裡面又有 2 個 Container（icon area + text line），共 3 個 Container per card。
      // 我們透過 GridView 的 itemCount 驗證。
      final gridWidget = tester.widget<GridView>(gridFinder);
      final delegate =
          gridWidget.childrenDelegate as SliverChildBuilderDelegate;
      expect(delegate.estimatedChildCount, 8);
    });

    testWidgets('使用 ShimmerLoading 包裝', (tester) async {
      await tester.pumpWidget(_wrap(const ShimmerToolGrid()));

      expect(find.byType(ShimmerLoading), findsOneWidget);
    });
  });
}
