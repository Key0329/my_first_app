import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/qr_scanner_live/qr_scanner_live_page.dart';

void main() {
  group('QR Scanner Live - Result Type Detection', () {
    test('detectResultType returns url for http URLs', () {
      expect(QrScanResultType.detect('https://example.com'), QrScanResultType.url);
      expect(QrScanResultType.detect('http://example.com'), QrScanResultType.url);
      expect(QrScanResultType.detect('HTTP://EXAMPLE.COM'), QrScanResultType.url);
      expect(QrScanResultType.detect('https://example.com/path?q=1'), QrScanResultType.url);
    });

    test('detectResultType returns text for plain text', () {
      expect(QrScanResultType.detect('Hello World'), QrScanResultType.text);
      expect(QrScanResultType.detect('12345'), QrScanResultType.text);
      expect(QrScanResultType.detect('some random text'), QrScanResultType.text);
    });

    test('detectResultType returns text for empty string', () {
      expect(QrScanResultType.detect(''), QrScanResultType.text);
    });

    test('detectResultType returns url for ftp URLs', () {
      expect(QrScanResultType.detect('ftp://files.example.com'), QrScanResultType.url);
    });
  });

  group('QR Scanner Live - Widget Tests', () {
    // Note: MobileScanner requires camera platform, so we test the
    // non-camera parts — result display, action buttons, permission denied UI.

    testWidgets('QrScannerLivePage can be instantiated', (tester) async {
      // On non-mobile platforms, it should show PlatformUnsupportedView.
      // We just verify it doesn't crash.
      await tester.pumpWidget(
        const MaterialApp(home: QrScannerLivePage()),
      );
      await tester.pump();

      // On desktop/test, should show the PlatformUnsupportedView fallback
      expect(find.byType(QrScannerLivePage), findsOneWidget);
    });

    testWidgets('QrScanResultSheet displays URL result with action buttons',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrScanResultSheet(
              result: 'https://example.com',
              resultType: QrScanResultType.url,
              onCopy: () {},
              onRescan: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should display the scanned text
      expect(find.text('https://example.com'), findsOneWidget);

      // Should show "URL" type label
      expect(find.text('URL'), findsOneWidget);

      // Should have copy button
      expect(find.byIcon(Icons.copy), findsOneWidget);

      // Should have rescan button
      expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
    });

    testWidgets('QrScanResultSheet displays plain text result',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrScanResultSheet(
              result: 'Hello World',
              resultType: QrScanResultType.text,
              onCopy: () {},
              onRescan: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('QrScanResultSheet copy button triggers callback',
        (tester) async {
      bool copied = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrScanResultSheet(
              result: 'test text',
              resultType: QrScanResultType.text,
              onCopy: () => copied = true,
              onRescan: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.copy));
      await tester.pump();

      expect(copied, isTrue);
    });

    testWidgets('QrScanResultSheet rescan button triggers callback',
        (tester) async {
      bool rescanned = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrScanResultSheet(
              result: 'test text',
              resultType: QrScanResultType.text,
              onCopy: () {},
              onRescan: () => rescanned = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.qr_code_scanner));
      await tester.pump();

      expect(rescanned, isTrue);
    });

    testWidgets('CameraPermissionDeniedView shows guidance', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraPermissionDeniedView(
              onRetry: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should show camera off icon
      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);

      // Should have a retry button
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('CameraPermissionDeniedView retry triggers callback',
        (tester) async {
      bool retried = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraPermissionDeniedView(
              onRetry: () => retried = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      expect(retried, isTrue);
    });

    testWidgets('ScanFrameOverlay renders without error', (tester) async {
      final painter = ScanFrameOverlayPainter(
        frameColor: Colors.teal,
        animationValue: 0.5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: painter,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify the painter was used — find the CustomPaint with our painter
      final customPaintFinder = find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter == painter,
      );
      expect(customPaintFinder, findsOneWidget);
    });

    test('ScanFrameOverlayPainter shouldRepaint returns true on change', () {
      final painter1 = ScanFrameOverlayPainter(
        frameColor: Colors.teal,
        animationValue: 0.0,
      );
      final painter2 = ScanFrameOverlayPainter(
        frameColor: Colors.teal,
        animationValue: 0.5,
      );
      final painter3 = ScanFrameOverlayPainter(
        frameColor: Colors.teal,
        animationValue: 0.0,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
      expect(painter1.shouldRepaint(painter3), isFalse);
    });
  });
}
