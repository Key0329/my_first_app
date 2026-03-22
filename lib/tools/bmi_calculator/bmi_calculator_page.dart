import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/share_card_generator.dart';
import 'package:my_first_app/widgets/share_card_template.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:share_plus/share_plus.dart';
import 'bmi_logic.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Page
// ─────────────────────────────────────────────────────────────────────────────

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({super.key});

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  static const Color _toolColor = Color(0xFFE91E63);

  final GlobalKey _shareCardKey = GlobalKey();
  double _heightCm = 170;
  double _weightKg = 65;
  bool _hasTrackedComplete = false;

  BmiResult get _result => BmiLogic.calculate(_heightCm, _weightKg);

  void _trackCompleteOnce() {
    if (!_hasTrackedComplete) {
      _hasTrackedComplete = true;
      AnalyticsService.instance.logToolComplete(
        toolId: 'bmi_calculator',
        resultType: 'bmi_calculated',
      );
    }
  }

  String _categoryLabel(BmiCategory category) {
    switch (category) {
      case BmiCategory.underweight:
        return '體重過輕';
      case BmiCategory.normal:
        return '正常體重';
      case BmiCategory.overweight:
        return '體重過重';
      case BmiCategory.obese:
        return '肥胖';
    }
  }

  Future<void> _shareAsCard() async {
    AnalyticsService.instance.logToolShare(
      toolId: 'bmi_calculator',
      shareMethod: 'share_card',
    );

    final xFile = await ShareCardGenerator.capture(_shareCardKey);
    if (xFile != null) {
      await Share.shareXFiles([xFile], text: '用 Spectra 工具箱計算 BMI');
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    final (minWeight, maxWeight) = BmiLogic.healthyWeightRange(_heightCm);

    return Stack(
      children: [
        ImmersiveToolScaffold(
          toolId: 'bmi_calculator',
          toolColor: _toolColor,
          title: 'BMI 計算機',
          heroTag: 'tool_hero_bmi_calculator',
          headerFlex: 2,
          bodyFlex: 3,
          actions: [
            Opacity(
              opacity: 1.0,
              child: IconButton(
                onPressed: _shareAsCard,
                icon: const Icon(Icons.share),
                tooltip: '分享',
              ),
            ),
          ],
          headerChild: _BmiGauge(result: result),
          bodyChild: _BmiControls(
            toolColor: _toolColor,
            heightCm: _heightCm,
            weightKg: _weightKg,
            result: result,
            minWeight: minWeight,
            maxWeight: maxWeight,
            onHeightChanged: (v) {
              setState(() => _heightCm = v);
              _trackCompleteOnce();
            },
            onWeightChanged: (v) {
              setState(() => _weightKg = v);
              _trackCompleteOnce();
            },
          ),
        ),
        // 隱藏的分享卡片（用於截圖）
        Offstage(
          child: RepaintBoundary(
            key: _shareCardKey,
            child: ShareCardTemplate(
              toolName: 'BMI 計算機',
              gradientColors: toolGradients['bmi_calculator']!,
              resultChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    result.bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: result.category.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _categoryLabel(result.category),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: result.category.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '身高 ${_heightCm.round()} cm / 體重 ${_weightKg.round()} kg',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header：圓弧儀表盤
// ─────────────────────────────────────────────────────────────────────────────

class _BmiGauge extends StatelessWidget {
  const _BmiGauge({required this.result});

  final BmiResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final onSurface = colorScheme.onSurface;

    return Center(
      child: SizedBox(
        width: 220,
        height: 180,
        child: CustomPaint(
          painter: _GaugePainter(bmi: result.bmi),
          child: Align(
            alignment: const Alignment(0, 0.15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedValueText(
                  value: result.bmi.toStringAsFixed(1),
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: result.category.color,
                  ),
                ),
                Text(
                  _categoryLabel(result.category),
                  style: textTheme.bodyMedium?.copyWith(color: onSurface),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _categoryLabel(BmiCategory category) {
    switch (category) {
      case BmiCategory.underweight:
        return '體重過輕';
      case BmiCategory.normal:
        return '正常體重';
      case BmiCategory.overweight:
        return '體重過重';
      case BmiCategory.obese:
        return '肥胖';
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CustomPainter：彩色弧帶 + 指針
// ─────────────────────────────────────────────────────────────────────────────

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.bmi});

  final double bmi;

  // 儀表盤弧形角度設定（度）
  static const double _startDeg = 150;
  static const double _sweepDeg = 240;
  static const double _strokeWidth = 14;

  // 四個 BMI 區段顏色（underweight / normal / overweight / obese）
  static const List<Color> _segmentColors = [
    Color(0xFF2196F3), // 藍：< 18.5
    Color(0xFF4CAF50), // 綠：18.5 – 24.9
    Color(0xFFFF9800), // 橙：25 – 29.9
    Color(0xFFF44336), // 紅：≥ 30
  ];

  // 各 BMI 區段於弧形中所佔的角度比例
  // 弧形對應 BMI 範圍：10 – 40（30 個單位）
  static const double _bmiMin = 10;
  static const double _bmiMax = 40;

  // 分界點（BMI 值）
  static const List<double> _boundaries = [18.5, 25, 30];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.62);
    final radius = size.width * 0.42;

    _drawSegments(canvas, center, radius);
    _drawNeedle(canvas, center, radius);
  }

  void _drawSegments(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.butt;

    // 四個區段的 BMI 邊界（頭尾加上 _bmiMin / _bmiMax）
    final breakpoints = [_bmiMin, ..._boundaries, _bmiMax];

    for (int i = 0; i < _segmentColors.length; i++) {
      final segStart = breakpoints[i];
      final segEnd = breakpoints[i + 1];

      final startAngle = _bmiToAngle(segStart);
      final sweepAngle = _bmiToAngle(segEnd) - startAngle;

      paint.color = _segmentColors[i].withValues(alpha: 0.85);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        _degToRad(startAngle),
        _degToRad(sweepAngle),
        false,
        paint,
      );
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    final clampedBmi = bmi.clamp(_bmiMin, _bmiMax);
    final angleDeg = _bmiToAngle(clampedBmi);
    final angleRad = _degToRad(angleDeg);

    // 指針長度：略短於弧形半徑
    final needleLength = radius - _strokeWidth * 0.5;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(angleRad),
      center.dy + needleLength * math.sin(angleRad),
    );

    // 指針底部圓點
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 6, dotPaint);

    final dotBorderPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, 6, dotBorderPaint);

    // 指針線條
    final needlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needlePaint);

    // 指針陰影（略粗、黑色，先畫在白色下方）
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, shadowPaint);
    // 重新畫白色指針蓋在陰影上
    canvas.drawLine(center, needleEnd, needlePaint);
  }

  /// 將 BMI 值映射為儀表盤角度（度）
  double _bmiToAngle(double bmiValue) {
    final t = (bmiValue - _bmiMin) / (_bmiMax - _bmiMin);
    return _startDeg + t * _sweepDeg;
  }

  double _degToRad(double degrees) => degrees * math.pi / 180;

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) => oldDelegate.bmi != bmi;
}

// ─────────────────────────────────────────────────────────────────────────────
// Body：Slider 控制區（Bento 風格）
// ─────────────────────────────────────────────────────────────────────────────

class _BmiControls extends StatelessWidget {
  const _BmiControls({
    required this.toolColor,
    required this.heightCm,
    required this.weightKg,
    required this.result,
    required this.minWeight,
    required this.maxWeight,
    required this.onHeightChanged,
    required this.onWeightChanged,
  });

  final Color toolColor;
  final double heightCm;
  final double weightKg;
  final BmiResult result;
  final double minWeight;
  final double maxWeight;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<double> onWeightChanged;

  static const int _totalSections = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 身高 Slider — ToolSectionCard
          StaggeredFadeIn(
            index: 0,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: '身高',
              child: _SliderRow(
                value: heightCm,
                displayText: '${heightCm.round()} cm',
                min: 140,
                max: 220,
                divisions: 80,
                activeColor: toolColor,
                onChanged: onHeightChanged,
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // 體重 Slider — ToolSectionCard
          StaggeredFadeIn(
            index: 1,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: '體重',
              child: _SliderRow(
                value: weightKg,
                displayText: '${weightKg.round()} kg',
                min: 30,
                max: 200,
                divisions: 170,
                activeColor: toolColor,
                onChanged: onWeightChanged,
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // 結果卡片 — ToolSectionCard
          StaggeredFadeIn(
            index: 2,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: '分析結果',
              child: _ResultContent(
                result: result,
                minWeight: minWeight,
                maxWeight: maxWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Slider 列（數值 + Slider，不含外層標題，標題由 ToolSectionCard label 提供）
// ─────────────────────────────────────────────────────────────────────────────

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.value,
    required this.displayText,
    required this.min,
    required this.max,
    required this.divisions,
    required this.activeColor,
    required this.onChanged,
  });

  final double value;
  final String displayText;
  final double min;
  final double max;
  final int divisions;
  final Color activeColor;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final brandColor = brightness == Brightness.dark
        ? DT.brandPrimarySoft
        : DT.brandPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 數值顯示（品牌色）
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedValueText(
            value: displayText,
            style: TextStyle(
              fontSize: DT.fontToolResult * 0.5,
              fontWeight: FontWeight.bold,
              color: brandColor,
            ),
          ),
        ),
        const SizedBox(height: DT.spaceXs),
        Semantics(
          label: displayText,
          slider: true,
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 結果內容（放在 ToolSectionCard 內）
// ─────────────────────────────────────────────────────────────────────────────

class _ResultContent extends StatelessWidget {
  const _ResultContent({
    required this.result,
    required this.minWeight,
    required this.maxWeight,
  });

  final BmiResult result;
  final double minWeight;
  final double maxWeight;

  String _categoryLabel(BmiCategory category) {
    switch (category) {
      case BmiCategory.underweight:
        return '體重過輕';
      case BmiCategory.normal:
        return '正常體重';
      case BmiCategory.overweight:
        return '體重過重';
      case BmiCategory.obese:
        return '肥胖';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    final categoryColor = result.category.color;
    final brandColor = brightness == Brightness.dark
        ? DT.brandPrimarySoft
        : DT.brandPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // BMI 數值（動畫過渡）
        Center(
          child: AnimatedValueText(
            value: result.bmi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: DT.fontToolResult,
              fontWeight: FontWeight.bold,
              color: categoryColor,
            ),
          ),
        ),
        const SizedBox(height: DT.spaceSm),

        // 分類 Chip
        Row(
          children: [
            Text(
              '分類：',
              style: textTheme.bodyMedium?.copyWith(
                color: brandColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Chip(
              label: Text(
                _categoryLabel(result.category),
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: categoryColor.withValues(alpha: 0.12),
              side: BorderSide(
                color: categoryColor.withValues(alpha: 0.4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: DT.spaceXs),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: DT.spaceSm),

        // 建議體重範圍
        Text(
          '建議體重範圍：${minWeight.toStringAsFixed(1)} – ${maxWeight.toStringAsFixed(1)} kg',
          style: textTheme.bodyMedium?.copyWith(
            color: brandColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
