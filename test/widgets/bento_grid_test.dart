import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/widgets/bento_grid.dart';

void main() {
  // ─────────────────────────────────────────────────────────────
  // BentoGridLayout.computeRows 單元測試
  // ─────────────────────────────────────────────────────────────
  group('BentoGridLayout.computeRows', () {
    test('空列表回傳空結果', () {
      final rows = BentoGridLayout.computeRows([]);
      expect(rows, isEmpty);
    });

    test('全 medium：每兩個成一列', () {
      final sizes = [
        BentoSize.medium,
        BentoSize.medium,
        BentoSize.medium,
        BentoSize.medium,
      ];
      final rows = BentoGridLayout.computeRows(sizes);
      // 4 個 medium → 2 列，每列 2 個
      expect(rows.length, 2);
      expect(rows[0], [0, 1]);
      expect(rows[1], [2, 3]);
    });

    test('全 small：每兩個成一列', () {
      final sizes = [
        BentoSize.small,
        BentoSize.small,
        BentoSize.small,
      ];
      final rows = BentoGridLayout.computeRows(sizes);
      // 3 個 small → 列0:[0,1]，列1:[2]
      expect(rows.length, 2);
      expect(rows[0], [0, 1]);
      expect(rows[1], [2]);
    });

    test('single large：獨占一列', () {
      final sizes = [BentoSize.large];
      final rows = BentoGridLayout.computeRows(sizes);
      expect(rows.length, 1);
      expect(rows[0], [0]);
    });

    test('large 獨占一列，不與其他 item 共享', () {
      final sizes = [
        BentoSize.medium,
        BentoSize.large,
        BentoSize.medium,
      ];
      final rows = BentoGridLayout.computeRows(sizes);
      // medium(0) 先放，沒有搭檔 → 獨列 [0]
      // large(1) → 獨列 [1]
      // medium(2) → 獨列 [2]
      expect(rows.length, 3);
      expect(rows[0], [0]);
      expect(rows[1], [1]);
      expect(rows[2], [2]);
    });

    test('large/medium/small 混合排版正確', () {
      final sizes = [
        BentoSize.large,   // idx 0 → 獨列
        BentoSize.medium,  // idx 1
        BentoSize.medium,  // idx 2 → 與 idx 1 同列
        BentoSize.small,   // idx 3
        BentoSize.small,   // idx 4 → 與 idx 3 同列
        BentoSize.large,   // idx 5 → 獨列
      ];
      final rows = BentoGridLayout.computeRows(sizes);
      expect(rows.length, 4);
      expect(rows[0], [0]);       // large 獨列
      expect(rows[1], [1, 2]);    // medium 配對
      expect(rows[2], [3, 4]);    // small 配對
      expect(rows[3], [5]);       // large 獨列
    });

    test('奇數個 medium：最後一個獨列', () {
      final sizes = [
        BentoSize.medium,
        BentoSize.medium,
        BentoSize.medium,
      ];
      final rows = BentoGridLayout.computeRows(sizes);
      expect(rows.length, 2);
      expect(rows[0], [0, 1]);
      expect(rows[1], [2]);
    });
  });

  // ─────────────────────────────────────────────────────────────
  // BentoGrid widget 測試
  // ─────────────────────────────────────────────────────────────
  group('BentoGrid widget', () {
    Widget _buildApp(Widget child) {
      return MaterialApp(home: Scaffold(body: child));
    }

    testWidgets('渲染正確數量的子 widget', (tester) async {
      const itemCount = 4;
      final sizes = List.filled(itemCount, BentoSize.medium);

      await tester.pumpWidget(
        _buildApp(
          SingleChildScrollView(
            child: BentoGrid(
              sizes: sizes,
              itemCount: itemCount,
              itemBuilder: (context, index) => Text('item $index'),
            ),
          ),
        ),
      );

      for (var i = 0; i < itemCount; i++) {
        expect(find.text('item $i'), findsOneWidget);
      }
    });

    testWidgets('large item 寬度等於父容器寬度', (tester) async {
      const screenWidth = 400.0;

      await tester.binding.setSurfaceSize(const Size(screenWidth, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _buildApp(
          SingleChildScrollView(
            child: BentoGrid(
              sizes: [BentoSize.large],
              itemCount: 1,
              itemBuilder: (context, index) => Container(
                key: const Key('large-item'),
                color: Colors.red,
              ),
            ),
          ),
        ),
      );

      // large item 的容器應撐滿整列寬度（整個 BentoGrid 寬減去 padding）
      // 驗證 large item 的外層 Row 只有一個 Expanded 子項
      final rows = tester.widgetList<Row>(find.byType(Row)).toList();
      expect(rows, isNotEmpty);

      // large item 所在列的 Row 應只有 1 個 Expanded（占滿整列）
      final expandedInFirstRow = rows.first
          .children
          .whereType<Expanded>()
          .toList();
      expect(expandedInFirstRow.length, 1);
    });

    testWidgets('medium item 同列有兩個 Expanded', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          SingleChildScrollView(
            child: BentoGrid(
              sizes: [BentoSize.medium, BentoSize.medium],
              itemCount: 2,
              itemBuilder: (context, index) => Text('item $index'),
            ),
          ),
        ),
      );

      final rows = tester.widgetList<Row>(find.byType(Row)).toList();
      expect(rows, isNotEmpty);

      // 第一列應有 2 個 Expanded（兩個 medium 各占一欄）
      final expandedInRow = rows.first
          .children
          .whereType<Expanded>()
          .toList();
      expect(expandedInRow.length, 2);
    });

    testWidgets('空 BentoGrid 不拋出例外', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          SingleChildScrollView(
            child: BentoGrid(
              sizes: const [],
              itemCount: 0,
              itemBuilder: (context, index) => const SizedBox(),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
