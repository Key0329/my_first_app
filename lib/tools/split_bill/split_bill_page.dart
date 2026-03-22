import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/share_card_generator.dart';
import 'package:my_first_app/widgets/share_card_template.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:share_plus/share_plus.dart';

// ---------------------------------------------------------------------------
// 計算邏輯（純函式，方便單元測試）
// ---------------------------------------------------------------------------

/// 分帳計算結果。
///
/// - [base]      ：每人基礎金額（整數）
/// - [remainder] ：除不盡的餘數（0 表示整除）
/// - [firstExtra]：第一人需額外多付的金額（等於 remainder）
class SplitBillResult {
  const SplitBillResult({
    required this.base,
    required this.remainder,
  });

  /// 每人基礎付款金額（total ~/ count）
  final int base;

  /// 除不盡的餘數（total % count）
  final int remainder;

  /// 第一人應付金額
  int get firstPersonAmount => base + remainder;

  /// 是否整除（無餘數）
  bool get isEvenSplit => remainder == 0;
}

/// 計算分帳結果。
///
/// [total] 必須 >= 0，[count] 必須 >= 2。
/// 若 [total] 為 0，回傳 base = 0、remainder = 0。
SplitBillResult calculateSplitBill({
  required int total,
  required int count,
}) {
  assert(count >= 2, 'count must be at least 2');
  assert(total >= 0, 'total must be non-negative');

  if (total == 0) {
    return const SplitBillResult(base: 0, remainder: 0);
  }

  return SplitBillResult(
    base: total ~/ count,
    remainder: total % count,
  );
}

/// 含小費的分帳計算。
SplitBillResult calculateWithTip({
  required int total,
  required int count,
  required int tipPercent,
}) {
  final tip = (total * tipPercent / 100).round();
  return calculateSplitBill(total: total + tip, count: count);
}

/// 按比例分帳。回傳每人應付金額列表。
List<int> calculateByRatio({
  required int total,
  required List<int> ratios,
}) {
  assert(ratios.isNotEmpty);
  final sum = ratios.fold(0, (a, b) => a + b);
  if (sum == 0) return List.filled(ratios.length, 0);

  final results = <int>[];
  var remaining = total;
  for (var i = 0; i < ratios.length; i++) {
    if (i == ratios.length - 1) {
      results.add(remaining);
    } else {
      final share = (total * ratios[i] / sum).round();
      results.add(share);
      remaining -= share;
    }
  }
  return results;
}

/// 多項目分帳的單一項目。
class SplitItem {
  String name;
  int amount;
  int people;

  SplitItem({this.name = '', this.amount = 0, this.people = 2});
}

/// 多項目分帳結果：每項目每人金額。
List<int> calculateMultiItemPerPerson(List<SplitItem> items) {
  return items
      .map((item) => item.people > 0 ? item.amount ~/ item.people : 0)
      .toList();
}

// ---------------------------------------------------------------------------
// 格式化工具
// ---------------------------------------------------------------------------

/// 將整數格式化為千分位字串（例如 1500 → "1,500"）。
String formatWithThousands(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  final mod = s.length % 3;
  for (var i = 0; i < s.length; i++) {
    if (i != 0 && (i - mod) % 3 == 0) {
      buf.write(',');
    }
    buf.write(s[i]);
  }
  return buf.toString();
}

// ---------------------------------------------------------------------------
// Page Widget
// ---------------------------------------------------------------------------

/// 分帳計算工具頁面。
///
/// 輸入總金額與人數，計算每人應付金額。
/// 若除不盡，第一人多付餘數金額。
class SplitBillPage extends StatefulWidget {
  const SplitBillPage({super.key});

  @override
  State<SplitBillPage> createState() => _SplitBillPageState();
}

class _SplitBillPageState extends State<SplitBillPage> {
  static const Color _toolColor = Color(0xFF26A69A);
  static const int _minCount = 2;
  static const int _maxCount = 30;

  final TextEditingController _amountController = TextEditingController();
  final GlobalKey _shareCardKey = GlobalKey();
  int _count = 2;
  int _total = 0;
  bool _hasTrackedComplete = false;
  int _splitMode = 0; // 0=equal, 1=ratio, 2=multi
  int _tipPercent = 0;
  final List<int> _ratios = [1, 1];
  final List<SplitItem> _items = [SplitItem(name: '', amount: 0, people: 2)];

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController
      ..removeListener(_onAmountChanged)
      ..dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final text = _amountController.text.trim();
    final parsed = int.tryParse(text) ?? 0;
    if (parsed != _total) {
      setState(() {
        _total = parsed < 0 ? 0 : parsed;
      });
      if (_total > 0 && !_hasTrackedComplete) {
        _hasTrackedComplete = true;
        AnalyticsService.instance.logToolComplete(
          toolId: 'split_bill',
          resultType: 'bill_split',
        );
      }
    }
  }

  void _increment() {
    if (_count < _maxCount) {
      setState(() => _count++);
    }
  }

  void _decrement() {
    if (_count > _minCount) {
      setState(() => _count--);
    }
  }

  Future<void> _shareAsCard() async {
    AnalyticsService.instance.logToolShare(
      toolId: 'split_bill',
      shareMethod: 'share_card',
    );

    final xFile = await ShareCardGenerator.capture(_shareCardKey);
    if (xFile != null) {
      await Share.shareXFiles([xFile], text: '用 Spectra 工具箱快速分帳');
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  int get _tipAmount => (_total * _tipPercent / 100).round();
  int get _totalWithTip => _total + _tipAmount;

  void _onModeChanged(int mode) {
    setState(() {
      _splitMode = mode;
      // Sync ratio count with people count
      while (_ratios.length < _count) {
        _ratios.add(1);
      }
      while (_ratios.length > _count) {
        _ratios.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final result = _splitMode == 0
        ? calculateWithTip(total: _total, count: _count, tipPercent: _tipPercent)
        : calculateSplitBill(total: _total, count: _count);
    final enabled = _total > 0;

    return Stack(
      children: [
        ImmersiveToolScaffold(
          toolId: 'split_bill',
          toolColor: _toolColor,
          title: l10n.splitBillTitle,
          heroTag: 'tool_hero_split_bill',
          headerFlex: 2,
          bodyFlex: 3,
          actions: [
            Opacity(
              opacity: enabled ? 1.0 : 0.4,
              child: IconButton(
                onPressed: enabled ? _shareAsCard : null,
                icon: const Icon(Icons.share),
                tooltip: l10n.commonShare,
              ),
            ),
          ],
          headerChild: _SplitBillHeader(total: _totalWithTip, count: _count),
          bodyChild: _buildBodyForMode(context, l10n, result),
        ),
        // 隱藏的分享卡片
        Offstage(
          child: RepaintBoundary(
            key: _shareCardKey,
            child: ShareCardTemplate(
              toolName: l10n.splitBillTitle,
              gradientColors: toolGradients['split_bill']!,
              resultChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.splitBillPerPerson,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'NT\$${formatWithThousands(result.base)}',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF26A69A)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.splitBillSummary('NT\$${formatWithThousands(_totalWithTip)}', _count),
                    style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyForMode(BuildContext context, AppLocalizations l10n, SplitBillResult result) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mode switcher
          SegmentedButton<int>(
            segments: [
              ButtonSegment(value: 0, label: Text(l10n.splitBillModeEqual)),
              ButtonSegment(value: 1, label: Text(l10n.splitBillModeRatio)),
              ButtonSegment(value: 2, label: Text(l10n.splitBillModeMulti)),
            ],
            selected: {_splitMode},
            onSelectionChanged: (v) => _onModeChanged(v.first),
          ),
          const SizedBox(height: DT.toolSectionGap),

          if (_splitMode == 0) ..._buildEqualMode(context, l10n, result),
          if (_splitMode == 1) ..._buildRatioMode(context, l10n),
          if (_splitMode == 2) ..._buildMultiItemMode(context, l10n),
        ],
      ),
    );
  }

  List<Widget> _buildEqualMode(BuildContext context, AppLocalizations l10n, SplitBillResult result) {
    return [
      // Total amount
      ToolSectionCard(
        label: l10n.splitBillTotalAmount,
        child: TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.attach_money),
            hintText: l10n.splitBillTotalHint,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // Tip percentage
      ToolSectionCard(
        label: l10n.splitBillTip,
        child: Wrap(
          spacing: 8,
          children: [0, 5, 10, 15, 20].map((pct) {
            final selected = _tipPercent == pct;
            return ChoiceChip(
              label: Text(pct == 0 ? '0%' : '$pct%'),
              selected: selected,
              onSelected: (_) => setState(() => _tipPercent = pct),
            );
          }).toList(),
        ),
      ),
      if (_tipPercent > 0) ...[
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.splitBillTipAmount, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.outline)),
              Text('NT\$${formatWithThousands(_tipAmount)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.splitBillFinalTotal, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.outline)),
              Text('NT\$${formatWithThousands(_totalWithTip)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
      const SizedBox(height: DT.toolSectionGap),

      // People count
      ToolSectionCard(
        label: l10n.splitBillPeople,
        child: _buildCountRow(context, l10n),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // Result
      _buildResultCard(context, l10n, result),
    ];
  }

  Widget _buildCountRow(BuildContext context, AppLocalizations l10n) {
    final canDecrement = _count > _minCount;
    final canIncrement = _count < _maxCount;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BouncingButton(
          onTap: canDecrement ? _decrement : null,
          child: Semantics(
            label: l10n.splitBillDecrease,
            child: IconButton.outlined(
              onPressed: canDecrement ? _decrement : null,
              icon: const Icon(Icons.remove),
              style: IconButton.styleFrom(
                side: BorderSide(color: canDecrement ? colorScheme.outline : colorScheme.outlineVariant),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 72,
          child: Center(
            child: AnimatedValueText(
              value: '$_count',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BouncingButton(
          onTap: canIncrement ? _increment : null,
          child: Semantics(
            label: l10n.splitBillIncrease,
            child: IconButton.outlined(
              onPressed: canIncrement ? _increment : null,
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                side: BorderSide(color: canIncrement ? colorScheme.outline : colorScheme.outlineVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(BuildContext context, AppLocalizations l10n, SplitBillResult result) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final perPersonStr = formatWithThousands(result.base);
    final tintedBg = brightness == Brightness.dark
        ? _toolColor.withValues(alpha: 0.12)
        : _toolColor.withValues(alpha: 0.08);

    return Container(
      decoration: BoxDecoration(
        color: tintedBg,
        borderRadius: BorderRadius.circular(DT.toolSectionRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: DT.space2xl, vertical: DT.spaceXl),
      child: Column(
        children: [
          Text(l10n.splitBillPerPerson, style: TextStyle(fontSize: DT.fontToolLabel, color: DT.brandPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(height: DT.spaceSm),
          Semantics(
            label: l10n.splitBillPerPersonSemantic(perPersonStr),
            child: AnimatedValueText(
              value: '\$$perPersonStr',
              style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: _toolColor),
            ),
          ),
          if (!result.isEvenSplit) ...[
            const SizedBox(height: DT.toolSectionGap),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: DT.toolSectionGap, vertical: DT.spaceXs + 2),
              decoration: BoxDecoration(
                color: _toolColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(DT.spaceSm),
              ),
              child: Text(
                l10n.splitBillFirstPaysDetail(result.remainder, formatWithThousands(result.firstPersonAmount)),
                style: theme.textTheme.bodySmall?.copyWith(color: _toolColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildRatioMode(BuildContext context, AppLocalizations l10n) {
    final amounts = calculateByRatio(total: _totalWithTip, ratios: _ratios);
    return [
      // Total amount
      ToolSectionCard(
        label: l10n.splitBillTotalAmount,
        child: TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.attach_money),
            hintText: l10n.splitBillTotalHint,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // Tip
      ToolSectionCard(
        label: l10n.splitBillTip,
        child: Wrap(
          spacing: 8,
          children: [0, 5, 10, 15, 20].map((pct) => ChoiceChip(
            label: Text(pct == 0 ? '0%' : '$pct%'),
            selected: _tipPercent == pct,
            onSelected: (_) => setState(() => _tipPercent = pct),
          )).toList(),
        ),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // People count
      ToolSectionCard(
        label: l10n.splitBillPeople,
        child: _buildCountRow(context, l10n),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // Ratio inputs + results
      ToolSectionCard(
        label: l10n.splitBillRatioLabel,
        child: Column(
          children: List.generate(_count, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.splitBillRatioPerson(i + 1),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: '${_ratios[i]}'),
                      onChanged: (v) {
                        final val = int.tryParse(v) ?? 1;
                        setState(() => _ratios[i] = val < 1 ? 1 : val);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'NT\$${formatWithThousands(amounts[i])}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _toolColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    ];
  }

  List<Widget> _buildMultiItemMode(BuildContext context, AppLocalizations l10n) {
    final perPersonAmounts = calculateMultiItemPerPerson(_items);

    return [
      // Item list
      ...List.generate(_items.length, (i) {
        final item = _items[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: DT.toolSectionGap),
          child: ToolSectionCard(
            label: '${l10n.splitBillItemName} ${i + 1}',
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: l10n.splitBillItemName,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => item.name = v),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          hintText: l10n.splitBillItemAmount,
                          border: const OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: const Icon(Icons.attach_money, size: 20),
                        ),
                        onChanged: (v) =>
                            setState(() => item.amount = int.tryParse(v) ?? 0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: l10n.splitBillItemPeople,
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        controller: TextEditingController(text: '${item.people}'),
                        onChanged: (v) {
                          final val = int.tryParse(v) ?? 1;
                          setState(() => item.people = val < 1 ? 1 : val);
                        },
                      ),
                    ),
                  ],
                ),
                if (item.amount > 0 && item.people > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${l10n.splitBillItemPerPerson}: NT\$${formatWithThousands(perPersonAmounts[i])}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _toolColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),

      // Add item button
      Center(
        child: TextButton.icon(
          onPressed: () => setState(() => _items.add(SplitItem())),
          icon: const Icon(Icons.add),
          label: Text(l10n.splitBillAddItem),
        ),
      ),
      const SizedBox(height: DT.toolSectionGap),

      // Summary
      if (_items.any((item) => item.amount > 0))
        ToolSectionCard(
          label: l10n.splitBillMultiSummary,
          child: Column(
            children: [
              ...List.generate(_items.length, (i) {
                if (_items[i].amount == 0) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _items[i].name.isEmpty ? '${l10n.splitBillItemName} ${i + 1}' : _items[i].name,
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        'NT\$${formatWithThousands(perPersonAmounts[i])} × ${_items[i].people}',
                        style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.outline),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.splitBillTotalAmount, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    'NT\$${formatWithThousands(_items.fold(0, (sum, item) => sum + item.amount))}',
                    style: TextStyle(fontWeight: FontWeight.w600, color: _toolColor),
                  ),
                ],
              ),
            ],
          ),
        ),
    ];
  }
}

// ---------------------------------------------------------------------------
// Header（純顯示，const 可最佳化重建）
// ---------------------------------------------------------------------------

class _SplitBillHeader extends StatelessWidget {
  const _SplitBillHeader({
    required this.total,
    required this.count,
  });

  final int total;
  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalStr = total > 0 ? formatWithThousands(total) : '0';
    final summary = l10n.splitBillSummary('\$$totalStr', count);

    return SafeArea(
      bottom: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DT.space2xl),
          child: Text(
            summary,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
