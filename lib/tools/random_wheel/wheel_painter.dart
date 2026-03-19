import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 隨機轉盤的 CustomPainter。
///
/// 根據 [options] 與 [colors] 等分繪製扇形，並依 [rotation] 旋轉整個轉盤。
/// 指針固定在畫布頂部中央，不隨轉盤旋轉。
///
/// Example:
/// ```dart
/// CustomPaint(
///   painter: WheelPainter(
///     options: ['A', 'B', 'C'],
///     colors: WheelPainter.defaultColors,
///     rotation: _animationValue,
///   ),
/// )
/// ```
class WheelPainter extends CustomPainter {
  const WheelPainter({
    required this.options,
    required this.colors,
    required this.rotation,
  });

  final List<String> options;
  final List<Color> colors;

  /// 當前旋轉角度（弧度）
  final double rotation;

  /// 預設顏色列表，共 20 色，循環使用
  static const List<Color> defaultColors = [
    Color(0xFFE57373),
    Color(0xFF81C784),
    Color(0xFF64B5F6),
    Color(0xFFFFD54F),
    Color(0xFFBA68C8),
    Color(0xFF4DB6AC),
    Color(0xFFFF8A65),
    Color(0xFF90A4AE),
    Color(0xFFA1887F),
    Color(0xFF7986CB),
    Color(0xFFAED581),
    Color(0xFFF06292),
    Color(0xFF4DD0E1),
    Color(0xFFDCE775),
    Color(0xFFFFB74D),
    Color(0xFF9575CD),
    Color(0xFF4FC3F7),
    Color(0xFFE6EE9C),
    Color(0xFFEF9A9A),
    Color(0xFF80CBC4),
  ];

  // 指針高度（像素）
  static const double _pointerHeight = 20.0;
  // 指針半寬（像素）
  static const double _pointerHalfWidth = 12.0;
  // 轉盤與畫布邊緣的 padding（像素）
  static const double _padding = 8.0;
  // 文字距圓心的比例（相對半徑）
  static const double _textRadiusRatio = 0.60;
  // 扇形分隔線寬度
  static const double _dividerWidth = 2.0;
  // 文字字型大小
  static const double _fontSize = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (options.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        math.min(size.width, size.height) / 2 - _padding - _pointerHeight;

    // --- 繪製旋轉的轉盤 ---
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    _drawSectors(canvas, radius);
    _drawDividers(canvas, radius);
    _drawLabels(canvas, radius);

    canvas.restore();

    // --- 繪製固定指針（不隨轉盤旋轉）---
    _drawPointer(canvas, center, radius);
  }

  /// 繪製所有扇形
  void _drawSectors(Canvas canvas, double radius) {
    final count = options.length;
    final sweepAngle = 2 * math.pi / count;

    // 起始角度設為 -π/2（頂部），配合 rotation 讓第一個選項初始朝上
    final startOffset = -math.pi / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < count; i++) {
      paint.color = colors[i % colors.length];
      final startAngle = startOffset + i * sweepAngle;

      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
    }
  }

  /// 繪製扇形之間的分隔線
  void _drawDividers(Canvas canvas, double radius) {
    final count = options.length;
    final sweepAngle = 2 * math.pi / count;
    final startOffset = -math.pi / 2;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = _dividerWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < count; i++) {
      final angle = startOffset + i * sweepAngle;
      final lineEnd = Offset(
        math.cos(angle) * radius,
        math.sin(angle) * radius,
      );
      canvas.drawLine(Offset.zero, lineEnd, paint);
    }
  }

  /// 繪製每個扇形的文字標籤
  void _drawLabels(Canvas canvas, double radius) {
    final count = options.length;
    final sweepAngle = 2 * math.pi / count;
    final startOffset = -math.pi / 2;

    // 每個扇形可用的弧長（在 textRadiusRatio 處），用於限制文字最大寬度
    final textRadius = radius * _textRadiusRatio;
    // 弧長 ≈ 2 * textRadius * sin(sweepAngle / 2)，取略保守的值
    final maxTextWidth =
        (2 * textRadius * math.sin(sweepAngle / 2)).clamp(0, radius * 0.9);

    for (int i = 0; i < count; i++) {
      // 扇形中心角
      final midAngle = startOffset + (i + 0.5) * sweepAngle;

      // 文字中心座標（相對於轉盤圓心）
      final labelCenter = Offset(
        math.cos(midAngle) * textRadius,
        math.sin(midAngle) * textRadius,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.black38,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: maxTextWidth.toDouble());

      canvas.save();
      canvas.translate(labelCenter.dx, labelCenter.dy);
      // 沿扇形中心角方向旋轉，使文字朝向扇形外緣
      canvas.rotate(midAngle + math.pi / 2);

      // 讓文字以中心點對齊
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  /// 在畫布頂部中央繪製向下的三角形指針（固定，不旋轉）
  void _drawPointer(Canvas canvas, Offset center, double radius) {
    // 指針頂點 x = 畫布中心，y = 轉盤上緣上方 _pointerHeight 處
    final tipY = center.dy - radius - _padding;
    final tipX = center.dx;

    final path = Path()
      ..moveTo(tipX, tipY + _pointerHeight) // 尖端（朝下，指向轉盤）
      ..lineTo(tipX - _pointerHalfWidth, tipY) // 左上
      ..lineTo(tipX + _pointerHalfWidth, tipY) // 右上
      ..close();

    // 填充：深紅色
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFD32F2F)
        ..style = PaintingStyle.fill,
    );

    // 描邊：白色，增加可見度
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.options != options ||
        oldDelegate.colors != colors;
  }
}
