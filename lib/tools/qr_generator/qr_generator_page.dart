import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorPage extends StatefulWidget {
  const QrGeneratorPage({super.key});

  @override
  State<QrGeneratorPage> createState() => _QrGeneratorPageState();
}

class _QrGeneratorPageState extends State<QrGeneratorPage> {
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
    return ImmersiveToolScaffold(
      toolColor: const Color(0xFF9C27B0),
      title: 'QR Code 產生器',
      heroTag: 'tool_hero_qr_generator',
      headerFlex: 2,
      bodyFlex: 2,
      headerChild: _buildQrPreview(context),
      bodyChild: _buildInputArea(context),
    );
  }

  /// QR Code 預覽區（上方漸層 header）
  Widget _buildQrPreview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: true,
      bottom: false,
      child: Center(
        child: _generatedText != null
            ? Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                child: Center(
                  child: QrImageView(
                    data: _generatedText!,
                    size: 160,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.qr_code_2,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '輸入文字後產生 QR Code',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 輸入與按鈕控制區（下方操作區）
  Widget _buildInputArea(BuildContext context) {
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
          if (_generatedText != null) ...[
            const SizedBox(height: 16),
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
