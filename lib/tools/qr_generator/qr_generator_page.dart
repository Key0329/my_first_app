import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/share_button.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

final Color _toolColor =
    toolGradients['qr_generator']?.first ?? const Color(0xFF9C27B0);

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
    AnalyticsService.instance.logToolComplete(
      toolId: 'qr_generator',
      resultType: 'qr_generated',
    );
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
      toolId: 'qr_generator',
      toolColor: _toolColor,
      title: 'QR Code 產生器',
      heroTag: 'tool_hero_qr_generator',
      headerFlex: 2,
      bodyFlex: 2,
      actions: [
        ShareButton(
          toolId: 'qr_generator',
          enabled: _generatedText != null,
          shareText: '用 Spectra 工具箱產生 QR Code 👉 https://spectra.app/tools/qr-generator',
        ),
      ],
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
                  borderRadius: BorderRadius.circular(DT.radiusLg),
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
                  const SizedBox(height: DT.spaceSm),
                  Text(
                    '輸入文字後產生 QR Code',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: DT.fontSubtitle,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 輸入與按鈕控制區（下方操作區）
  Widget _buildInputArea(BuildContext context) {
    // 計算 StaggeredFadeIn 的 totalItems
    final hasResult = _generatedText != null;
    final totalItems = hasResult ? 3 : 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 輸入欄位區段
          StaggeredFadeIn(
            index: 0,
            totalItems: totalItems,
            child: ToolSectionCard(
              label: '輸入內容',
              child: TextField(
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
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // 產生按鈕
          StaggeredFadeIn(
            index: 1,
            totalItems: totalItems,
            child: ToolGradientButton(
              gradientColors: toolGradients['qr_generator']!,
              label: '產生 QR Code',
              icon: Icons.qr_code,
              onPressed: _generate,
            ),
          ),

          // 已產生的文字顯示區
          if (hasResult) ...[
            const SizedBox(height: DT.toolSectionGap),
            StaggeredFadeIn(
              index: 2,
              totalItems: totalItems,
              child: ToolSectionCard(
                label: '編碼內容',
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _generatedText!,
                        style: const TextStyle(fontSize: DT.fontToolLabel),
                      ),
                    ),
                    BouncingButton(
                      onTap: _copyToClipboard,
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        tooltip: '複製',
                        onPressed: _copyToClipboard,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
