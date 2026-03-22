import 'package:flutter/material.dart';
import 'package:my_first_app/services/haptic_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 隨機轉盤結果覆蓋動畫。
///
/// 半透明背景淡入 + 結果卡片 [Curves.elasticOut] 縮放彈跳。
/// 點擊背景或按鈕關閉，關閉時縮放淡出。
/// 出現時觸發 [HapticFeedback.heavyImpact]。
class WheelResultOverlay extends StatefulWidget {
  final String result;
  final List<Color> gradientColors;
  final VoidCallback onDismiss;

  const WheelResultOverlay({
    super.key,
    required this.result,
    required this.gradientColors,
    required this.onDismiss,
  });

  @override
  State<WheelResultOverlay> createState() => _WheelResultOverlayState();
}

class _WheelResultOverlayState extends State<WheelResultOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bgOpacity;
  late Animation<double> _cardScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _bgOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _cardScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.elasticOut),
      ),
    );

    HapticService.heavy();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: _dismiss,
          child: Container(
            color: Colors.black.withValues(alpha: 0.5 * _bgOpacity.value),
            child: Center(
              child: Transform.scale(
                scale: _cardScale.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {}, // 防止穿透點擊到背景
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: DT.space3xl),
          padding: const EdgeInsets.all(DT.space3xl),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(DT.radiusXl),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors.first.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '結果',
                style: TextStyle(
                  fontSize: DT.fontSubtitle,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: DT.spaceLg),
              Text(
                widget.result,
                style: const TextStyle(
                  fontSize: DT.fontToolResult,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DT.space2xl),
              SizedBox(
                width: double.infinity,
                height: DT.toolButtonHeight,
                child: OutlinedButton(
                  onPressed: _dismiss,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white54),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(DT.toolButtonRadius),
                    ),
                  ),
                  child: const Text(
                    '確定',
                    style: TextStyle(
                      fontSize: DT.fontToolButton,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
