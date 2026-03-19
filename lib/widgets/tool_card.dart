import 'package:flutter/material.dart';
import 'package:my_first_app/models/tool_item.dart';

/// 工具卡片 widget，支援三種 Bento 尺寸並使用工具主題色漸層背景。
///
/// - [BentoSize.large]：顯示圖示、名稱，以及選用的 [miniPreview] widget
/// - [BentoSize.medium]：顯示圖示、名稱（預設尺寸）
/// - [BentoSize.small]：顯示圖示、名稱（緊湊版）
///
/// 卡片不設定固定尺寸，由父層 BentoGrid 的 Row/Expanded 決定寬高。
/// 整個卡片包裝於 [Hero] widget（tag: `tool_hero_<tool.id>`）以支援頁面轉場動畫。
class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.tool,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
    this.bentoSize = BentoSize.medium,
    this.miniPreview,
  });

  final ToolItem tool;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  /// 決定卡片的顯示尺寸變體。
  final BentoSize bentoSize;

  /// 僅在 [BentoSize.large] 時顯示的預覽 widget（選用）。
  final Widget? miniPreview;

  // ---------------------------------------------------------------------------
  // 漸層色計算
  // ---------------------------------------------------------------------------

  /// 根據亮暗模式回傳卡片背景的 LinearGradient。
  ///
  /// - 亮色模式：0.3 → 0.1 opacity
  /// - 暗色模式：0.4 → 0.15 opacity
  LinearGradient _buildGradient(bool isDark) {
    final startOpacity = isDark ? 0.4 : 0.3;
    final endOpacity = isDark ? 0.15 : 0.1;
    return LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: [
        tool.color.withValues(alpha: startOpacity),
        tool.color.withValues(alpha: endOpacity),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 子 widget 建構
  // ---------------------------------------------------------------------------

  /// 圖示圓圈（帶半透明背景）加上右上角收藏心形。
  Widget _buildIconArea() {
    return Stack(
      alignment: .topRight,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: tool.color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(tool.icon, color: tool.color, size: 24),
        ),
        if (isFavorite)
          const Icon(Icons.favorite, color: Colors.red, size: 14),
      ],
    );
  }

  /// 工具名稱文字。
  Widget _buildName(BuildContext context) {
    return Text(
      tool.fallbackName,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// large 尺寸的卡片內容（圖示 + 名稱 + 選用 miniPreview）。
  Widget _buildLargeContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIconArea(),
        const SizedBox(height: 10),
        _buildName(context),
        if (miniPreview != null) ...[
          const SizedBox(height: 12),
          // miniPreview 以 ClipRRect 圓角裁切，避免溢出卡片
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: miniPreview!,
          ),
        ],
      ],
    );
  }

  /// medium / small 尺寸的卡片內容（圖示 + 名稱）。
  Widget _buildCompactContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIconArea(),
        const SizedBox(height: 10),
        _buildName(context),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = _buildGradient(isDark);

    final content = switch (bentoSize) {
      BentoSize.large => _buildLargeContent(context),
      BentoSize.medium || BentoSize.small => _buildCompactContent(context),
    };

    return Hero(
      tag: 'tool_hero_${tool.id}',
      child: Material(
        // Material 讓 Hero 動畫期間 InkWell 效果正常呈現
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
