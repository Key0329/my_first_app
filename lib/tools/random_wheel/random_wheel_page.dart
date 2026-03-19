import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';

import 'wheel_painter.dart';

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
  final List<String> _options = ['選項 1', '選項 2'];

  // ── 動畫 ──────────────────────────────────────────────────────
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentRotation = 0.0;
  double _targetRotation = 0.0;
  bool _isSpinning = false;

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
  void dispose() {
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
      _showResultDialog();
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
    if (!_isSpinning && _animationController.status != AnimationStatus.completed) {
      return _currentRotation;
    }
    return _currentRotation + (_targetRotation - _currentRotation) * _animation.value;
  }

  /// 根據最終旋轉角度計算選中的選項 index
  int _calculateResultIndex() {
    final finalAngle = _targetRotation % (2 * pi);
    final segmentAngle = 2 * pi / _options.length;
    // 指針在頂部（12 點方向）
    final index = ((2 * pi - finalAngle) / segmentAngle).floor() % _options.length;
    return index;
  }

  void _showResultDialog() {
    final index = _calculateResultIndex();
    final result = _options[index];

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('結果'),
          content: Text(
            result,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
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

  // ── 建構 UI ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '隨機轉盤',
      heroTag: _heroTag,
      headerFlex: 3,
      bodyFlex: 2,
      headerChild: _buildHeader(),
      bodyChild: _buildBody(),
    );
  }

  Widget _buildHeader() {
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
          padding: const EdgeInsets.only(bottom: 24),
          child: ElevatedButton(
            onPressed: _isSpinning ? null : _spin,
            style: ElevatedButton.styleFrom(
              backgroundColor: _toolColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: _toolColor.withValues(alpha: 0.5),
              disabledForegroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 4,
            ),
            child: const Text(
              '旋轉！',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    final colors = _wheelColors;
    final canDelete = _options.length > _minOptions;
    final canAdd = _options.length < _maxOptions;
    final hasText = _textController.text.trim().isNotEmpty;

    return Column(
      children: [
        // ── 選項清單 ─────────────────────────────────────────
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8),
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

        // ── 分隔線 ───────────────────────────────────────────
        const Divider(height: 1),

        // ── 新增選項輸入列 ────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _textFocusNode,
                  enabled: canAdd,
                  decoration: InputDecoration(
                    hintText: canAdd ? '新增選項…' : '已達上限（$_maxOptions 個）',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    isDense: true,
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => (canAdd && hasText) ? _addOption() : null,
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: (canAdd && hasText) ? _addOption : null,
                icon: const Icon(Icons.add),
                tooltip: '新增選項',
                color: _toolColor,
              ),
            ],
          ),
        ),

        // 底部安全區間距
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  Widget _buildOptionItem({
    required int index,
    required Color color,
    required bool canDelete,
  }) {
    final option = _options[index];

    return Dismissible(
      key: ValueKey('option_${option}_$index'),
      direction: canDelete ? DismissDirection.endToStart : DismissDirection.none,
      onDismissed: (_) => _removeOption(index),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red.shade100,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(Icons.delete_outline, color: Colors.red.shade700),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          option,
          style: const TextStyle(fontSize: 15),
        ),
        trailing: canDelete
            ? IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => _removeOption(index),
                tooltip: '刪除選項',
                splashRadius: 20,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }
}
