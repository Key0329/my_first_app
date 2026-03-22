import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/utils/platform_check.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

/// QR Code 掃描結果的類型。
enum QrScanResultType {
  url,
  text;

  /// 根據掃描內容自動偵測結果類型。
  static QrScanResultType detect(String value) {
    final lower = value.toLowerCase().trim();
    if (lower.startsWith('http://') ||
        lower.startsWith('https://') ||
        lower.startsWith('ftp://')) {
      return QrScanResultType.url;
    }
    return QrScanResultType.text;
  }
}

/// 工具顏色
const _toolColor = Color(0xFF00BCD4);

/// QR Code 即時掃描頁面。
///
/// 使用 `mobile_scanner` 套件進行即時相機掃描，
/// 掃描結果自動偵測 URL / 純文字並提供對應操作按鈕。
class QrScannerLivePage extends StatefulWidget {
  const QrScannerLivePage({super.key});

  @override
  State<QrScannerLivePage> createState() => _QrScannerLivePageState();
}

class _QrScannerLivePageState extends State<QrScannerLivePage>
    with SingleTickerProviderStateMixin {
  MobileScannerController? _controller;
  String? _scanResult;
  QrScanResultType? _resultType;
  bool _permissionDenied = false;
  bool _hasError = false;
  late AnimationController _frameAnimController;

  @override
  void initState() {
    super.initState();
    _frameAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    if (isMobilePlatform()) {
      _initScanner();
    }
  }

  void _initScanner() {
    _controller = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
    );
  }

  void _handleBarcode(BarcodeCapture capture) {
    // 只處理第一次掃描結果（避免重複觸發）
    if (_scanResult != null) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;

    final value = barcode.displayValue ?? barcode.rawValue ?? '';
    if (value.isEmpty) return;

    // 使用 barcode.type 來判斷，若 mobile_scanner 回傳 url 則直接用
    QrScanResultType type;
    if (barcode.type == BarcodeType.url) {
      type = QrScanResultType.url;
    } else {
      type = QrScanResultType.detect(value);
    }

    setState(() {
      _scanResult = value;
      _resultType = type;
    });

    // 掃到後暫停相機
    _controller?.pause();

    // 播放觸覺回饋
    HapticFeedback.mediumImpact();
  }

  void _rescan() {
    setState(() {
      _scanResult = null;
      _resultType = null;
    });
    _controller?.start();
  }

  Future<void> _copyToClipboard() async {
    if (_scanResult == null) return;
    await Clipboard.setData(ClipboardData(text: _scanResult!));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已複製到剪貼簿')),
      );
    }
  }

  void _retryPermission() {
    setState(() {
      _permissionDenied = false;
      _hasError = false;
    });
    _controller?.dispose();
    _initScanner();
  }

  @override
  void dispose() {
    _frameAnimController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isMobilePlatform()) {
      return const PlatformUnsupportedView(toolName: 'QR Code 掃描器');
    }

    return ImmersiveToolScaffold(
      toolId: 'qr_scanner_live',
      toolColor: _toolColor,
      title: 'QR Code 掃描器',
      heroTag: 'tool_hero_qr_scanner_live',
      headerFlex: 3,
      bodyFlex: 2,
      showHeaderGradient: false,
      headerChild: _buildCameraPreview(),
      bodyChild: _buildBody(),
    );
  }

  /// 相機預覽 + 掃描框疊加
  Widget _buildCameraPreview() {
    if (_controller == null) {
      return const ColoredBox(color: Colors.black);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // 相機預覽
        MobileScanner(
          controller: _controller!,
          onDetect: _handleBarcode,
          errorBuilder: (context, error, child) {
            // 處理權限被拒絕
            if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !_permissionDenied) {
                  setState(() => _permissionDenied = true);
                }
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !_hasError) {
                  setState(() => _hasError = true);
                }
              });
            }
            return const ColoredBox(color: Colors.black);
          },
          placeholderBuilder: (context, child) {
            return const ColoredBox(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          },
        ),

        // 掃描框動畫覆蓋
        if (!_permissionDenied && !_hasError)
          AnimatedBuilder(
            animation: _frameAnimController,
            builder: (context, child) {
              return CustomPaint(
                painter: ScanFrameOverlayPainter(
                  frameColor: _toolColor,
                  animationValue: _frameAnimController.value,
                ),
                child: const SizedBox.expand(),
              );
            },
          ),

        // 權限被拒絕時的覆蓋 UI
        if (_permissionDenied)
          CameraPermissionDeniedView(onRetry: _retryPermission),

        // 一般錯誤覆蓋
        if (_hasError && !_permissionDenied)
          _buildErrorView(),
      ],
    );
  }

  Widget _buildErrorView() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.white70),
            const SizedBox(height: DT.spaceLg),
            Text(
              '相機啟動失敗',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: DT.spaceSm),
            Text(
              '請確認相機功能正常後重試',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 下方結果/狀態區域
  Widget _buildBody() {
    if (_permissionDenied) {
      return _buildPermissionDeniedBody();
    }

    if (_scanResult != null && _resultType != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(DT.toolBodyPadding),
        child: QrScanResultSheet(
          result: _scanResult!,
          resultType: _resultType!,
          onCopy: _copyToClipboard,
          onRescan: _rescan,
        ),
      );
    }

    return _buildScanHint();
  }

  Widget _buildScanHint() {
    return Center(
      child: StaggeredFadeIn(
        index: 0,
        totalItems: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: DT.spaceLg),
            Text(
              '將 QR Code 對準掃描框',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedBody() {
    return Padding(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Center(
        child: StaggeredFadeIn(
          index: 0,
          totalItems: 1,
          child: ToolSectionCard(
            label: '相機權限',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '請前往系統設定開啟相機權限，才能使用掃描功能。',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: DT.spaceLg),
                FilledButton.icon(
                  onPressed: _retryPermission,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重新嘗試'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 掃描結果顯示面板。
///
/// 顯示掃描結果、類型標籤，以及「複製」和「重新掃描」按鈕。
class QrScanResultSheet extends StatelessWidget {
  const QrScanResultSheet({
    super.key,
    required this.result,
    required this.resultType,
    required this.onCopy,
    required this.onRescan,
  });

  final String result;
  final QrScanResultType resultType;
  final VoidCallback onCopy;
  final VoidCallback onRescan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 結果卡片
        StaggeredFadeIn(
          index: 0,
          totalItems: 3,
          child: ToolSectionCard(
            label: '掃描結果',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 類型標籤
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DT.spaceSm,
                    vertical: DT.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color: resultType == QrScanResultType.url
                        ? _toolColor.withValues(alpha: 0.15)
                        : colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(DT.radiusSm),
                  ),
                  child: Text(
                    resultType == QrScanResultType.url ? 'URL' : '文字',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: resultType == QrScanResultType.url
                          ? _toolColor
                          : colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: DT.spaceSm),

                // 結果文字
                SelectableText(
                  result,
                  style: TextStyle(
                    fontSize: DT.fontToolLabel,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: DT.toolSectionGap),

        // 操作按鈕列
        StaggeredFadeIn(
          index: 1,
          totalItems: 3,
          child: Row(
            children: [
              // 複製按鈕
              Expanded(
                child: FilledButton.icon(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy),
                  label: const Text('複製'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _toolColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DT.toolButtonRadius),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: DT.toolSectionGap),

              // 重新掃描按鈕
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onRescan,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('重新掃描'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _toolColor,
                    side: const BorderSide(color: _toolColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DT.toolButtonRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // URL 提示
        if (resultType == QrScanResultType.url) ...[
          const SizedBox(height: DT.toolSectionGap),
          StaggeredFadeIn(
            index: 2,
            totalItems: 3,
            child: Text(
              '複製網址後可在瀏覽器中開啟',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// 相機權限被拒絕時顯示的引導畫面。
class CameraPermissionDeniedView extends StatelessWidget {
  const CameraPermissionDeniedView({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(DT.space2xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(height: DT.spaceLg),
              Text(
                '需要相機權限',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: DT.spaceSm),
              Text(
                '請在系統設定中允許此 App 使用相機',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: DT.spaceXl),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('重新嘗試'),
                style: FilledButton.styleFrom(
                  backgroundColor: _toolColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 掃描框覆蓋 Painter。
///
/// 繪製半透明背景 + 中央正方形掃描框 + 四角高亮 + 掃描線動畫。
class ScanFrameOverlayPainter extends CustomPainter {
  ScanFrameOverlayPainter({
    required this.frameColor,
    required this.animationValue,
  });

  final Color frameColor;

  /// 0.0 ~ 1.0，控制掃描線位置
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final frameSize = math.min(size.width, size.height) * 0.65;
    final frameRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: frameSize,
      height: frameSize,
    );

    // 半透明背景（掃描框外部）
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath = Path()
      ..addRRect(RRect.fromRectAndRadius(frameRect, const Radius.circular(12)));
    final overlay = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(
      overlay,
      Paint()
        ..color = const Color(0x80000000)
        ..style = PaintingStyle.fill,
    );

    // 掃描框邊框
    canvas.drawRRect(
      RRect.fromRectAndRadius(frameRect, const Radius.circular(12)),
      Paint()
        ..color = frameColor.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // 四角高亮
    _drawCorners(canvas, frameRect);

    // 掃描線
    final scanLineY = frameRect.top + frameRect.height * animationValue;
    canvas.drawLine(
      Offset(frameRect.left + 12, scanLineY),
      Offset(frameRect.right - 12, scanLineY),
      Paint()
        ..color = frameColor.withValues(alpha: 0.8)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawCorners(Canvas canvas, Rect rect) {
    const cornerLength = 24.0;
    const cornerRadius = 12.0;
    final paint = Paint()
      ..color = frameColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // 左上
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.top + cornerLength)
        ..lineTo(rect.left, rect.top + cornerRadius)
        ..arcToPoint(
          Offset(rect.left + cornerRadius, rect.top),
          radius: const Radius.circular(cornerRadius),
        )
        ..lineTo(rect.left + cornerLength, rect.top),
      paint,
    );

    // 右上
    canvas.drawPath(
      Path()
        ..moveTo(rect.right - cornerLength, rect.top)
        ..lineTo(rect.right - cornerRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + cornerRadius),
          radius: const Radius.circular(cornerRadius),
        )
        ..lineTo(rect.right, rect.top + cornerLength),
      paint,
    );

    // 左下
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.bottom - cornerLength)
        ..lineTo(rect.left, rect.bottom - cornerRadius)
        ..arcToPoint(
          Offset(rect.left + cornerRadius, rect.bottom),
          radius: const Radius.circular(cornerRadius),
        )
        ..lineTo(rect.left + cornerLength, rect.bottom),
      paint,
    );

    // 右下
    canvas.drawPath(
      Path()
        ..moveTo(rect.right - cornerLength, rect.bottom)
        ..lineTo(rect.right - cornerRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.right, rect.bottom - cornerRadius),
          radius: const Radius.circular(cornerRadius),
        )
        ..lineTo(rect.right, rect.bottom - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(ScanFrameOverlayPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        frameColor != oldDelegate.frameColor;
  }
}
