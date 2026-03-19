import 'package:flutter/material.dart';

/// 交錯淡入動畫包裝 widget。
///
/// 將子 widget 以「從下方 20px 滑入 + 淡入」的方式呈現。
/// 每個 [index] 的卡片會依序延遲 [staggerDelay]，產生交錯效果。
///
/// 當 [animate] 為 false 時，直接顯示子 widget，不播放任何動畫，
/// 適用於已完成首次載入動畫後的 tab 切換場景。
///
/// 範例：
/// ```dart
/// StaggeredFadeIn(
///   index: 3,
///   totalItems: 12,
///   animate: true,
///   child: ToolCard(...),
/// )
/// ```
class StaggeredFadeIn extends StatefulWidget {
  const StaggeredFadeIn({
    super.key,
    required this.index,
    required this.totalItems,
    required this.child,
    this.animate = true,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.itemDuration = const Duration(milliseconds: 300),
  });

  /// 此卡片在列表中的索引，決定延遲時間
  final int index;

  /// 列表總項目數（保留供未來擴充使用）
  final int totalItems;

  /// 要包裝的子 widget
  final Widget child;

  /// 是否播放動畫。false 表示直接顯示，不套任何 transition
  final bool animate;

  /// 每個項目之間的交錯延遲
  final Duration staggerDelay;

  /// 每個項目的動畫持續時間
  final Duration itemDuration;

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    // 計算此項目在整體時間軸中的起訖比例
    // 整體 controller 持續時間 = staggerDelay * index + itemDuration
    final startDelay = widget.staggerDelay * widget.index;
    final totalDuration = startDelay + widget.itemDuration;

    _controller = AnimationController(
      duration: totalDuration,
      vsync: this,
    );

    // 計算此項目動畫在整體持續時間中的區間
    final double startRatio =
        totalDuration.inMicroseconds > 0
            ? startDelay.inMicroseconds / totalDuration.inMicroseconds
            : 0.0;

    final interval = Interval(startRatio, 1.0, curve: Curves.easeOut);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: interval));

    // 從下方 20px 滑入：以比例單位表示，1.0 = 完整高度
    // 使用 Fractional offset，y=0.1 大約對應小距離向上滑動
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08), // 約 20px（相對於 widget 高度）
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: interval));

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // animate: false 時直接顯示子 widget，不套任何 transition
    if (!widget.animate) {
      return widget.child;
    }

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
