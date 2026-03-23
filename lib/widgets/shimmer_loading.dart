import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 通用 shimmer 效果 wrapper widget。
///
/// 將 [child] 套上一層由左到右的光澤掃過動畫。
/// 設定 [enabled] 為 `false` 可直接顯示 child 而不帶效果。
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// 用來控制 [LinearGradient] 偏移量的 transform，
/// 讓光澤區域隨動畫值從左側滑到右側。
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent * 2 - 1),
      0,
      0,
    );
  }
}

/// 首頁工具格子的骨架屏（Skeleton Screen）。
///
/// 以 2 欄 x 4 列的圓角矩形 placeholder 模擬 [ToolCard] 佈局，
/// 整體套用 [ShimmerLoading] 效果。
class ShimmerToolGrid extends StatelessWidget {
  const ShimmerToolGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ShimmerLoading(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: DT.spaceLg),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: DT.gridSpacing,
          crossAxisSpacing: DT.gridSpacing,
          childAspectRatio: 1.0,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return _ShimmerPlaceholderCard(brightness: brightness);
        },
      ),
    );
  }
}

/// 單個 placeholder 卡片，模擬 ToolCard 的 icon area + 文字行。
class _ShimmerPlaceholderCard extends StatelessWidget {
  const _ShimmerPlaceholderCard({required this.brightness});

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final baseColor = brightness == Brightness.dark
        ? const Color(0xFF2A2A4E)
        : const Color(0xFFE0E0E0);

    return Container(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(DT.radiusMd),
      ),
      padding: const EdgeInsets.all(DT.spaceLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon area placeholder
          Container(
            width: DT.iconContainerSize,
            height: DT.iconContainerSize,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(DT.radiusSm),
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          // Text line placeholder
          Container(
            width: 64,
            height: 12,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(DT.spaceXs),
            ),
          ),
        ],
      ),
    );
  }
}
