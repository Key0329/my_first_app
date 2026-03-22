import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';
import 'bouncing_button.dart';

/// 工具頁面漸層按鈕。
///
/// 使用 135° 線性漸層背景，搭配 [BouncingButton] 提供按壓微動效。
/// 當 [onPressed] 為 null 時，按鈕會降低不透明度表示禁用狀態。
class ToolGradientButton extends StatelessWidget {
  const ToolGradientButton({
    super.key,
    required this.gradientColors,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  /// 漸層色列表，方向 135°（左上到右下）
  final List<Color> gradientColors;

  /// 按鈕文字標籤
  final String label;

  /// 按下回呼，為 null 時按鈕禁用
  final VoidCallback? onPressed;

  /// 可選的前置圖標
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: BouncingButton(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(DT.toolButtonRadius),
          ),
          child: SizedBox(
            height: DT.toolButtonHeight,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: DT.fontToolButton,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
