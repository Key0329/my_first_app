import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'invoice_api.dart';
import 'invoice_parser.dart';

class InvoiceCheckerPage extends StatefulWidget {
  const InvoiceCheckerPage({super.key});

  @override
  State<InvoiceCheckerPage> createState() => _InvoiceCheckerPageState();
}

class _InvoiceCheckerPageState extends State<InvoiceCheckerPage> {
  final _invoiceApi = InvoiceApi();
  final _manualController = TextEditingController();
  final _manualFocusNode = FocusNode();

  WinningNumbers? _winningNumbers;
  bool _isLoadingNumbers = true;
  String? _loadError;

  PrizeResult? _prizeResult;
  String? _checkedInvoice;
  bool _hasChecked = false;

  @override
  void initState() {
    super.initState();
    _loadWinningNumbers();
  }

  @override
  void dispose() {
    _manualController.dispose();
    _manualFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadWinningNumbers() async {
    setState(() {
      _isLoadingNumbers = true;
      _loadError = null;
    });

    try {
      final numbers = await _invoiceApi.getWinningNumbers();
      if (mounted) {
        setState(() {
          _winningNumbers = numbers;
          _isLoadingNumbers = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadError = '無法載入中獎號碼，請稍後再試';
          _isLoadingNumbers = false;
        });
      }
    }
  }

  void _checkInvoice(String invoiceNumber) {
    if (_winningNumbers == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('中獎號碼尚未載入，請稍後再試')),
      );
      return;
    }

    final result = InvoiceApi.checkPrize(invoiceNumber, _winningNumbers!);
    setState(() {
      _checkedInvoice = invoiceNumber;
      _prizeResult = result;
      _hasChecked = true;
    });
  }

  void _onManualSubmit() {
    final input = _manualController.text.trim();
    if (input.isEmpty) return;

    try {
      final invoiceNumber = InvoiceParser.validateAndNormalize(input);
      _checkInvoice(invoiceNumber);
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  void _onQrScanned(String rawData) {
    try {
      final invoiceNumber = InvoiceParser.parseQrCode(rawData);
      _checkInvoice(invoiceNumber);
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  void _resetCheck() {
    setState(() {
      _hasChecked = false;
      _prizeResult = null;
      _checkedInvoice = null;
      _manualController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('發票對獎')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 中獎號碼區塊
            _buildWinningNumbersSection(),
            const SizedBox(height: 24),

            // 結果顯示
            if (_hasChecked) ...[
              _buildResultCard(),
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: _resetCheck,
                  icon: const Icon(Icons.refresh),
                  label: const Text('再查一張'),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // 輸入方式
            if (!_hasChecked) ...[
              _buildScanButton(),
              const SizedBox(height: 16),
              _buildManualInput(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWinningNumbersSection() {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoadingNumbers) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_loadError != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.cloud_off, size: 40, color: colorScheme.error),
              const SizedBox(height: 8),
              Text(_loadError!, style: TextStyle(color: colorScheme.error)),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _loadWinningNumbers,
                icon: const Icon(Icons.refresh),
                label: const Text('重新載入'),
              ),
            ],
          ),
        ),
      );
    }

    final numbers = _winningNumbers!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '${numbers.period} 中獎號碼',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildNumberRow('特別獎', [numbers.specialPrize], '1,000 萬'),
            const SizedBox(height: 8),
            _buildNumberRow('特獎', [numbers.grandPrize], '200 萬'),
            const SizedBox(height: 8),
            _buildNumberRow('頭獎', numbers.firstPrizes, '20 萬'),
            if (numbers.additionalSixthPrizes.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildNumberRow(
                '增開六獎',
                numbers.additionalSixthPrizes,
                '200',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNumberRow(String label, List<String> numbers, String amount) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: numbers
                .map(
                  (n) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      n,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Text(
          '$amount 元',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard() {
    final colorScheme = Theme.of(context).colorScheme;
    final isWinner = _prizeResult != null;

    return Card(
      color: isWinner
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              isWinner ? Icons.celebration : Icons.sentiment_dissatisfied,
              size: 48,
              color: isWinner
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              '發票號碼：$_checkedInvoice',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            if (isWinner) ...[
              Text(
                '恭喜中獎！',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_prizeResult!.tierName} — 獎金 ${_formatAmount(_prizeResult!.amount)} 元',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ] else
              Text(
                '未中獎',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  Widget _buildScanButton() {
    return FilledButton.icon(
      onPressed: () => _showScannerDialog(),
      icon: const Icon(Icons.qr_code_scanner),
      label: const Text('掃描發票 QR Code'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  void _showScannerDialog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _InvoiceScannerSheet(
            onScanned: (rawData) {
              Navigator.of(context).pop();
              _onQrScanned(rawData);
            },
          ),
        );
      },
    );
  }

  Widget _buildManualInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('或手動輸入', style: TextStyle(color: Colors.grey)),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _manualController,
          focusNode: _manualFocusNode,
          decoration: const InputDecoration(
            labelText: '發票號碼',
            hintText: '例如：AB12345678',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.receipt_long),
            counterText: '',
          ),
          maxLength: 10,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
          ],
          onSubmitted: (_) => _onManualSubmit(),
        ),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: _onManualSubmit,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text('對獎'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// QR Code 掃描底部面板
// ---------------------------------------------------------------------------

class _InvoiceScannerSheet extends StatefulWidget {
  const _InvoiceScannerSheet({required this.onScanned});

  final ValueChanged<String> onScanned;

  @override
  State<_InvoiceScannerSheet> createState() => _InvoiceScannerSheetState();
}

class _InvoiceScannerSheetState extends State<_InvoiceScannerSheet> {
  final MobileScannerController _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;
    final value = barcodes.first.rawValue;
    if (value == null) return;

    _scanned = true;
    widget.onScanned(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.qr_code_scanner),
              const SizedBox(width: 8),
              Text(
                '掃描發票 QR Code',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              errorBuilder: (context, error, child) {
                String message;
                switch (error.errorCode) {
                  case MobileScannerErrorCode.permissionDenied:
                    message = '需要相機權限才能掃描發票。\n'
                        '請在系統設定中允許此 App 使用相機。';
                  case MobileScannerErrorCode.unsupported:
                    message = '此裝置不支援相機功能，請使用手動輸入。';
                  default:
                    message =
                        '相機發生錯誤：${error.errorDetails?.message ?? '未知錯誤'}';
                }

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.no_photography_outlined,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 12),
                        Text(message, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
