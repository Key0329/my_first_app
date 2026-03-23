import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/utils/platform_check.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/error_state.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

final Color _toolColor =
    toolGradients['noise_meter']?.first ?? const Color(0xFFE91E63);

/// 噪音計工具頁面
///
/// 使用裝置麥克風即時測量環境噪音分貝值，提供即時折線圖與
/// 常見噪音等級參考對照。
class NoiseMeterPage extends StatefulWidget {
  const NoiseMeterPage({super.key});

  @override
  State<NoiseMeterPage> createState() => _NoiseMeterPageState();
}

class _NoiseMeterPageState extends State<NoiseMeterPage> {
  final NoiseMeter _noiseMeter = NoiseMeter();
  StreamSubscription<NoiseReading>? _noiseSubscription;

  bool _isRecording = false;
  bool _permissionDenied = false;
  double _currentDb = 0;
  double _maxDb = 0;
  double _minDb = double.infinity;

  /// 最近 100 筆分貝資料點
  final List<double> _dbHistory = [];
  static const int _maxDataPoints = 100;

  /// 常見噪音等級參考
  static const List<_NoiseReference> _references = [
    _NoiseReference(
      emoji: '\u{1F92B}', // 🤫
      label: '耳語',
      db: 30,
      color: Color(0xFF4CAF50),
    ),
    _NoiseReference(
      emoji: '\u{1F4AC}', // 💬
      label: '對話',
      db: 60,
      color: Color(0xFFFFC107),
    ),
    _NoiseReference(
      emoji: '\u{1F697}', // 🚗
      label: '交通',
      db: 80,
      color: Color(0xFFFF9800),
    ),
    _NoiseReference(
      emoji: '\u{1F3B8}', // 🎸
      label: '演唱會',
      db: 110,
      color: Color(0xFFF44336),
    ),
  ];

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  /// 開始錄音並監聽噪音資料
  Future<void> _startRecording() async {
    try {
      _noiseSubscription = _noiseMeter.noise.listen(_onData, onError: _onError);
      setState(() {
        _isRecording = true;
        _permissionDenied = false;
        _maxDb = 0;
        _minDb = double.infinity;
      });
    } catch (e) {
      setState(() {
        _permissionDenied = true;
      });
    }
  }

  /// 停止錄音
  void _stopRecording() {
    _noiseSubscription?.cancel();
    _noiseSubscription = null;
    setState(() {
      _isRecording = false;
    });
  }

  /// 處理噪音資料
  void _onData(NoiseReading reading) {
    if (!mounted) return;
    setState(() {
      _currentDb = reading.meanDecibel;
      if (_currentDb > _maxDb) _maxDb = _currentDb;
      if (_currentDb < _minDb) _minDb = _currentDb;

      _dbHistory.add(_currentDb);
      if (_dbHistory.length > _maxDataPoints) {
        _dbHistory.removeAt(0);
      }
    });
  }

  /// 處理錯誤（含權限被拒）
  void _onError(Object error) {
    _stopRecording();
    if (!mounted) return;
    setState(() {
      _permissionDenied = true;
    });
  }

  /// 切換錄音狀態
  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  /// 取得目前分貝值對應的顏色
  Color _getDbColor(double db) {
    if (db < 45) return const Color(0xFF4CAF50);
    if (db < 70) return const Color(0xFFFFC107);
    if (db < 90) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  /// 取得目前分貝值所落在的參考等級索引（-1 表示低於最低參考值）
  int _getActiveReferenceIndex(double db) {
    if (db >= 110) return 3;
    if (db >= 80) return 2;
    if (db >= 60) return 1;
    if (db >= 30) return 0;
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    if (!isMobilePlatform()) {
      return const PlatformUnsupportedView(toolName: '噪音計');
    }

    if (_permissionDenied) {
      return Scaffold(
        appBar: AppBar(title: const Text('噪音計')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(DT.toolBodyPadding),
            child: ErrorState(
              message: '需要麥克風權限。\n請在系統設定中允許此 App 使用麥克風。',
              onRetry: () {
                setState(() => _permissionDenied = false);
                _startRecording();
              },
            ),
          ),
        ),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    final dbColor = _getDbColor(_currentDb);

    return ImmersiveToolScaffold(
      toolId: 'noise_meter',
      toolColor: _toolColor,
      title: '噪音計',
      heroTag: 'tool_hero_noise_meter',
      headerFlex: 2,
      bodyFlex: 2,
      // 目前分貝值顯示（量表區）
      headerChild: SafeArea(
        top: true,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                label: '目前噪音等級',
                value: _isRecording
                    ? '${_currentDb.toStringAsFixed(1)} dB'
                    : '未測量',
                liveRegion: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isRecording ? _currentDb.toStringAsFixed(1) : '--',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: _isRecording ? dbColor : colorScheme.outline,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.noiseMeterDb,
                      style: TextStyle(
                        fontSize: 24,
                        color: _isRecording ? dbColor : colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isRecording && _minDb != double.infinity) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatChip(
                      '最小',
                      '${_minDb.toStringAsFixed(1)} dB',
                      colorScheme,
                    ),
                    const SizedBox(width: 16),
                    _buildStatChip(
                      '最大',
                      '${_maxDb.toStringAsFixed(1)} dB',
                      colorScheme,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      // 即時折線圖 + 噪音等級參考 + 開始/停止按鈕
      bodyChild: Padding(
        padding: const EdgeInsets.all(DT.toolBodyPadding),
        child: Column(
          children: [
            // 即時折線圖
            Expanded(
              flex: 2,
              child: StaggeredFadeIn(
                index: 0,
                totalItems: 3,
                child: _buildChartSection(colorScheme, dbColor),
              ),
            ),

            const SizedBox(height: DT.toolSectionGap),

            // 噪音等級參考
            StaggeredFadeIn(
              index: 1,
              totalItems: 3,
              child: ToolSectionCard(
                label: AppLocalizations.of(context)!.noiseMeterReference,
                child: _buildReferenceSection(),
              ),
            ),

            const SizedBox(height: DT.toolSectionGap),

            // 開始 / 停止按鈕
            StaggeredFadeIn(
              index: 2,
              totalItems: 3,
              child: BouncingButton(
                onTap: _toggleRecording,
                child: FilledButton.icon(
                  onPressed: _toggleRecording,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  label: Text(_isRecording ? '停止測量' : '開始測量'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _isRecording
                        ? colorScheme.error
                        : colorScheme.primary,
                    foregroundColor: _isRecording
                        ? colorScheme.onError
                        : colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: DT.toolBodyPadding,
                    ),
                    textStyle: const TextStyle(fontSize: DT.fontToolButton),
                  ),
                ),
              ),
            ),

            const SizedBox(height: DT.toolSectionGap),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 即時波形卡片（需要特殊處理以填滿 Expanded 空間）
  // ---------------------------------------------------------------------------

  Widget _buildChartSection(ColorScheme colorScheme, Color dbColor) {
    final brightness = Theme.of(context).brightness;
    final bgColor = brightness == Brightness.dark
        ? DT.brandPrimaryBgDark
        : DT.brandPrimaryBgLight;
    final labelColor = brightness == Brightness.dark
        ? DT.brandPrimarySoft
        : DT.brandPrimary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DT.toolSectionRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DT.toolSectionPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '即時波形',
              style: TextStyle(
                fontSize: DT.fontToolLabel,
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: DT.spaceSm),
            Expanded(
              child: _dbHistory.isEmpty
                  ? Center(
                      child: Text(
                        _isRecording ? '收集資料中...' : '按下開始測量噪音',
                        style: TextStyle(
                          color: colorScheme.outline,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : CustomPaint(
                      size: Size.infinite,
                      painter: _NoiseChartPainter(
                        data: _dbHistory,
                        lineColor: dbColor,
                        gridColor: colorScheme.outlineVariant,
                        textColor: colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceSection() {
    final l10n = AppLocalizations.of(context)!;
    final activeIndex = _isRecording
        ? _getActiveReferenceIndex(_currentDb)
        : -2; // -2 表示未錄音，不高亮任何項目

    final localizedLabels = [
      l10n.noiseMeterWhisper,
      l10n.noiseMeterConversation,
      l10n.noiseMeterTraffic,
      l10n.noiseMeterConcert,
    ];

    return Row(
      children: List.generate(_references.length, (index) {
        final ref = _references[index];
        final isActive = index == activeIndex;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 4,
              right: index == _references.length - 1 ? 0 : 4,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? ref.color.withValues(alpha: 0.2)
                  : Theme.of(context).colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: isActive ? Border.all(color: ref.color, width: 2) : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ref.emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 2),
                Text(
                  localizedLabels[index],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? ref.color
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '~${ref.db} dB',
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive
                        ? ref.color
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// -----------------------------------------------------------------------------
// 噪音等級參考資料模型
// -----------------------------------------------------------------------------

class _NoiseReference {
  final String emoji;
  final String label;
  final int db;
  final Color color;

  const _NoiseReference({
    required this.emoji,
    required this.label,
    required this.db,
    required this.color,
  });
}

// -----------------------------------------------------------------------------
// 即時折線圖繪製器
// -----------------------------------------------------------------------------

class _NoiseChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final Color gridColor;
  final Color textColor;

  _NoiseChartPainter({
    required this.data,
    required this.lineColor,
    required this.gridColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    const double paddingLeft = 36;
    const double paddingBottom = 4;
    const double paddingTop = 8;

    final chartWidth = size.width - paddingLeft;
    final chartHeight = size.height - paddingBottom - paddingTop;

    // 固定 Y 軸範圍 0 ~ 130 dB
    const double minDb = 0;
    const double maxDb = 130;
    const double dbRange = maxDb - minDb;

    // 繪製水平格線與標籤
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    final textStyle = TextStyle(color: textColor, fontSize: 10);

    for (final dbMark in [0, 30, 60, 90, 120]) {
      final y = paddingTop + chartHeight * (1 - (dbMark - minDb) / dbRange);

      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width, y), gridPaint);

      final textSpan = TextSpan(text: '$dbMark', style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(paddingLeft - textPainter.width - 4, y - textPainter.height / 2),
      );
    }

    // 繪製折線
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lineColor.withValues(alpha: 0.3),
              lineColor.withValues(alpha: 0.0),
            ],
          ).createShader(
            Rect.fromLTWH(paddingLeft, paddingTop, chartWidth, chartHeight),
          );

    final path = Path();
    final fillPath = Path();

    final pointSpacing = data.length > 1
        ? chartWidth / (data.length - 1)
        : chartWidth;

    for (var i = 0; i < data.length; i++) {
      final x = paddingLeft + i * pointSpacing;
      final normalizedDb = (data[i].clamp(minDb, maxDb) - minDb) / dbRange;
      final y = paddingTop + chartHeight * (1 - normalizedDb);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, paddingTop + chartHeight);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // 完成填充路徑
    final lastX = paddingLeft + (data.length - 1) * pointSpacing;
    fillPath.lineTo(lastX, paddingTop + chartHeight);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // 繪製最新資料點
    if (data.isNotEmpty) {
      final lastDb = data.last.clamp(minDb, maxDb);
      final lastNormalized = (lastDb - minDb) / dbRange;
      final lastY = paddingTop + chartHeight * (1 - lastNormalized);

      final dotPaint = Paint()
        ..color = lineColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(lastX, lastY), 4, dotPaint);

      final dotBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(lastX, lastY), 4, dotBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NoiseChartPainter oldDelegate) {
    return data.length != oldDelegate.data.length ||
        (data.isNotEmpty &&
            oldDelegate.data.isNotEmpty &&
            data.last != oldDelegate.data.last) ||
        lineColor != oldDelegate.lineColor;
  }
}
