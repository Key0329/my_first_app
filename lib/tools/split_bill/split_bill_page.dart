import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';

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
  int _count = 2;
  int _total = 0;

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

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final result = calculateSplitBill(total: _total, count: _count);

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: '分帳計算',
      heroTag: 'tool_hero_split_bill',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: _SplitBillHeader(total: _total, count: _count),
      bodyChild: _SplitBillBody(
        amountController: _amountController,
        count: _count,
        result: result,
        onIncrement: _increment,
        onDecrement: _decrement,
        minCount: _minCount,
        maxCount: _maxCount,
      ),
    );
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
    final totalStr = total > 0 ? formatWithThousands(total) : '0';
    final summary = '\$$totalStr ÷ $count 人';

    return SafeArea(
      bottom: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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

// ---------------------------------------------------------------------------
// Body（操作區）
// ---------------------------------------------------------------------------

class _SplitBillBody extends StatelessWidget {
  const _SplitBillBody({
    required this.amountController,
    required this.count,
    required this.result,
    required this.onIncrement,
    required this.onDecrement,
    required this.minCount,
    required this.maxCount,
  });

  final TextEditingController amountController;
  final int count;
  final SplitBillResult result;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minCount;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAmountField(context),
          const SizedBox(height: 24),
          _buildCountRow(context),
          const SizedBox(height: 24),
          _buildResultCard(context),
        ],
      ),
    );
  }

  // ---- 總金額輸入 ----

  Widget _buildAmountField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '總金額',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.attach_money),
            hintText: '請輸入總金額',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // ---- 人數控制 ----

  Widget _buildCountRow(BuildContext context) {
    final canDecrement = count > minCount;
    final canIncrement = count < maxCount;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '人數',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 減號按鈕
            Semantics(
              label: '減少人數',
              child: IconButton.outlined(
                onPressed: canDecrement ? onDecrement : null,
                icon: const Icon(Icons.remove),
                style: IconButton.styleFrom(
                  side: BorderSide(
                    color: canDecrement
                        ? colorScheme.outline
                        : colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
            // 人數顯示
            SizedBox(
              width: 72,
              child: Center(
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            // 加號按鈕
            Semantics(
              label: '增加人數',
              child: IconButton.outlined(
                onPressed: canIncrement ? onIncrement : null,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  side: BorderSide(
                    color: canIncrement
                        ? colorScheme.outline
                        : colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---- 結果卡片 ----

  Widget _buildResultCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 每人金額顯示字串
    final perPersonStr = formatWithThousands(result.base);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // 標籤
            Text(
              '每人應付',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            // 金額大字
            Semantics(
              label: '每人應付 $perPersonStr 元',
              child: Text(
                '\$$perPersonStr',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF26A69A),
                ),
              ),
            ),
            // 餘數備註
            if (!result.isEvenSplit) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '第 1 人多付 ${result.remainder} 元（共付 \$${formatWithThousands(result.firstPersonAmount)}）',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
