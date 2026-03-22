import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/confirm_dialog.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'calculator_history_service.dart';
import 'calculator_logic.dart';

final Color _toolColor =
    toolGradients['calculator']?.first ?? const Color(0xFF4CAF50);

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';
  List<CalculationEntry> _history = [];
  bool _evaluated = false;
  final CalculatorHistoryService _historyService = CalculatorHistoryService();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final loaded = await _historyService.load();
    if (mounted) setState(() => _history = loaded);
  }

  void _onDigit(String digit) {
    setState(() {
      if (_evaluated) {
        // After pressing '=', start fresh if user types a digit
        _expression = digit;
        _result = '';
        _evaluated = false;
      } else {
        _expression += digit;
      }
    });
  }

  void _onOperator(String op) {
    setState(() {
      if (_evaluated) {
        // Continue from previous result
        _evaluated = false;
      }
      if (_expression.isNotEmpty) {
        _expression += op;
        _result = '';
      } else if (op == '-') {
        // Allow leading negative sign
        _expression = '-';
      }
    });
  }

  void _onDecimal() {
    setState(() {
      if (_evaluated) {
        _expression = '0.';
        _result = '';
        _evaluated = false;
        return;
      }
      // Find the last number segment to check if it already has a dot
      final lastOpIndex = _expression.lastIndexOf(RegExp(r'[+\-*/()]'));
      final lastSegment = lastOpIndex < 0
          ? _expression
          : _expression.substring(lastOpIndex + 1);
      if (!lastSegment.contains('.')) {
        if (lastSegment.isEmpty) {
          _expression += '0.';
        } else {
          _expression += '.';
        }
      }
    });
  }

  void _onParenthesis(String paren) {
    setState(() {
      if (_evaluated && paren == '(') {
        _expression = '(';
        _result = '';
        _evaluated = false;
        return;
      }
      _expression += paren;
      _evaluated = false;
    });
  }

  void _onClear() {
    setState(() {
      _expression = '';
      _result = '';
      _evaluated = false;
    });
  }

  void _onBackspace() {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
        _result = '';
        _evaluated = false;
      }
    });
  }

  void _onEquals() {
    if (_expression.isEmpty) return;
    try {
      final value = CalculatorLogic.evaluate(_expression);
      final result = CalculatorLogic.formatResult(value);
      final entry = CalculationEntry(
        expression: _expression,
        result: result,
        timestamp: DateTime.now(),
      );
      setState(() {
        _result = result;
        _evaluated = true;
      });
      _historyService.add(entry, _history).then((updated) {
        if (mounted) setState(() => _history = updated);
      });
    } on ArgumentError {
      setState(() => _result = '錯誤：除以零');
    } on FormatException {
      setState(() => _result = '格式錯誤');
    }
  }

  void _clearHistory() {
    _historyService.clear();
    setState(() {
      _history = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '計算機',
      heroTag: 'tool_hero_calculator',
      headerFlex: 2,
      bodyFlex: 4,
      headerChild: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // History action in header
              if (_history.isNotEmpty)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.history),
                    tooltip: '歷史紀錄',
                    onPressed: () => _showHistory(context),
                  ),
                ),
              const Spacer(),
              // Expression display
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  _expression.isEmpty ? '0' : _expression,
                  key: const Key('expression_display'),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface.withAlpha(179),
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 8),
              // Result display — AnimatedValueText
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: AnimatedValueText(
                  key: const Key('result_display'),
                  value: _result.isEmpty ? '' : '= $_result',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bodyChild: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(DT.toolBodyPadding),
              child: ToolSectionCard(
                child: _buildButtonGrid(colorScheme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid(ColorScheme colorScheme) {
    final buttons = [
      ['C', '(', ')', '/'],
      ['7', '8', '9', '*'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '<-', '='],
    ];

    return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            children: row.map((label) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(DT.spaceXs),
                  child: _buildButton(label, colorScheme),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  static const Map<String, String> _semanticLabels = {
    '+': '加法',
    '-': '減法',
    '*': '乘法',
    '/': '除法',
    '=': '等於',
    'C': '清除',
    '<-': '退格',
    '.': '小數點',
    '(': '左括號',
    ')': '右括號',
  };

  Widget _buildButton(String label, ColorScheme colorScheme) {
    Color bgColor;
    Color fgColor;
    VoidCallback onPressed;

    if (label == '=') {
      bgColor = colorScheme.primary;
      fgColor = colorScheme.onPrimary;
      onPressed = _onEquals;
    } else if (label == 'C') {
      bgColor = colorScheme.errorContainer;
      fgColor = colorScheme.onErrorContainer;
      onPressed = _onClear;
    } else if (label == '<-') {
      bgColor = colorScheme.secondaryContainer;
      fgColor = colorScheme.onSecondaryContainer;
      onPressed = _onBackspace;
    } else if ('+-*/'.contains(label)) {
      bgColor = colorScheme.tertiaryContainer;
      fgColor = colorScheme.onTertiaryContainer;
      onPressed = () => _onOperator(label);
    } else if (label == '.') {
      bgColor = colorScheme.surfaceContainerHighest;
      fgColor = colorScheme.onSurface;
      onPressed = _onDecimal;
    } else if (label == '(' || label == ')') {
      bgColor = colorScheme.secondaryContainer;
      fgColor = colorScheme.onSecondaryContainer;
      onPressed = () => _onParenthesis(label);
    } else {
      // Digits
      bgColor = colorScheme.surfaceContainerHighest;
      fgColor = colorScheme.onSurface;
      onPressed = () => _onDigit(label);
    }

    final semanticLabel = _semanticLabels[label] ?? label;

    // onTap intentionally omitted — FilledButton.onPressed is the sole handler.
    return Semantics(
      button: true,
      label: semanticLabel,
      child: BouncingButton(
      child: FilledButton(
        key: Key('btn_$label'),
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DT.toolButtonRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: label == '<-'
            ? Icon(Icons.backspace_outlined, color: fgColor)
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      ),
    );
  }

  void _showHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return _HistorySheet(
          history: _history,
          onClear: () async {
            final confirmed = await showConfirmDialog(
              context: ctx,
              title: '清除歷史紀錄',
              message: '確定要清除所有計算歷史紀錄嗎？此操作無法復原。',
              confirmLabel: '清除',
            );
            if (!confirmed) return;
            _clearHistory();
            if (ctx.mounted) Navigator.pop(ctx);
          },
          onSelect: (entry) {
            setState(() {
              _expression = entry.result;
              _result = '';
              _evaluated = false;
            });
            Navigator.pop(ctx);
          },
        );
      },
    );
  }
}

/// 歷史紀錄 Bottom Sheet（含搜尋功能）。
class _HistorySheet extends StatefulWidget {
  const _HistorySheet({
    required this.history,
    required this.onClear,
    required this.onSelect,
  });

  final List<CalculationEntry> history;
  final VoidCallback onClear;
  final ValueChanged<CalculationEntry> onSelect;

  @override
  State<_HistorySheet> createState() => _HistorySheetState();
}

class _HistorySheetState extends State<_HistorySheet> {
  String _searchQuery = '';

  List<CalculationEntry> get _filteredHistory {
    if (_searchQuery.isEmpty) return widget.history;
    final q = _searchQuery.toLowerCase();
    return widget.history
        .where((e) =>
            e.expression.toLowerCase().contains(q) ||
            e.result.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredHistory;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '歷史紀錄',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton.icon(
                    key: const Key('btn_clear_history'),
                    onPressed: widget.onClear,
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('清除'),
                  ),
                ],
              ),
            ),
            // 搜尋欄
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '搜尋歷史紀錄...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final entry = filtered[index];
                  return ListTile(
                    title: Text(entry.expression),
                    trailing: Text(
                      '= ${entry.result}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => widget.onSelect(entry),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
