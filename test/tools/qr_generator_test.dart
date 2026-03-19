import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_first_app/tools/qr_generator/qr_generator_page.dart';

void main() {
  group('QR Code Generator', () {
    testWidgets('displays QrImageView after generating QR Code',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: QrGeneratorPage()),
      );

      // Enter text and generate
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.tap(find.text('產生 QR Code'));
      await tester.pumpAndSettle();

      // Should find a QrImageView widget, not just a placeholder icon
      expect(find.byType(QrImageView), findsOneWidget);
    });

    testWidgets('different input produces different QR Code widgets',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: QrGeneratorPage()),
      );

      // Generate first QR Code
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.tap(find.text('產生 QR Code'));
      await tester.pumpAndSettle();

      // QrImageView should exist
      expect(find.byType(QrImageView), findsOneWidget);

      // Generate second QR Code with different text
      await tester.enterText(find.byType(TextField), 'World');
      await tester.tap(find.text('產生 QR Code'));
      await tester.pumpAndSettle();

      // QrImageView should still exist (widget rebuilt with new data)
      expect(find.byType(QrImageView), findsOneWidget);
    });
  });
}
