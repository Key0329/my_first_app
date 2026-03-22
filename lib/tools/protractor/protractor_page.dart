import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

final Color _toolColor =
    toolGradients['protractor']?.first ?? const Color(0xFF795548);

/// Protractor (量角器) tool page.
///
/// A full-screen protractor with two draggable arms extending from a center
/// point. The user can drag either arm to measure the angle between them.
/// The angle is displayed in degrees (0–360°) in real time.
class ProtractorPage extends StatefulWidget {
  const ProtractorPage({super.key});

  @override
  State<ProtractorPage> createState() => _ProtractorPageState();
}

class _ProtractorPageState extends State<ProtractorPage> {
  /// Angle of the first (fixed-by-default) arm in radians.
  double _arm1Angle = 0;

  /// Angle of the second (draggable) arm in radians.
  double _arm2Angle = math.pi / 3; // start at 60°

  /// Which arm is currently being dragged (null if none).
  int? _activeArm;

  /// Returns the positive angle between the two arms in degrees [0, 360).
  double get _angleDegrees {
    var diff = (_arm2Angle - _arm1Angle) * 180 / math.pi;
    diff = diff % 360;
    if (diff < 0) diff += 360;
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '量角器',
      heroTag: 'tool_hero_protractor',
      headerFlex: 3,
      bodyFlex: 1,
      // 量角器視覺化區域
      headerChild: SafeArea(
        top: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            final center = Offset(size.width / 2, size.height / 2);
            final radius = math.min(size.width, size.height) * 0.38;

            return GestureDetector(
              onPanStart: (details) => _onPanStart(details, center, radius),
              onPanUpdate: (details) => _onPanUpdate(details, center),
              onPanEnd: (_) => setState(() => _activeArm = null),
              child: CustomPaint(
                size: size,
                painter: _ProtractorPainter(
                  arm1Angle: _arm1Angle,
                  arm2Angle: _arm2Angle,
                  angleDegrees: _angleDegrees,
                  radius: radius,
                  center: center,
                  isDark: isDark,
                  primaryColor: theme.colorScheme.primary,
                ),
              ),
            );
          },
        ),
      ),
      // 角度顯示與重設按鈕
      bodyChild: Padding(
        padding: const EdgeInsets.all(DT.toolBodyPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 角度數值顯示區段
            Semantics(
              label: '測量角度',
              value: '${_angleDegrees.toStringAsFixed(1)} 度',
              child: ToolSectionCard(
                label: '角度',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_angleDegrees.toStringAsFixed(1)}°',
                      style: TextStyle(
                        fontSize: DT.fontToolResult,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  // 重設按鈕
                  BouncingButton(
                    onTap: _reset,
                    child: Container(
                      height: DT.toolButtonHeight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DT.toolBodyPadding,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          DT.toolButtonRadius,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 18,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '重設',
                            style: TextStyle(
                              fontSize: DT.fontToolButton,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  void _reset() {
    setState(() {
      _arm1Angle = 0;
      _arm2Angle = math.pi / 3;
      _activeArm = null;
    });
  }

  void _onPanStart(DragStartDetails details, Offset center, double radius) {
    final pos = details.localPosition;
    final arm1End = _armEndpoint(center, _arm1Angle, radius);
    final arm2End = _armEndpoint(center, _arm2Angle, radius);

    final handleRadius = 30.0;
    final d1 = (pos - arm1End).distance;
    final d2 = (pos - arm2End).distance;

    if (d1 < handleRadius && d1 < d2) {
      _activeArm = 1;
    } else if (d2 < handleRadius) {
      _activeArm = 2;
    } else if (d1 < handleRadius * 2 && d1 < d2) {
      _activeArm = 1;
    } else if (d2 < handleRadius * 2) {
      _activeArm = 2;
    } else {
      // Fallback: drag the nearest arm
      _activeArm = d1 < d2 ? 1 : 2;
    }
  }

  void _onPanUpdate(DragUpdateDetails details, Offset center) {
    if (_activeArm == null) return;

    final pos = details.localPosition;
    final angle = math.atan2(pos.dy - center.dy, pos.dx - center.dx);

    setState(() {
      if (_activeArm == 1) {
        _arm1Angle = angle;
      } else {
        _arm2Angle = angle;
      }
    });
  }

  Offset _armEndpoint(Offset center, double angle, double radius) {
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }
}

class _ProtractorPainter extends CustomPainter {
  _ProtractorPainter({
    required this.arm1Angle,
    required this.arm2Angle,
    required this.angleDegrees,
    required this.radius,
    required this.center,
    required this.isDark,
    required this.primaryColor,
  });

  final double arm1Angle;
  final double arm2Angle;
  final double angleDegrees;
  final double radius;
  final Offset center;
  final bool isDark;
  final Color primaryColor;

  static const _arm1Color = Color(0xFFE53935); // red
  static const _arm2Color = Color(0xFF1E88E5); // blue

  @override
  void paint(Canvas canvas, Size size) {
    _drawProtractorBackground(canvas);
    _drawDegreeMarkings(canvas);
    _drawAngleArc(canvas);
    _drawArm(canvas, arm1Angle, _arm1Color);
    _drawArm(canvas, arm2Angle, _arm2Color);
    _drawCenterPoint(canvas);
    _drawAngleText(canvas);
    _drawHandle(canvas, arm1Angle, _arm1Color);
    _drawHandle(canvas, arm2Angle, _arm2Color);
  }

  void _drawProtractorBackground(Canvas canvas) {
    // Outer circle
    final bgPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius + 20, bgPaint);

    // Outer ring
    final ringPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius + 20, ringPaint);

    // Inner ring
    final innerRingPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius - 10, innerRingPaint);
  }

  void _drawDegreeMarkings(Canvas canvas) {
    final markColor = isDark ? Colors.white70 : Colors.black54;
    final textColor = isDark ? Colors.white60 : Colors.black45;

    for (var i = 0; i < 360; i++) {
      final angle = i * math.pi / 180;
      final isMajor = i % 30 == 0;
      final isMid = i % 10 == 0;

      final outerR = radius + 18;
      final innerR =
          isMajor ? radius - 5 : (isMid ? radius + 4 : radius + 10);

      final outer = Offset(
        center.dx + outerR * math.cos(angle),
        center.dy + outerR * math.sin(angle),
      );
      final inner = Offset(
        center.dx + innerR * math.cos(angle),
        center.dy + innerR * math.sin(angle),
      );

      final tickPaint = Paint()
        ..color = markColor
        ..strokeWidth = isMajor ? 2 : (isMid ? 1.2 : 0.5);

      canvas.drawLine(outer, inner, tickPaint);

      // Draw degree labels at major ticks
      if (isMajor) {
        final labelR = radius + 32;
        final labelPos = Offset(
          center.dx + labelR * math.cos(angle),
          center.dy + labelR * math.sin(angle),
        );

        final tp = TextPainter(
          text: TextSpan(
            text: '$i°',
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        tp.paint(
          canvas,
          Offset(labelPos.dx - tp.width / 2, labelPos.dy - tp.height / 2),
        );
      }
    }
  }

  void _drawAngleArc(Canvas canvas) {
    final arcPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final arcRadius = radius * 0.25;
    var sweepAngle = arm2Angle - arm1Angle;
    // Normalize to [0, 2*pi)
    sweepAngle = sweepAngle % (2 * math.pi);
    if (sweepAngle < 0) sweepAngle += 2 * math.pi;

    final rect = Rect.fromCircle(center: center, radius: arcRadius);
    canvas.drawArc(rect, arm1Angle, sweepAngle, true, arcPaint);

    // Arc stroke
    final arcStrokePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(rect, arm1Angle, sweepAngle, false, arcStrokePaint);
  }

  void _drawArm(Canvas canvas, double angle, Color color) {
    final end = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    final armPaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, end, armPaint);
  }

  void _drawHandle(Canvas canvas, double angle, Color color) {
    final handlePos = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // Outer glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handlePos, 20, glowPaint);

    // Handle circle
    final handlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handlePos, 12, handlePaint);

    // White inner circle
    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handlePos, 6, innerPaint);
  }

  void _drawCenterPoint(Canvas canvas) {
    final dotPaint = Paint()
      ..color = isDark ? Colors.white : Colors.black87
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5, dotPaint);
  }

  void _drawAngleText(Canvas canvas) {
    final angleStr = '${angleDegrees.toStringAsFixed(1)}°';

    final tp = TextPainter(
      text: TextSpan(
        text: angleStr,
        style: TextStyle(
          color: primaryColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Position the text above center
    final textOffset = Offset(
      center.dx - tp.width / 2,
      center.dy - radius * 0.55 - tp.height / 2,
    );

    // Background pill
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        textOffset.dx - 12,
        textOffset.dy - 6,
        tp.width + 24,
        tp.height + 12,
      ),
      const Radius.circular(20),
    );

    final bgPaint = Paint()
      ..color = (isDark ? Colors.black : Colors.white).withValues(alpha: 0.85);
    canvas.drawRRect(bgRect, bgPaint);

    final borderPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(bgRect, borderPaint);

    tp.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant _ProtractorPainter oldDelegate) {
    return oldDelegate.arm1Angle != arm1Angle ||
        oldDelegate.arm2Angle != arm2Angle ||
        oldDelegate.isDark != isDark;
  }
}
