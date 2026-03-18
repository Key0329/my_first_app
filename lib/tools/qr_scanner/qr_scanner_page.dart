import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR 掃描'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.qr_code_scanner), text: '掃描'),
              Tab(icon: Icon(Icons.qr_code), text: '產生'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ScannerTab(),
            _GeneratorTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scanner Tab
// ---------------------------------------------------------------------------

class _ScannerTab extends StatefulWidget {
  const _ScannerTab();

  @override
  State<_ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<_ScannerTab> {
  final MobileScannerController _controller = MobileScannerController();
  String? _scannedValue;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isUrl(String text) {
    final uri = Uri.tryParse(text);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已複製到剪貼簿')),
      );
    }
  }

  Future<void> _openUrl(String url) async {
    // Use the platform's default URL handler via MethodChannel
    // For a production app you would use url_launcher package
    await Clipboard.setData(ClipboardData(text: url));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('網址已複製，請在瀏覽器中開啟')),
      );
    }
  }

  void _onDetect(BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;
    final value = barcodes.first.rawValue;
    if (value == null || value == _scannedValue) return;
    setState(() => _scannedValue = value);
  }

  void _resetScanner() {
    setState(() => _scannedValue = null);
  }

  @override
  Widget build(BuildContext context) {
    // If there was an error (e.g. permission denied), show the error UI
    if (_hasError) {
      return _PermissionDeniedView(
        message: _errorMessage,
        onRetry: () {
          setState(() {
            _hasError = false;
            _errorMessage = '';
          });
        },
      );
    }

    return Column(
      children: [
        // Camera preview area
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              errorBuilder: (context, error, child) {
                // Handle permission denied and other camera errors
                String message;
                switch (error.errorCode) {
                  case MobileScannerErrorCode.permissionDenied:
                    message = '需要相機權限才能掃描 QR Code。\n'
                        '請在系統設定中允許此 App 使用相機。';
                  case MobileScannerErrorCode.unsupported:
                    message = '此裝置不支援相機功能。';
                  default:
                    message = '相機發生錯誤：${error.errorDetails?.message ?? '未知錯誤'}';
                }

                return _PermissionDeniedView(
                  message: message,
                  onRetry: () {
                    _controller.start();
                  },
                );
              },
            ),
          ),
        ),

        // Scan result area
        Expanded(
          flex: 2,
          child: _scannedValue == null
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code_scanner, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        '將 QR Code 或條碼對準相機',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : _ScanResultCard(
                  value: _scannedValue!,
                  isUrl: _isUrl(_scannedValue!),
                  onCopy: () => _copyToClipboard(_scannedValue!),
                  onOpenUrl: () => _openUrl(_scannedValue!),
                  onReset: _resetScanner,
                ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Permission Denied View
// ---------------------------------------------------------------------------

class _PermissionDeniedView extends StatelessWidget {
  const _PermissionDeniedView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_photography_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('重試'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: 加入 app_settings 或 permission_handler 套件以直接開啟系統設定
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('請前往「設定 > 隱私權 > 相機」開啟權限'),
                    duration: Duration(seconds: 4),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('開啟系統設定'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scan Result Card
// ---------------------------------------------------------------------------

class _ScanResultCard extends StatelessWidget {
  const _ScanResultCard({
    required this.value,
    required this.isUrl,
    required this.onCopy,
    required this.onOpenUrl,
    required this.onReset,
  });

  final String value;
  final bool isUrl;
  final VoidCallback onCopy;
  final VoidCallback onOpenUrl;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '掃描結果',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SelectableText(
              value,
              style: TextStyle(
                fontSize: 15,
                color: isUrl ? colorScheme.primary : null,
                decoration: isUrl ? TextDecoration.underline : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy),
                  label: const Text('複製文字'),
                ),
              ),
              if (isUrl) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: onOpenUrl,
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('開啟網址'),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('繼續掃描'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Generator Tab
// ---------------------------------------------------------------------------

class _GeneratorTab extends StatefulWidget {
  const _GeneratorTab();

  @override
  State<_GeneratorTab> createState() => _GeneratorTabState();
}

class _GeneratorTabState extends State<_GeneratorTab> {
  final _textController = TextEditingController();
  String? _generatedText;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _generate() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請先輸入要編碼的文字')),
      );
      return;
    }
    setState(() => _generatedText = text);
  }

  Future<void> _copyToClipboard() async {
    if (_generatedText == null) return;
    await Clipboard.setData(ClipboardData(text: _generatedText!));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已複製到剪貼簿')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: '輸入文字或網址',
              hintText: '例如：https://example.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.text_fields),
            ),
            maxLines: 3,
            minLines: 1,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _generate(),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _generate,
            icon: const Icon(Icons.qr_code),
            label: const Text('產生 QR Code'),
          ),
          const SizedBox(height: 24),
          if (_generatedText != null) ...[
            // QR Code placeholder display
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2,
                    size: 100,
                    color: colorScheme.onSurface,
                  ),
                  const SizedBox(height: 12),
                  // TODO: 使用 qr_flutter 或類似套件產生實際 QR Code 圖片
                  Text(
                    'QR Code 預覽',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _generatedText!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: '複製',
                    onPressed: _copyToClipboard,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
