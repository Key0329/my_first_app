import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// A [CustomPainter] that draws a dual-unit ruler along the canvas.
///
/// The canvas is divided vertically down the centre:
/// - **Left half** — metric (centimetre / millimetre) scale, ticks extend
///   from the left edge toward the right.
/// - **Right half** — imperial (inch / 1⁄16-inch) scale, ticks extend
///   from the right edge toward the left.
/// - A thin vertical divider is drawn at the centre.
///
/// Ticks are clipped to the visible viewport defined by [scrollOffset] and
/// the canvas height, so only visible marks are painted.
///
/// ## Usage
/// ```dart
/// CustomPaint(
///   painter: RulerPainter(
///     ppi: 160.0,
///     scrollOffset: _scrollController.offset,
///     tickColor: Colors.black87,
///     textColor: Colors.black54,
///   ),
/// )
/// ```
class RulerPainter extends CustomPainter {
  const RulerPainter({
    required this.ppi,
    required this.scrollOffset,
    required this.tickColor,
    required this.textColor,
  });

  /// Pixels per inch of the physical display.
  final double ppi;

  /// Current vertical scroll offset in logical pixels.
  final double scrollOffset;

  /// Colour used for tick marks.
  final Color tickColor;

  /// Colour used for numeric labels.
  final Color textColor;

  // ── Tick lengths (logical pixels) ──────────────────────────────────────────
  static const double _shortTickWidth = 8.0;
  static const double _midTickWidth = 16.0;
  static const double _longTickWidth = 24.0;

  // ── Typography ──────────────────────────────────────────────────────────────
  static const double _fontSize = 12.0;
  static const double _labelPadding = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Visible y-range in the scrolled coordinate space.
    final double visTop = scrollOffset;
    final double visBottom = scrollOffset + size.height;

    // Horizontal midpoint: left side = metric, right side = imperial.
    final double midX = size.width / 2;

    // Clip everything to the canvas bounds.
    canvas.save();
    canvas.clipRect(Offset.zero & size);

    _drawDivider(canvas, size, midX);
    _drawMetricScale(canvas, size, midX, visTop, visBottom);
    _drawImperialScale(canvas, size, midX, visTop, visBottom);

    canvas.restore();
  }

  // ── Divider ─────────────────────────────────────────────────────────────────

  void _drawDivider(Canvas canvas, Size size, double midX) {
    final paint = Paint()
      ..color = tickColor.withValues(alpha: 0.4)
      ..strokeWidth = 0.5;
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), paint);
  }

  // ── Metric scale (left half) ────────────────────────────────────────────────

  void _drawMetricScale(
    Canvas canvas,
    Size size,
    double midX,
    double visTop,
    double visBottom,
  ) {
    // Pixels per millimetre.
    final double ppmm = ppi / 25.4;

    // Find the first mm index that is at or just above the visible top.
    final int firstMm = (visTop / ppmm).floor();
    // Add one extra tick below the visible bottom to avoid clipping.
    final int lastMm = (visBottom / ppmm).ceil() + 1;

    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.butt;

    for (int mm = firstMm; mm <= lastMm; mm++) {
      if (mm < 0) continue;

      final double y = mm * ppmm - scrollOffset;
      if (y < 0 || y > size.height) continue;

      final bool isCm = mm % 10 == 0;
      final bool isFiveMm = mm % 5 == 0;

      final double tickWidth =
          isCm ? _longTickWidth : (isFiveMm ? _midTickWidth : _shortTickWidth);

      canvas.drawLine(
        Offset(0, y),
        Offset(tickWidth, y),
        tickPaint,
      );

      // Centimetre label.
      if (isCm && mm > 0) {
        final int cm = mm ~/ 10;
        _paintLabel(
          canvas: canvas,
          text: '$cm',
          x: _longTickWidth + _labelPadding,
          y: y,
          align: ui.TextAlign.left,
          maxWidth: midX - _longTickWidth - _labelPadding * 2,
        );
      }
    }
  }

  // ── Imperial scale (right half) ─────────────────────────────────────────────

  void _drawImperialScale(
    Canvas canvas,
    Size size,
    double midX,
    double visTop,
    double visBottom,
  ) {
    // Pixels per 1⁄16 inch.
    final double ppSixteenth = ppi / 16.0;

    final int firstUnit = (visTop / ppSixteenth).floor();
    final int lastUnit = (visBottom / ppSixteenth).ceil() + 1;

    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.butt;

    for (int unit = firstUnit; unit <= lastUnit; unit++) {
      if (unit < 0) continue;

      final double y = unit * ppSixteenth - scrollOffset;
      if (y < 0 || y > size.height) continue;

      // unit is a multiple of 16  → full inch
      // unit is a multiple of 4   → quarter inch
      // otherwise                 → sixteenth inch
      final bool isInch = unit % 16 == 0;
      final bool isQuarter = unit % 4 == 0;

      final double tickWidth =
          isInch ? _longTickWidth : (isQuarter ? _midTickWidth : _shortTickWidth);

      // Right-side ticks extend from the right edge leftward.
      canvas.drawLine(
        Offset(size.width, y),
        Offset(size.width - tickWidth, y),
        tickPaint,
      );

      // Inch label.
      if (isInch && unit > 0) {
        final int inch = unit ~/ 16;
        final double labelRight = size.width - _longTickWidth - _labelPadding;
        _paintLabel(
          canvas: canvas,
          text: '$inch',
          // We position from the right; pass the right edge as x and use
          // right-alignment.
          x: labelRight,
          y: y,
          align: ui.TextAlign.right,
          maxWidth: midX - _longTickWidth - _labelPadding * 2,
        );
      }
    }
  }

  // ── Text helper ─────────────────────────────────────────────────────────────

  /// Paints a numeric label centred vertically on [y].
  ///
  /// - [x] is the left edge of the text box when [align] is [TextAlign.left],
  ///   or the right edge of the text box when [align] is [TextAlign.right].
  void _paintLabel({
    required Canvas canvas,
    required String text,
    required double x,
    required double y,
    required ui.TextAlign align,
    required double maxWidth,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: _fontSize,
          fontWeight: FontWeight.w500,
          height: 1.0,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
      textAlign: align,
    )..layout(maxWidth: maxWidth.clamp(0.0, double.infinity));

    final double dx =
        align == ui.TextAlign.right ? x - tp.width : x;
    final double dy = y - tp.height / 2;

    tp.paint(canvas, Offset(dx, dy));
  }

  // ── Repaint guard ────────────────────────────────────────────────────────────

  @override
  bool shouldRepaint(covariant RulerPainter oldDelegate) {
    return oldDelegate.ppi != ppi ||
        oldDelegate.scrollOffset != scrollOffset ||
        oldDelegate.tickColor != tickColor ||
        oldDelegate.textColor != textColor;
  }
}
