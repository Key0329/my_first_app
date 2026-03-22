import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/utils/platform_check.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

final Color _toolColor =
    toolGradients['color_picker']?.first ?? const Color(0xFFFF9800);

/// Helper to extract an 8-bit channel value from the new [Color] API
/// (where r/g/b are 0.0–1.0 doubles).
int _to8bit(double v) => (v * 255.0).round().clamp(0, 255);

/// A color entry stored in the pick history.
class _ColorEntry {
  final Color color;
  final DateTime pickedAt;

  const _ColorEntry({required this.color, required this.pickedAt});

  int get r8 => _to8bit(color.r);
  int get g8 => _to8bit(color.g);
  int get b8 => _to8bit(color.b);

  String get hex =>
      '#${r8.toRadixString(16).padLeft(2, '0')}'
      '${g8.toRadixString(16).padLeft(2, '0')}'
      '${b8.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();

  String get rgb => '$r8, $g8, $b8';
}

/// Color Picker tool page.
///
/// Uses the device camera to show a live preview with a crosshair.
/// User taps the capture button to pick the color at the center of the frame.
/// Displays HEX and RGB values, supports copy-to-clipboard and keeps a
/// history palette of up to 20 recently picked colors.
class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage>
    with WidgetsBindingObserver {
  MobileScannerController? _controller;
  final GlobalKey _cameraKey = GlobalKey();
  final List<_ColorEntry> _history = [];
  _ColorEntry? _selectedEntry;
  bool _hasPermission = true;
  bool _isCapturing = false;
  bool _controllerInitialized = false;

  static const int _maxHistory = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Dispose any existing controller first.
    _controller?.dispose();

    final controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      formats: const [],
    );

    _controller = controller;

    // Put the MobileScanner widget in the tree FIRST, so the texture surface
    // is ready before the camera starts writing to it.
    if (mounted) {
      setState(() {
        _controllerInitialized = true;
        _hasPermission = true;
      });
    }

    // Wait for the widget tree to rebuild, then start the camera.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      try {
        await controller.start();
      } on MobileScannerException catch (e) {
        if (e.errorCode == MobileScannerErrorCode.permissionDenied) {
          if (mounted) {
            setState(() {
              _hasPermission = false;
            });
          }
        }
      } catch (_) {
        // Camera start failed for other reasons
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Restart camera when user returns from system settings
    if (state == AppLifecycleState.resumed && !_hasPermission) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    try {
      _controller?.stop();
    } catch (_) {
      // 相機可能已在關閉中，忽略錯誤
    }
    _controller?.dispose();
    super.dispose();
  }

  /// Captures the center pixel color from the camera preview using
  /// RepaintBoundary screenshot.
  Future<void> _captureColor() async {
    if (_isCapturing) return;
    setState(() => _isCapturing = true);

    try {
      final boundary = _cameraKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 1.0);
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );

      if (byteData == null) {
        image.dispose();
        return;
      }

      final centerX = image.width ~/ 2;
      final centerY = image.height ~/ 2;
      final pixelIndex = (centerY * image.width + centerX) * 4;

      if (pixelIndex + 3 >= byteData.lengthInBytes) {
        image.dispose();
        return;
      }

      final r = byteData.getUint8(pixelIndex);
      final g = byteData.getUint8(pixelIndex + 1);
      final b = byteData.getUint8(pixelIndex + 2);

      image.dispose();

      final color = Color.fromARGB(255, r, g, b);
      if (mounted) {
        final entry = _ColorEntry(color: color, pickedAt: DateTime.now());
        setState(() {
          _history.insert(0, entry);
          if (_history.length > _maxHistory) {
            _history.removeLast();
          }
          _selectedEntry = entry;
        });
      }
    } catch (_) {
      // Capture failed — silently ignore
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  void _selectHistoryEntry(_ColorEntry entry) {
    setState(() {
      _selectedEntry = entry;
    });
  }

  Future<void> _copyToClipboard(String text, String label) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('已複製 $label: $text'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _openAppSettings() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.colorPickerPermission),
        content: const Text('請前往系統設定，允許此應用程式使用相機。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('好'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build methods
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (!isMobilePlatform()) {
      return const PlatformUnsupportedView(toolName: '色彩擷取');
    }

    return ImmersiveToolScaffold(
      toolId: 'color_picker',
      toolColor: _toolColor,
      title: '色彩擷取',
      // 不使用 Hero 動畫 — 相機需要穩定的 widget tree，
      // Hero 飛行期間的 reparent 會導致 camera surface 崩潰
      headerFlex: 2,
      bodyFlex: 3,
      showHeaderGradient: false,
      headerChild: _buildCameraHeader(context),
      bodyChild: _buildColorInfoArea(context),
    );
  }

  /// 相機預覽區（上方漸層 header）
  Widget _buildCameraHeader(BuildContext context) {
    if (!_hasPermission) {
      return _buildPermissionDenied();
    }
    return _buildCameraPreview();
  }

  Widget _buildPermissionDenied() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: Colors.white70,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.colorPickerPermission,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '色彩擷取需要使用相機來偵測顏色。\n請在系統設定中允許相機存取。',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _openAppSettings,
              icon: const Icon(Icons.settings),
              label: const Text('前往設定'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_controllerInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      top: true,
      bottom: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRect(
            child: RepaintBoundary(
              key: _cameraKey,
              child: MobileScanner(
                controller: _controller!,
                fit: BoxFit.cover,
                onDetect: (_) {},
              ),
            ),
          ),
          // Crosshair overlay
          CustomPaint(
            size: const Size(80, 80),
            painter: _CrosshairPainter(color: Colors.white),
          ),
          // Capture button
          Positioned(
            bottom: 16,
            child: FloatingActionButton.extended(
              heroTag: 'color_capture',
              onPressed: _isCapturing ? null : _captureColor,
              icon: _isCapturing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.colorize),
              label: Text(_isCapturing ? '擷取中...' : '擷取顏色'),
            ),
          ),
        ],
      ),
    );
  }

  /// 顏色資訊與歷史記錄區（下方操作區）— Bento 風格
  Widget _buildColorInfoArea(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasEntry = _selectedEntry != null;
    final hasHistory = _history.isNotEmpty;
    // totalItems: 色值顯示 + 歷史色板（各佔一個 stagger slot）
    final totalItems = (hasEntry ? 1 : 1) + (hasHistory ? 1 : 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── 色值顯示區段 ──
          StaggeredFadeIn(
            index: 0,
            totalItems: totalItems,
            child: ToolSectionCard(
              label: l10n.colorPickerTitle,
              child: _buildColorDisplay(),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // ── 歷史色板區段 ──
          StaggeredFadeIn(
            index: 1,
            totalItems: totalItems,
            child: ToolSectionCard(
              label: l10n.colorPickerHistory,
              child: _buildHistoryPalette(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDisplay() {
    final entry = _selectedEntry;

    if (entry == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: DT.spaceSm),
        child: Text(
          '點擊「擷取顏色」按鈕來擷取相機畫面中心的顏色',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: DT.fontToolLabel,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      );
    }

    return Row(
      children: [
        // Colour swatch
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: entry.color,
            borderRadius: BorderRadius.circular(DT.radiusSm),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: entry.color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: DT.spaceLg),
        // HEX & RGB values with copy buttons
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildValueRow('HEX', entry.hex),
              _buildValueRow('RGB', entry.rgb),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueRow(String label, String value) {
    return BouncingButton(
      onTap: () => _copyToClipboard(value, label),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DT.spaceXs,
          horizontal: DT.spaceSm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label  $value',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: DT.spaceSm),
            Icon(
              Icons.copy,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryPalette() {
    if (_history.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: DT.spaceSm),
        child: Center(
          child: Text(
            '尚無擷取記錄',
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: DT.fontToolLabel,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _history.length,
        separatorBuilder: (_, _) => const SizedBox(width: DT.spaceSm),
        itemBuilder: (context, index) {
          final entry = _history[index];
          final isSelected = entry == _selectedEntry;

          return BouncingButton(
            onTap: () => _selectHistoryEntry(entry),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: entry.color,
                borderRadius: BorderRadius.circular(DT.radiusSm),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: isSelected ? 3 : 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Paints a crosshair overlay on the camera preview.
class _CrosshairPainter extends CustomPainter {
  final Color color;

  _CrosshairPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.3;
    final lineLength = radius * 0.35;

    // Shadow then foreground for each element
    for (final p in [shadowPaint, paint]) {
      canvas.drawCircle(center, radius, p);
      canvas.drawCircle(center, innerRadius, p);

      // Top
      canvas.drawLine(
        Offset(center.dx, center.dy - innerRadius - 2),
        Offset(center.dx, center.dy - innerRadius - 2 - lineLength),
        p,
      );
      // Bottom
      canvas.drawLine(
        Offset(center.dx, center.dy + innerRadius + 2),
        Offset(center.dx, center.dy + innerRadius + 2 + lineLength),
        p,
      );
      // Left
      canvas.drawLine(
        Offset(center.dx - innerRadius - 2, center.dy),
        Offset(center.dx - innerRadius - 2 - lineLength, center.dy),
        p,
      );
      // Right
      canvas.drawLine(
        Offset(center.dx + innerRadius + 2, center.dy),
        Offset(center.dx + innerRadius + 2 + lineLength, center.dy),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter oldDelegate) =>
      color != oldDelegate.color;
}
