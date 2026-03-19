import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Compass tool page.
///
/// Uses the device magnetometer via `sensors_plus` to calculate heading and
/// renders a rotating compass dial with N/S/E/W markers, degree ticks, and a
/// red north indicator. Falls back to an informational message on devices or
/// simulators that lack a magnetometer.
class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage>
    with SingleTickerProviderStateMixin {
  StreamSubscription<MagnetometerEvent>? _subscription;

  /// Current raw heading in degrees (0-360), null until first reading.
  double? _heading;

  /// The heading we are animating towards for smooth rotation.
  double _displayHeading = 0;

  /// Whether the sensor is unavailable on this device.
  bool _unsupported = false;

  late final AnimationController _animController;

  /// Tween used for smooth rotation between heading values.
  late Tween<double> _headingTween;
  late Animation<double> _headingAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _headingTween = Tween<double>(begin: 0, end: 0);
    _headingAnimation =
        _headingTween.animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));
    _headingAnimation.addListener(() {
      setState(() {
        _displayHeading = _headingAnimation.value;
      });
    });
    _startListening();
  }

  void _startListening() {
    try {
      _subscription = magnetometerEventStream(
        samplingPeriod: const Duration(milliseconds: 60),
      ).listen(
        _onMagnetometerEvent,
        onError: (_) {
          if (mounted) {
            setState(() => _unsupported = true);
          }
        },
        cancelOnError: true,
      );

      // If we receive no data within 3 seconds, assume unsupported.
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _heading == null && !_unsupported) {
          setState(() => _unsupported = true);
        }
      });
    } catch (_) {
      _unsupported = true;
    }
  }

  void _onMagnetometerEvent(MagnetometerEvent event) {
    if (!mounted) return;

    // Calculate heading from magnetometer x/y.
    // atan2 returns radians; convert to degrees.
    double heading =
        math.atan2(event.y, event.x) * (180 / math.pi);
    // Normalise to 0-360.
    heading = (heading + 360) % 360;

    final oldHeading = _headingTween.end ?? 0;
    double delta = heading - oldHeading;
    // Take shortest rotation path.
    if (delta > 180) delta -= 360;
    if (delta < -180) delta += 360;

    _headingTween
      ..begin = oldHeading
      ..end = oldHeading + delta;

    _animController
      ..reset()
      ..forward();

    _heading = heading;
  }

  String _cardinalDirection(double heading) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((heading + 22.5) % 360 / 45).floor();
    return directions[index];
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_unsupported) {
      return ImmersiveToolScaffold(
        toolColor: const Color(0xFFFF5722),
        title: '指南針',
        heroTag: 'tool_hero_compass',
        headerFlex: 3,
        bodyFlex: 1,
        headerChild: SafeArea(
          child: _buildUnsupportedHeader(theme),
        ),
        bodyChild: const SizedBox.shrink(),
      );
    }

    final heading = _heading ?? 0;
    final cardinal = _cardinalDirection(heading);
    final degrees = heading.toStringAsFixed(0);

    return ImmersiveToolScaffold(
      toolColor: const Color(0xFFFF5722),
      title: '指南針',
      heroTag: 'tool_hero_compass',
      headerFlex: 3,
      bodyFlex: 1,
      headerChild: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading readout
            Text(
              '$degrees\u00B0',
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              cardinal,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            // Compass dial
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: _heading == null
                        ? const Center(child: CircularProgressIndicator())
                        : CustomPaint(
                            painter: _CompassPainter(
                              heading: _displayHeading,
                              color: theme.colorScheme.onSurface,
                              primaryColor: theme.colorScheme.primary,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bodyChild: const SizedBox.shrink(),
    );
  }

  Widget _buildUnsupportedHeader(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.explore_off, size: 80, color: theme.colorScheme.outline),
            const SizedBox(height: 24),
            Text(
              '此裝置不支援磁力計',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '指南針需要磁力計感測器才能運作。\n'
              '模擬器及部分桌面裝置不支援此功能。',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter that draws the compass face.
///
/// The dial rotates so that north always points towards the actual magnetic
/// north direction relative to the device.
class _CompassPainter extends CustomPainter {
  final double heading;
  final Color color;
  final Color primaryColor;

  _CompassPainter({
    required this.heading,
    required this.color,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Rotate the entire canvas so the dial turns with the heading.
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-heading * (math.pi / 180));

    // --- Outer circle ---
    final circlePaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset.zero, radius - 4, circlePaint);

    // --- Degree tick marks ---
    final tickPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    final majorTickPaint = Paint()
      ..color = color
      ..strokeWidth = 2;

    for (int deg = 0; deg < 360; deg += 5) {
      final isMajor = deg % 30 == 0;
      final tickLen = isMajor ? 14.0 : 7.0;
      final rad = deg * (math.pi / 180);
      final outerR = radius - 6;
      final innerR = outerR - tickLen;
      final outer = Offset(
        outerR * math.cos(rad - math.pi / 2),
        outerR * math.sin(rad - math.pi / 2),
      );
      final inner = Offset(
        innerR * math.cos(rad - math.pi / 2),
        innerR * math.sin(rad - math.pi / 2),
      );
      canvas.drawLine(inner, outer, isMajor ? majorTickPaint : tickPaint);
    }

    // --- Cardinal labels (N, E, S, W) ---
    const cardinals = {0: 'N', 90: 'E', 180: 'S', 270: 'W'};
    for (final entry in cardinals.entries) {
      final deg = entry.key;
      final label = entry.value;
      final rad = deg * (math.pi / 180);
      final labelR = radius - 36;
      final pos = Offset(
        labelR * math.cos(rad - math.pi / 2),
        labelR * math.sin(rad - math.pi / 2),
      );

      final isNorth = label == 'N';
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: isNorth ? Colors.red : color,
            fontSize: isNorth ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Centre the label on position.
      textPainter.paint(
        canvas,
        Offset(
          pos.dx - textPainter.width / 2,
          pos.dy - textPainter.height / 2,
        ),
      );
    }

    // --- Red north indicator triangle (at top of dial) ---
    final northPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final northTip = Offset(0, -(radius - 2));
    final northLeft = Offset(-8, -(radius - 18));
    final northRight = Offset(8, -(radius - 18));
    final northPath = Path()
      ..moveTo(northTip.dx, northTip.dy)
      ..lineTo(northLeft.dx, northLeft.dy)
      ..lineTo(northRight.dx, northRight.dy)
      ..close();
    canvas.drawPath(northPath, northPaint);

    canvas.restore();

    // --- Centre dot (does not rotate) ---
    final dotPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5, dotPaint);
  }

  @override
  bool shouldRepaint(_CompassPainter oldDelegate) {
    return oldDelegate.heading != heading ||
        oldDelegate.color != color ||
        oldDelegate.primaryColor != primaryColor;
  }
}
