import 'package:flutter/material.dart';
import 'package:my_first_app/models/tool_item.dart';

/// Bento Grid 排版演算法。
///
/// 將一組 [BentoSize] 依照下列規則分配成列（row）：
/// - [BentoSize.large]：獨占一整列（2 欄寬）
/// - [BentoSize.medium] / [BentoSize.small]：最多兩個同列，從前往後貪心配對
///
/// 若某個 medium/small 前方還有未配對的同型 item，則一起放入同列；
/// 否則先將未配對的 item 獨列放出，再從當前 item 重新開始嘗試配對。
/// 實際上只要遇到 large，就先排出前一個 pending，再排 large。
class BentoGridLayout {
  /// 給定各 item 的 [BentoSize]，回傳列分配結果。
  ///
  /// 每一列是一個 `List<int>`，內容為 item 在原始列表的索引。
  /// 例如：`[[0, 1], [2], [3]]`
  static List<List<int>> computeRows(List<BentoSize> sizes) {
    final rows = <List<int>>[];
    int? pending; // 等待配對的 medium/small index

    for (var i = 0; i < sizes.length; i++) {
      final size = sizes[i];

      if (size == BentoSize.large) {
        // large 前，若有 pending 的 medium/small，先獨立成列
        if (pending != null) {
          rows.add([pending]);
          pending = null;
        }
        // large 獨立成列
        rows.add([i]);
      } else {
        // medium 或 small
        if (pending != null) {
          // 配對成一列
          rows.add([pending, i]);
          pending = null;
        } else {
          // 暫時 pending，等待後方 item 配對
          pending = i;
        }
      }
    }

    // 處理最後剩下的 pending
    if (pending != null) {
      rows.add([pending]);
    }

    return rows;
  }
}

/// Bento 網格 widget。
///
/// 使用 [BentoGridLayout.computeRows] 計算排版後，以 Column of Row 方式渲染。
/// 適合在 [CustomScrollView] 的 [SliverToBoxAdapter] 中使用，
/// 或直接放在 [SingleChildScrollView] / [Column] 內。
///
/// 卡片高度：
/// - [BentoSize.large]：[baseHeight] × 1.5
/// - [BentoSize.medium]：[baseHeight] × 1.2
/// - [BentoSize.small]：[baseHeight] × 1.0
class BentoGrid extends StatelessWidget {
  const BentoGrid({
    super.key,
    required this.sizes,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 12.0,
    this.baseHeight = 120.0,
  }) : assert(sizes.length == itemCount, 'sizes.length 必須等於 itemCount');

  /// 每個 item 對應的 [BentoSize]
  final List<BentoSize> sizes;

  /// 建立各 item 的 builder
  final IndexedWidgetBuilder itemBuilder;

  /// item 總數，必須與 [sizes].length 一致
  final int itemCount;

  /// item 之間的間距（水平與垂直）
  final double spacing;

  /// 基礎格高，用以計算各尺寸的實際高度
  final double baseHeight;

  double _heightFor(BentoSize size) {
    return switch (size) {
      BentoSize.large => baseHeight * 1.5,
      BentoSize.medium => baseHeight * 1.2,
      BentoSize.small => baseHeight * 1.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) return const SizedBox.shrink();

    final rows = BentoGridLayout.computeRows(sizes);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
          _buildRow(context, rows[rowIndex]),
          // 各列間距（最後一列不加）
          if (rowIndex < rows.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<int> indices) {
    // 列高度以列中最高的 item 決定
    final rowHeight = indices.map((i) => _heightFor(sizes[i])).reduce(
          (a, b) => a > b ? a : b,
        );

    return SizedBox(
      height: rowHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var j = 0; j < indices.length; j++) ...[
            Expanded(
              child: itemBuilder(context, indices[j]),
            ),
            // item 間水平間距（最後一個不加）
            if (j < indices.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}
