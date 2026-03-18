import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      formats: const [], // We don't need barcode detection
    );

    _controller = controller;

    try {
      await controller.start();
      if (mounted) {
        setState(() {
          _controllerInitialized = true;
          _hasPermission = true;
        });
      }
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
    _controller?.dispose();
    super.dispose();
  }

  /// Captures a frame from the camera and picks the center-pixel color.
  ///
  /// Strategy: stop the current (barcode-less) controller, create a temporary
  /// one with `returnImage: true` so the barcode-capture stream delivers raw
  /// image bytes, grab the first frame, decode it with `dart:ui`, read the
  /// center pixel, then restart the original controller.
  Future<void> _captureColor() async {
    if (_isCapturing || _controller == null) return;
    setState(() => _isCapturing = true);

    try {
      final color = await _pickColorFromCamera();
      if (color != null && mounted) {
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

  Future<Color?> _pickColorFromCamera() async {
    final controller = _controller;
    if (controller == null) return null;

    final completer = Completer<Color?>();

    try {
      // Stop current preview so we can start a capture controller.
      await controller.stop();

      final imgController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        formats: const [],
        returnImage: true,
      );

      Timer? timeout;
      StreamSubscription<BarcodeCapture>? subscription;

      timeout = Timer(const Duration(seconds: 3), () {
        subscription?.cancel();
        imgController.stop().then((_) => imgController.dispose());
        controller.start(); // Restart original preview
        if (!completer.isCompleted) completer.complete(null);
      });

      subscription = imgController.barcodes.listen((capture) async {
        final imageBytes = capture.image;
        if (imageBytes != null && !completer.isCompleted) {
          timeout?.cancel();
          await subscription?.cancel();
          await imgController.stop();
          imgController.dispose();

          final color = await _decodeCenterPixel(imageBytes);

          await controller.start(); // Restart original preview
          completer.complete(color);
        }
      });

      await imgController.start();
    } catch (_) {
      try {
        await controller.start();
      } catch (_) {}
      if (!completer.isCompleted) completer.complete(null);
    }

    return completer.future;
  }

  /// Decodes JPEG/PNG image bytes and returns the colour of the centre pixel.
  Future<Color?> _decodeCenterPixel(Uint8List imageBytes) async {
    try {
      final codec = await ui.instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final centerX = image.width ~/ 2;
      final centerY = image.height ~/ 2;

      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );

      if (byteData == null) return null;

      final pixelIndex = (centerY * image.width + centerX) * 4;
      if (pixelIndex + 3 >= byteData.lengthInBytes) return null;

      final r = byteData.getUint8(pixelIndex);
      final g = byteData.getUint8(pixelIndex + 1);
      final b = byteData.getUint8(pixelIndex + 2);

      image.dispose();
      codec.dispose();

      return Color.fromARGB(255, r, g, b);
    } catch (_) {
      return null;
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('需要相機權限'),
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
    return Scaffold(
      appBar: AppBar(title: const Text('色彩擷取')),
      body: _hasPermission ? _buildMainContent() : _buildPermissionDenied(),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            const Text(
              '需要相機權限',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '色彩擷取需要使用相機來偵測顏色。\n請在系統設定中允許相機存取。',
              textAlign: TextAlign.center,
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

  Widget _buildMainContent() {
    return Column(
      children: [
        // Camera preview with crosshair
        Expanded(flex: 3, child: _buildCameraPreview()),
        // Picked-colour display & copy actions
        _buildColorDisplay(),
        // History palette
        Expanded(flex: 1, child: _buildHistoryPalette()),
      ],
    );
  }

  Widget _buildCameraPreview() {
    if (!_controllerInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRect(
          child: MobileScanner(
            controller: _controller!,
            fit: BoxFit.cover,
            onDetect: (_) {},
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
    );
  }

  Widget _buildColorDisplay() {
    final entry = _selectedEntry;

    if (entry == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: const Text(
          '點擊「擷取顏色」按鈕來擷取相機畫面中心的顏色',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // Colour swatch
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: entry.color,
              borderRadius: BorderRadius.circular(12),
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
          const SizedBox(width: 16),
          // HEX & RGB values
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
      ),
    );
  }

  Widget _buildValueRow(String label, String value) {
    return InkWell(
      onTap: () => _copyToClipboard(value, label),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
            const SizedBox(width: 8),
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
      return Center(
        child: Text(
          '尚無擷取記錄',
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 14,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            '歷史記錄',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _history.length,
            itemBuilder: (context, index) {
              final entry = _history[index];
              final isSelected = entry == _selectedEntry;

              return GestureDetector(
                onTap: () => _selectHistoryEntry(entry),
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: entry.color,
                    borderRadius: BorderRadius.circular(10),
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
        ),
      ],
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
