import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/confirm_dialog.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/share_card_generator.dart';
import 'package:my_first_app/widgets/share_card_template.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:share_plus/share_plus.dart';

import 'wheel_painter.dart';
import 'wheel_result_overlay.dart';

/// 隨機轉盤工具頁面。
///
/// 提供可自訂選項清單的旋轉轉盤，每次旋轉後以 AlertDialog 顯示結果。
///
/// 功能特色：
/// - 最少 2 個、最多 20 個選項
/// - 向左滑動或點擊刪除按鈕移除選項
/// - 底部 TextField 快速新增選項
/// - 動畫持續時間隨機 2–4 秒，圈數 5–10 圈
class RandomWheelPage extends StatefulWidget {
  const RandomWheelPage({super.key});

  @override
  State<RandomWheelPage> createState() => _RandomWheelPageState();
}

class _RandomWheelPageState extends State<RandomWheelPage>
    with SingleTickerProviderStateMixin {
  // ── 品牌色 ────────────────────────────────────────────────────
  static const _toolColor = Color(0xFFFF7043);
  static const _heroTag = 'tool_hero_random_wheel';
  static const _minOptions = 2;
  static const _maxOptions = 20;

  // ── 選項資料 ──────────────────────────────────────────────────
  final List<String> _options = [];
  bool _optionsInitialized = false;
  String? _lastResult;

  // ── 動畫 ──────────────────────────────────────────────────────
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentRotation = 0.0;
  double _targetRotation = 0.0;
  bool _isSpinning = false;

  // ── 分享卡片 ────────────────────────────────────────────────────
  final GlobalKey _shareCardKey = GlobalKey();

  // ── 輸入 ──────────────────────────────────────────────────────
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // 初始化 AnimationController（實際 duration 在每次旋轉時動態設定）
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    );

    _animationController.addListener(_onAnimationTick);
    _animationController.addStatusListener(_onAnimationStatus);
    _textController.addListener(_onTextChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_optionsInitialized) {
      _optionsInitialized = true;
      final l10n = AppLocalizations.of(context)!;
      _options.addAll([
        '${l10n.randomWheelDefaultOption} 1',
        '${l10n.randomWheelDefaultOption} 2',
      ]);
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _animationController.removeListener(_onAnimationTick);
    _animationController.removeStatusListener(_onAnimationStatus);
    _animationController.dispose();
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  // ── 動畫監聽 ─────────────────────────────────────────────────

  void _onAnimationTick() {
    // 根據動畫進度插值當前旋轉角度
    setState(() {});
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _currentRotation = _targetRotation % (2 * pi);
      setState(() {
        _isSpinning = false;
      });
      AnalyticsService.instance.logToolComplete(
        toolId: 'random_wheel',
        resultType: 'wheel_spun',
      );
      _showResultOverlay();
    }
  }

  // ── 旋轉邏輯 ─────────────────────────────────────────────────

  void _spin() {
    if (_isSpinning || _options.length < _minOptions) return;

    // 隨機決定持續時間（2–4 秒）
    final durationSeconds = 2 + _random.nextInt(3); // 2, 3, 4
    _animationController.duration = Duration(seconds: durationSeconds);

    // 隨機決定旋轉圈數（5–10 圈 = 10π–20π rad）+ 隨機偏移角度
    final spins = 5 + _random.nextInt(6); // 5–10
    final extraAngle = _random.nextDouble() * 2 * pi;
    final totalSpin = spins * 2 * pi + extraAngle;

    _targetRotation = _currentRotation + totalSpin;

    setState(() {
      _isSpinning = true;
    });

    _animationController.forward(from: 0.0);
  }

  /// 計算動畫當前幀對應的旋轉角度（絕對值，傳給 WheelPainter）
  double get _currentAnimatedRotation {
    if (!_isSpinning &&
        _animationController.status != AnimationStatus.completed) {
      return _currentRotation;
    }
    return _currentRotation +
        (_targetRotation - _currentRotation) * _animation.value;
  }

  /// 根據最終旋轉角度計算選中的選項 index
  int _calculateResultIndex() {
    final finalAngle = _targetRotation % (2 * pi);
    final segmentAngle = 2 * pi / _options.length;
    // 指針在頂部（12 點方向）
    final index =
        ((2 * pi - finalAngle) / segmentAngle).floor() % _options.length;
    return index;
  }

  OverlayEntry? _overlayEntry;

  void _showResultOverlay() {
    final index = _calculateResultIndex();
    final result = _options[index];
    _lastResult = result;
    final colors = toolGradients['random_wheel'] ?? [_toolColor, _toolColor];

    _overlayEntry = OverlayEntry(
      builder: (context) => WheelResultOverlay(
        result: result,
        gradientColors: colors,
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // ── 選項管理 ─────────────────────────────────────────────────

  void _addOption() {
    final text = _textController.text.trim();
    if (text.isEmpty || _options.length >= _maxOptions) return;

    setState(() {
      _options.add(text);
    });
    _textController.clear();
    _textFocusNode.requestFocus();
  }

  Future<void> _confirmRemoveOption(int index) async {
    if (_options.length <= _minOptions) return;
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.randomWheelDeleteTitle,
      message: l10n.randomWheelDeleteMessage(_options[index]),
      confirmLabel: l10n.commonDelete,
    );
    if (confirmed) {
      setState(() {
        _options.removeAt(index);
      });
    }
  }

  void _removeOption(int index) {
    if (_options.length <= _minOptions) return;
    setState(() {
      _options.removeAt(index);
    });
  }

  void _onTextChanged() {
    // 觸發 setState 以更新新增按鈕的啟用狀態
    setState(() {});
  }

  // ── 顏色指派 ─────────────────────────────────────────────────

  List<Color> get _wheelColors {
    return List.generate(
      _options.length,
      (i) => WheelPainter.defaultColors[i % WheelPainter.defaultColors.length],
    );
  }

  // ── 分享邏輯 ────────────────────────────────────────────────────

  Future<void> _shareAsImage() async {
    if (_lastResult == null) return;

    AnalyticsService.instance.logToolShare(
      toolId: 'random_wheel',
      shareMethod: 'system_share',
    );

    final xFile = await ShareCardGenerator.capture(_shareCardKey);
    if (xFile != null) {
      await Share.shareXFiles(
        [xFile],
        text:
            '🎯 轉盤結果：$_lastResult\n\n用 Spectra 工具箱隨機決定 👉 https://spectra.app/tools/random-wheel',
      );
    }
  }

  // ── 建構 UI ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = toolGradients['random_wheel'] ?? [_toolColor, _toolColor];

    return Stack(
      children: [
        ImmersiveToolScaffold(
          toolId: 'random_wheel',
          toolColor: _toolColor,
          title: l10n.randomWheelTitle,
          heroTag: _heroTag,
          headerFlex: 3,
          bodyFlex: 2,
          actions: [
            Opacity(
              opacity: _lastResult != null ? 1.0 : 0.4,
              child: IconButton(
                onPressed: _lastResult != null ? _shareAsImage : null,
                icon: const Icon(Icons.share),
                tooltip: '分享',
              ),
            ),
          ],
          headerChild: _buildHeader(),
          bodyChild: _buildBody(),
        ),
        // 隱藏的分享卡片（用於截圖）
        Offstage(
          child: RepaintBoundary(
            key: _shareCardKey,
            child: ShareCardTemplate(
              toolName: l10n.randomWheelTitle,
              gradientColors: colors,
              resultChild: Text(
                _lastResult ?? '',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: colors.first,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 轉盤主體
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 8),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: WheelPainter(
                    options: _options,
                    colors: _wheelColors,
                    rotation: _currentAnimatedRotation,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
        ),
        // 旋轉按鈕
        Padding(
          padding: const EdgeInsets.only(bottom: DT.space2xl),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
            child: ToolGradientButton(
              gradientColors: toolGradients['random_wheel']!,
              label: l10n.randomWheelSpin,
              icon: Icons.play_arrow_rounded,
              onPressed: _isSpinning ? null : _spin,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context)!;
    final colors = _wheelColors;
    final canDelete = _options.length > _minOptions;
    final canAdd = _options.length < _maxOptions;
    final hasText = _textController.text.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        children: [
          // ── 選項清單區段 ─────────────────────────────────────
          Expanded(child: _buildOptionListSection(colors, canDelete)),

          const SizedBox(height: DT.toolSectionGap),

          // ── 新增選項控制區段 ─────────────────────────────────
          ToolSectionCard(
            label: l10n.randomWheelAddOption,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _textFocusNode,
                    enabled: canAdd,
                    decoration: InputDecoration(
                      hintText: canAdd
                          ? l10n.randomWheelOptionHint
                          : l10n.randomWheelMaxReached(_maxOptions),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DT.radiusSm),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: DT.toolBodyPadding,
                        vertical: DT.spaceMd,
                      ),
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) =>
                        (canAdd && hasText) ? _addOption() : null,
                  ),
                ),
                const SizedBox(width: DT.spaceSm),
                BouncingButton(
                  onTap: (canAdd && hasText) ? _addOption : null,
                  child: Container(
                    width: DT.iconContainerSize,
                    height: DT.iconContainerSize,
                    decoration: BoxDecoration(
                      color: (canAdd && hasText)
                          ? toolGradients['random_wheel']![0]
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(DT.radiusSm),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: DT.iconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 底部安全區間距
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildOptionListSection(List<Color> colors, bool canDelete) {
    final l10n = AppLocalizations.of(context)!;
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
              l10n.randomWheelOptions,
              style: TextStyle(
                fontSize: DT.fontToolLabel,
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: DT.spaceSm),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DT.radiusSm),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    return _buildOptionItem(
                      index: index,
                      color: colors[index],
                      canDelete: canDelete,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required int index,
    required Color color,
    required bool canDelete,
  }) {
    final option = _options[index];

    final l10n = AppLocalizations.of(context)!;
    return Dismissible(
      key: ValueKey('option_${option}_$index'),
      direction: canDelete
          ? DismissDirection.endToStart
          : DismissDirection.none,
      confirmDismiss: (_) => showConfirmDialog(
        context: context,
        title: l10n.randomWheelDeleteTitle,
        message: l10n.randomWheelDeleteMessage(option),
        confirmLabel: l10n.commonDelete,
      ),
      onDismissed: (_) => _removeOption(index),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red.shade100,
        padding: const EdgeInsets.only(right: DT.toolBodyPadding),
        child: Icon(Icons.delete_outline, color: Colors.red.shade700),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        title: Text(option, style: const TextStyle(fontSize: 15)),
        trailing: canDelete
            ? BouncingButton(
                onTap: () => _confirmRemoveOption(index),
                child: Padding(
                  padding: const EdgeInsets.all(DT.spaceSm),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
