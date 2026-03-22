import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
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
  final _wifiSsidController = TextEditingController();
  final _wifiPasswordController = TextEditingController();
  final _emailToController = TextEditingController();
  final _emailSubjectController = TextEditingController();
  final _emailBodyController = TextEditingController();
  int _qrType = 0; // 0=Text, 1=WiFi, 2=Email
  String _wifiEncryption = 'WPA';
  String? _generatedText;

  @override
  void dispose() {
    _textController.dispose();
    _wifiSsidController.dispose();
    _wifiPasswordController.dispose();
    _emailToController.dispose();
    _emailSubjectController.dispose();
    _emailBodyController.dispose();
    super.dispose();
  }

  String _getQrContent() {
    switch (_qrType) {
      case 1: // WiFi
        final ssid = _wifiSsidController.text.trim();
        final password = _wifiPasswordController.text.trim();
        final encryption = _wifiEncryption;
        return 'WIFI:T:$encryption;S:$ssid;P:$password;;';
      case 2: // Email
        final to = _emailToController.text.trim();
        final subject = Uri.encodeComponent(_emailSubjectController.text.trim());
        final body = Uri.encodeComponent(_emailBodyController.text.trim());
        return 'mailto:$to?subject=$subject&body=$body';
      default: // Text
        return _textController.text.trim();
    }
  }

  void _generate() {
    final content = _getQrContent();
    if (content.isEmpty ||
        (_qrType == 1 && _wifiSsidController.text.trim().isEmpty) ||
        (_qrType == 2 && _emailToController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請先輸入要編碼的內容')),
      );
      return;
    }
    setState(() => _generatedText = content);
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

  /// 根據目前 _qrType 建構對應的輸入欄位
  Widget _buildTypeInputFields(AppLocalizations l10n) {
    switch (_qrType) {
      case 1: // WiFi
        return Column(
          children: [
            TextField(
              controller: _wifiSsidController,
              decoration: InputDecoration(
                labelText: l10n.qrWifiSsid,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.wifi),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: DT.spaceMd),
            TextField(
              controller: _wifiPasswordController,
              decoration: InputDecoration(
                labelText: l10n.qrWifiPassword,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _generate(),
            ),
            const SizedBox(height: DT.spaceMd),
            DropdownButtonFormField<String>(
              initialValue: _wifiEncryption,
              decoration: InputDecoration(
                labelText: l10n.qrWifiEncryption,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.security),
              ),
              items: const [
                DropdownMenuItem(value: 'WPA', child: Text('WPA')),
                DropdownMenuItem(value: 'WPA2', child: Text('WPA2')),
                DropdownMenuItem(value: 'None', child: Text('None')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _wifiEncryption = value);
              },
            ),
          ],
        );
      case 2: // Email
        return Column(
          children: [
            TextField(
              controller: _emailToController,
              decoration: InputDecoration(
                labelText: l10n.qrEmailTo,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: DT.spaceMd),
            TextField(
              controller: _emailSubjectController,
              decoration: InputDecoration(
                labelText: l10n.qrEmailSubject,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.subject),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: DT.spaceMd),
            TextField(
              controller: _emailBodyController,
              decoration: InputDecoration(
                labelText: l10n.qrEmailBody,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.notes),
              ),
              maxLines: 3,
              minLines: 1,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _generate(),
            ),
          ],
        );
      default: // Text
        return TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: l10n.qrGeneratorInputHint,
            hintText: '例如：https://example.com',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.text_fields),
          ),
          maxLines: 3,
          minLines: 1,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _generate(),
        );
    }
  }

  /// 輸入與按鈕控制區（下方操作區）
  Widget _buildInputArea(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // 計算 StaggeredFadeIn 的 totalItems
    final hasResult = _generatedText != null;
    final totalItems = hasResult ? 4 : 3;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // QR 類型切換
          StaggeredFadeIn(
            index: 0,
            totalItems: totalItems,
            child: SegmentedButton<int>(
              segments: [
                ButtonSegment(value: 0, label: Text(l10n.qrTypeText), icon: const Icon(Icons.text_fields)),
                ButtonSegment(value: 1, label: Text(l10n.qrTypeWifi), icon: const Icon(Icons.wifi)),
                ButtonSegment(value: 2, label: Text(l10n.qrTypeEmail), icon: const Icon(Icons.email)),
              ],
              selected: {_qrType},
              onSelectionChanged: (selected) {
                setState(() {
                  _qrType = selected.first;
                  _generatedText = null;
                });
              },
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // 輸入欄位區段
          StaggeredFadeIn(
            index: 1,
            totalItems: totalItems,
            child: ToolSectionCard(
              label: l10n.qrGeneratorInput,
              child: _buildTypeInputFields(l10n),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // 產生按鈕
          StaggeredFadeIn(
            index: 2,
            totalItems: totalItems,
            child: ToolGradientButton(
              gradientColors: toolGradients['qr_generator']!,
              label: l10n.qrGeneratorGenerate,
              icon: Icons.qr_code,
              onPressed: _generate,
            ),
          ),

          // 已產生的文字顯示區
          if (hasResult) ...[
            const SizedBox(height: DT.toolSectionGap),
            StaggeredFadeIn(
              index: 3,
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
