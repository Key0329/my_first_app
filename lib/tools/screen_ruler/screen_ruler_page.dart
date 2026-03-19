import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'ruler_painter.dart';

/// 螢幕尺規工具頁面
///
/// 透過校準（以信用卡標準尺寸推算 PPI）後，
/// 在螢幕上顯示可捲動的實體尺規。
class ScreenRulerPage extends StatefulWidget {
  const ScreenRulerPage({super.key});

  @override
  State<ScreenRulerPage> createState() => _ScreenRulerPageState();
}

class _ScreenRulerPageState extends State<ScreenRulerPage> {
  // ── 常數 ─────────────────────────────────────────────────────────────────
  static const String _prefKey = 'screen_ruler_ppi';

  /// 標準信用卡實體寬度（mm）
  static const double _cardWidthMm = 85.6;

  /// 標準信用卡實體高度（mm）
  static const double _cardHeightMm = 53.98;

  /// 信用卡高寬比例
  static const double _cardAspectRatio = _cardHeightMm / _cardWidthMm;

  static const Color _toolColor = Color(0xFF5C6BC0);
  static const String _heroTag = 'tool_hero_screen_ruler';

  // ── 狀態 ─────────────────────────────────────────────────────────────────

  /// 已校準的 PPI；null 表示尚未校準
  double? _calibratedPpi;

  /// 是否正在校準模式（已有 PPI 但使用者選擇重新校準）
  bool _isCalibrating = false;

  /// 尺規的垂直滾動偏移量（像素）
  double _scrollOffset = 0.0;

  /// 校準 Slider 的像素寬度值（代表信用卡在螢幕上的寬度）
  double _cardPixelWidth = 250.0;

  // ── 生命週期 ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadPpi();
  }

  /// 從 SharedPreferences 讀取已儲存的 PPI 值
  Future<void> _loadPpi() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getDouble(_prefKey);
    if (!mounted) return;
    if (stored != null) {
      setState(() {
        _calibratedPpi = stored;
      });
    }
  }

  /// 完成校準：根據信用卡像素寬度計算 PPI 並持久化
  Future<void> _finishCalibration() async {
    // ppi = (cardPixelWidth / cardWidthMm) * 25.4
    final ppi = (_cardPixelWidth / _cardWidthMm) * 25.4;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefKey, ppi);

    if (!mounted) return;
    setState(() {
      _calibratedPpi = ppi;
      _isCalibrating = false;
      _scrollOffset = 0.0;
    });
  }

  /// 進入重新校準模式
  void _startRecalibration() {
    setState(() {
      _isCalibrating = true;
    });
  }

  /// 垂直拖動時更新尺規偏移量
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _scrollOffset -= details.delta.dy;
    });
  }

  // ── 判斷目前應顯示哪個模式 ────────────────────────────────────────────────

  bool get _showCalibration =>
      _calibratedPpi == null || _isCalibrating;

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_showCalibration) {
      return _buildCalibrationScreen(context);
    }
    return _buildRulerScreen(context);
  }

  // ── 校準模式 ──────────────────────────────────────────────────────────────

  Widget _buildCalibrationScreen(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cardHeight = _cardPixelWidth * _cardAspectRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('螢幕尺規'),
        backgroundColor: _toolColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── 說明圖示 ───────────────────────────────────────────────
                Icon(
                  Icons.credit_card,
                  size: 56,
                  color: _toolColor,
                ),
                const SizedBox(height: 16),

                // ── 說明文字 ───────────────────────────────────────────────
                Text(
                  '校準螢幕 PPI',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '請將信用卡放在螢幕上，調整大小使其吻合',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),

                // ── 信用卡輪廓預覽 ─────────────────────────────────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  width: _cardPixelWidth,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _toolColor,
                      width: 2.5,
                    ),
                    color: _toolColor.withValues(alpha: 0.06),
                  ),
                  child: Center(
                    child: Text(
                      '信用卡',
                      style: TextStyle(
                        color: _toolColor.withValues(alpha: 0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // ── 尺寸標示 ───────────────────────────────────────────────
                Text(
                  '${_cardPixelWidth.toStringAsFixed(0)} px  ×  ${cardHeight.toStringAsFixed(0)} px',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),

                // ── Slider ─────────────────────────────────────────────────
                Slider(
                  value: _cardPixelWidth,
                  min: 150,
                  max: 400,
                  divisions: 250,
                  activeColor: _toolColor,
                  label: '${_cardPixelWidth.toStringAsFixed(0)} px',
                  onChanged: (value) {
                    setState(() {
                      _cardPixelWidth = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // ── 完成校準按鈕 ───────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _finishCalibration,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('完成校準'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _toolColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── 尺規模式 ──────────────────────────────────────────────────────────────

  Widget _buildRulerScreen(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    // 依照亮暗模式選擇刻度與文字顏色
    final tickColor = brightness == Brightness.dark
        ? Colors.white
        : const Color(0xFF37474F); // blue-grey 800
    final textColor = brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xFF546E7A); // blue-grey 600

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '螢幕尺規',
      heroTag: _heroTag,
      headerFlex: 1,
      bodyFlex: 4,
      headerChild: _buildRulerHeader(context),
      bodyChild: _buildRulerBody(
        context,
        tickColor: tickColor,
        textColor: textColor,
      ),
    );
  }

  /// Header 區：顯示 PPI 與重新校準按鈕
  Widget _buildRulerHeader(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // PPI 數值
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PPI',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white70,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                _calibratedPpi!.toStringAsFixed(1),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),

          // 重新校準按鈕
          TextButton.icon(
            onPressed: _startRecalibration,
            icon: const Icon(Icons.tune, size: 16, color: Colors.white70),
            label: const Text(
              '重新校準',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  /// Body 區：可拖動的尺規 CustomPaint
  Widget _buildRulerBody(
    BuildContext context, {
    required Color tickColor,
    required Color textColor,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: RulerPainter(
              ppi: _calibratedPpi!,
              scrollOffset: _scrollOffset,
              tickColor: tickColor,
              textColor: textColor,
            ),
          );
        },
      ),
    );
  }
}
