import 'package:flutter/material.dart';

/// 通用微動效按鈕包裝元件。
///
/// 按下時縮放至 0.95（彈簧壓縮感），放開後彈回 1.0（彈性回彈）。
///
/// 使用 [AnimationController] + [ScaleTransition] 實作，搭配：
/// - 按下：100ms + [Curves.easeInOut]
/// - 放開：200ms + [Curves.elasticOut]
///
/// 範例：
/// ```dart
/// BouncingButton(
///   onTap: () => print('tapped'),
///   child: Container(
///     padding: const EdgeInsets.all(16),
///     child: const Text('Press me'),
///   ),
/// )
/// ```
class BouncingButton extends StatefulWidget {
  const BouncingButton({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  /// 要包裝的子 widget
  final Widget child;

  /// 點擊回呼（可為 null）
  final VoidCallback? onTap;

  /// 長按回呼（可為 null）
  final VoidCallback? onLongPress;

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // 初始值 1.0，壓縮方向為值減小（0.95）
      // upperBound 設 1.0 對應「未按下」，lowerBound 對應「按下」
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1.0,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95, // 完全按下時的縮放值
      end: 1.0,    // 正常狀態的縮放值
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTapDown(TapDownDetails details) async {
    // 按下：快速縮小至 0.95
    await _controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    // 放開：彈性回彈至 1.0
    await _controller.animateTo(
      1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.elasticOut,
    );
  }

  Future<void> _onTapCancel() async {
    // 取消（例如手指滑出）：同樣彈性回彈
    await _controller.animateTo(
      1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
