import 'package:flutter/material.dart';

/// 可複用的動畫數值顯示元件。
///
/// 當 [value] 改變時，使用 [AnimatedSwitcher] 讓舊值向上滑出+淡出，
/// 新值從下方滑入+淡入，過渡時長 200ms。
class AnimatedValueText extends StatelessWidget {
  const AnimatedValueText({
    super.key,
    required this.value,
    this.style,
  });

  /// 要顯示的文字。
  final String value;

  /// 文字樣式，可選。
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        value,
        key: ValueKey<String>(value),
        style: style,
      ),
    );
  }
}
