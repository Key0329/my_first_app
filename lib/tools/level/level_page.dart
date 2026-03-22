import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/utils/platform_check.dart';
import 'package:my_first_app/widgets/error_state.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

final Color _toolColor =
    toolGradients['level']?.first ?? const Color(0xFF00BCD4);

/// Bubble Level (水平儀) tool page.
///
/// Uses device accelerometer to detect tilt and displays a bubble level
/// visualization. Provides haptic feedback when the device is level
/// (within +-0.5 degree tolerance).
class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage>
    with SingleTickerProviderStateMixin {
  StreamSubscription<AccelerometerEvent>? _subscription;

  /// Whether the sensor is unavailable on this device.
  bool _sensorError = false;

  /// Raw accelerometer values (m/s^2).
  double _accelX = 0.0;
  double _accelY = 0.0;

  /// Smoothed angle values in degrees.
  double _angleX = 0.0;
  double _angleY = 0.0;

  /// Whether the device is currently level (within tolerance).
  bool _isLevel = false;

  /// Tracks whether we already gave haptic feedback for the current
  /// "level" session to avoid continuous buzzing.
  bool _hapticFired = false;

  /// Tolerance in degrees — device is "level" when both axes are within this.
  static const double _tolerance = 0.5;

  /// Low-pass filter factor for smoothing (0..1, lower = smoother).
  static const double _smoothing = 0.15;

  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _startListening();
  }

  void _startListening() {
    try {
      _subscription = accelerometerEventStream(
        samplingPeriod: const Duration(milliseconds: 50),
      ).listen(
        _onAccelerometerEvent,
        onError: (_) {
          if (mounted) setState(() => _sensorError = true);
        },
      );
    } catch (_) {
      if (mounted) setState(() => _sensorError = true);
    }
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    // Apply low-pass filter for smooth values.
    _accelX = _accelX + _smoothing * (event.x - _accelX);
    _accelY = _accelY + _smoothing * (event.y - _accelY);

    // Convert accelerometer values to tilt angles in degrees.
    // When the device is flat:  x ~= 0, y ~= 0, z ~= 9.81
    // atan2 gives us the angle of tilt for each axis.
    final g = 9.81;
    final newAngleX = -(asin((_accelX / g).clamp(-1.0, 1.0)) * 180 / pi);
    final newAngleY = asin((_accelY / g).clamp(-1.0, 1.0)) * 180 / pi;

    final wasLevel = _isLevel;
    final nowLevel =
        newAngleX.abs() < _tolerance && newAngleY.abs() < _tolerance;

    if (nowLevel && !wasLevel) {
      _hapticFired = false;
    }

    if (nowLevel && !_hapticFired) {
      HapticFeedback.mediumImpact();
      _hapticFired = true;
    }

    if (!nowLevel) {
      _hapticFired = false;
    }

    setState(() {
      _angleX = newAngleX;
      _angleY = newAngleY;
      _isLevel = nowLevel;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isMobilePlatform()) {
      return const PlatformUnsupportedView(toolName: '水平儀');
    }

    if (_sensorError) {
      return Scaffold(
        appBar: AppBar(title: const Text('水平儀')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(DT.toolBodyPadding),
            child: ErrorState(
              message: '無法初始化加速度感測器。\n此裝置可能不支援此功能。',
              onRetry: () {
                setState(() => _sensorError = false);
                _startListening();
              },
            ),
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final isLevel = _isLevel;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '水平儀',
      heroTag: 'tool_hero_level',
      headerFlex: 3,
      bodyFlex: 1,
      // Bubble level visualisation
      headerChild: SafeArea(
        top: true,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final diameter =
                  min(constraints.maxWidth, constraints.maxHeight) * 0.8;
              return SizedBox(
                width: diameter,
                height: diameter,
                child: CustomPaint(
                  painter: _BubbleLevelPainter(
                    angleX: _angleX,
                    angleY: _angleY,
                    isLevel: isLevel,
                    primaryColor: theme.colorScheme.primary,
                    surfaceColor: theme.colorScheme.surfaceContainerHighest,
                    onSurfaceColor: theme.colorScheme.onSurface,
                    levelColor: Colors.green,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // Angle readouts
      bodyChild: _buildBody(theme, isLevel),
    );
  }

  Widget _buildBody(ThemeData theme, bool isLevel) {
    final statusColor = isLevel ? Colors.green : theme.colorScheme.onSurface;
    final statusText = isLevel ? '水平' : '未水平';
    final statusIcon = isLevel ? Icons.check_circle : Icons.info_outline;

    const totalSections = 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Section 1: Status indicator
          StaggeredFadeIn(
            index: 0,
            totalItems: totalSections,
            child: ToolSectionCard(
              label: '狀態',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(statusIcon, color: statusColor, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),
          // Section 2: Angle values
          StaggeredFadeIn(
            index: 1,
            totalItems: totalSections,
            child: ToolSectionCard(
              label: '角度數值',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAngleChip('X 軸', _angleX, theme),
                  _buildAngleChip('Y 軸', _angleY, theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAngleChip(String label, double angle, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${angle.toStringAsFixed(1)}\u00B0',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a circular bubble level with a moving bubble indicator.
class _BubbleLevelPainter extends CustomPainter {
  final double angleX;
  final double angleY;
  final bool isLevel;
  final Color primaryColor;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color levelColor;

  /// Maximum angle (in degrees) that maps to the edge of the container.
  static const double _maxAngle = 15.0;

  _BubbleLevelPainter({
    required this.angleX,
    required this.angleY,
    required this.isLevel,
    required this.primaryColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.levelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final containerRadius = size.width / 2;
    final bubbleRadius = containerRadius * 0.15;

    // -- Draw outer container circle --
    final containerPaint = Paint()
      ..color = surfaceColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, containerRadius, containerPaint);

    final containerBorderPaint = Paint()
      ..color = onSurfaceColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, containerRadius, containerBorderPaint);

    // -- Draw crosshair lines --
    final crosshairPaint = Paint()
      ..color = onSurfaceColor.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(center.dx - containerRadius, center.dy),
      Offset(center.dx + containerRadius, center.dy),
      crosshairPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - containerRadius),
      Offset(center.dx, center.dy + containerRadius),
      crosshairPaint,
    );

    // -- Draw concentric guide circles --
    final guidePaint = Paint()
      ..color = onSurfaceColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(center, containerRadius * i / 4, guidePaint);
    }

    // -- Draw center target circle --
    final targetPaint = Paint()
      ..color = isLevel
          ? levelColor.withValues(alpha: 0.3)
          : onSurfaceColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, bubbleRadius * 1.3, targetPaint);

    final targetBorderPaint = Paint()
      ..color = isLevel
          ? levelColor.withValues(alpha: 0.6)
          : onSurfaceColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, bubbleRadius * 1.3, targetBorderPaint);

    // -- Calculate bubble position --
    // Map angle to offset within the container.
    // Clamp to ensure bubble stays within the circle.
    final maxOffset = containerRadius - bubbleRadius - 4;
    final rawOffsetX = (angleX / _maxAngle) * maxOffset;
    final rawOffsetY = (-angleY / _maxAngle) * maxOffset;

    // Clamp the bubble to stay within the circular container.
    final distance = sqrt(rawOffsetX * rawOffsetX + rawOffsetY * rawOffsetY);
    double bubbleOffsetX = rawOffsetX;
    double bubbleOffsetY = rawOffsetY;
    if (distance > maxOffset) {
      bubbleOffsetX = rawOffsetX * maxOffset / distance;
      bubbleOffsetY = rawOffsetY * maxOffset / distance;
    }

    final bubbleCenter = Offset(
      center.dx + bubbleOffsetX,
      center.dy + bubbleOffsetY,
    );

    // -- Draw bubble --
    final bubbleColor = isLevel ? levelColor : primaryColor;

    // Shadow
    final shadowPaint = Paint()
      ..color = bubbleColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(bubbleCenter, bubbleRadius, shadowPaint);

    // Bubble fill
    final bubblePaint = Paint()
      ..color = bubbleColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(bubbleCenter, bubbleRadius, bubblePaint);

    // Bubble border
    final bubbleBorderPaint = Paint()
      ..color = bubbleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(bubbleCenter, bubbleRadius, bubbleBorderPaint);

    // Highlight (gloss effect)
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(bubbleCenter.dx - bubbleRadius * 0.25,
          bubbleCenter.dy - bubbleRadius * 0.25),
      bubbleRadius * 0.35,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BubbleLevelPainter oldDelegate) =>
      angleX != oldDelegate.angleX ||
      angleY != oldDelegate.angleY ||
      isLevel != oldDelegate.isLevel;
}
