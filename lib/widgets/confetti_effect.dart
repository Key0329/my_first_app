import 'dart:math';

import 'package:flutter/material.dart';

import 'package:my_first_app/theme/design_tokens.dart';

/// Confetti 粒子資料
class _Particle {
  _Particle({required Random rng})
    : angle = rng.nextDouble() * 2 * pi,
      speed = 80 + rng.nextDouble() * 160, // 80-240 dp
      color = _kColors[rng.nextInt(_kColors.length)],
      radius = 3 + rng.nextDouble() * 3; // 3-6 dp

  final double angle;
  final double speed;
  final Color color;
  final double radius;

  static const _kColors = [
    DT.brandPrimary, // 0xFF6C5CE7
    Color(0xFF3B82F6),
    Color(0xFFEC4899),
    Color(0xFFF59E0B),
  ];
}

/// 使用 [CustomPainter] 繪製 confetti 粒子的畫布。
class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.particles, required this.progress});

  final List<_Particle> particles;

  /// 動畫進度 0.0 → 1.0
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = 1.0 - progress;

    for (final p in particles) {
      final distance = p.speed * progress;
      final dx = center.dx + cos(p.angle) * distance;
      final dy = center.dy + sin(p.angle) * distance;
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(Offset(dx, dy), p.radius * (1 - progress * 0.3), paint);
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Confetti 覆蓋層 Widget。
///
/// 透過 [GlobalKey<ConfettiOverlayState>] 取得 state，呼叫 [fire] 觸發 confetti 動畫。
///
/// ```dart
/// final _confettiKey = GlobalKey<ConfettiOverlayState>();
///
/// ConfettiOverlay(
///   key: _confettiKey,
///   child: MyContent(),
/// )
///
/// // 觸發
/// _confettiKey.currentState?.fire();
/// ```
class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({super.key, required this.child});

  final Widget child;

  @override
  State<ConfettiOverlay> createState() => ConfettiOverlayState();
}

class ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  static const _kParticleCount = 18;
  static const _kDuration = Duration(milliseconds: 600);

  late final AnimationController _controller;
  List<_Particle> _particles = [];
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _kDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _isActive = false);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 觸發一次 confetti 動畫。
  void fire() {
    final rng = Random();
    _particles = List.generate(_kParticleCount, (_) => _Particle(rng: rng));
    _isActive = true;
    _controller
      ..reset()
      ..forward();
    // 確保 setState 通知 build 更新
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isActive)
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _ConfettiPainter(
                        particles: _particles,
                        progress: _controller.value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
