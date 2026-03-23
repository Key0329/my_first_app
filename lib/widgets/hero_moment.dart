import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 強調結果數值的 scale-bounce 動畫元件。
///
/// 當 [value] 改變時（且非 null），觸發 scale 0.8 → 1.05（overshoot）→ 1.0
/// 搭配 opacity 0.5 → 1.0 的彈性動畫效果。
class HeroMoment extends StatefulWidget {
  const HeroMoment({super.key, required this.child, this.value});

  /// 要包裝的子 widget。
  final Widget child;

  /// 當此值改變時觸發動畫。若為 null 則不播放。
  final Object? value;

  @override
  State<HeroMoment> createState() => _HeroMomentState();
}

class _HeroMomentState extends State<HeroMoment>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  Object? _previousValue;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: DT.durationMedium);

    // Use easeOutBack for overshoot without exceeding TweenSequence bounds
    _scaleAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.05), weight: 60),
        TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 40),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: DT.curveDecelerate));

    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant HeroMoment oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_hasInitialized) {
      _hasInitialized = true;
      _previousValue = widget.value;
      return;
    }

    if (widget.value != null && widget.value != _previousValue) {
      _controller.forward(from: 0);
    }
    _previousValue = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final isAnimating = _controller.isAnimating || _controller.isCompleted;
        return Opacity(
          opacity: isAnimating ? _opacityAnimation.value : 1.0,
          child: Transform.scale(
            scale: isAnimating ? _scaleAnimation.value : 1.0,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
