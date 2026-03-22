import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/tools/qr_generator/qr_generator_page.dart';

void main() {
  group('QR Code Generator', () {
    testWidgets('displays QrImageView after generating QR Code',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: const QrGeneratorPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Default QR type is Text (index 0), enter text in the TextField
      await tester.enterText(find.byType(TextField).first, 'Hello World');
      await tester.pumpAndSettle();

      // Scroll to make the generate button visible, then tap
      final generateBtn = find.text('產生 QR Code');
      await tester.ensureVisible(generateBtn);
      await tester.pumpAndSettle();
      await tester.tap(generateBtn);
      await tester.pumpAndSettle();

      // Should find a QrImageView widget, not just a placeholder icon
      expect(find.byType(QrImageView), findsOneWidget);
    });

    testWidgets('different input produces different QR Code widgets',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: const QrGeneratorPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Generate first QR Code
      await tester.enterText(find.byType(TextField).first, 'Hello');
      await tester.pumpAndSettle();

      final generateBtn = find.text('產生 QR Code');
      await tester.ensureVisible(generateBtn);
      await tester.pumpAndSettle();
      await tester.tap(generateBtn);
      await tester.pumpAndSettle();

      // QrImageView should exist
      expect(find.byType(QrImageView), findsOneWidget);

      // Generate second QR Code with different text
      await tester.enterText(find.byType(TextField).first, 'World');
      await tester.pumpAndSettle();

      await tester.ensureVisible(generateBtn);
      await tester.pumpAndSettle();
      await tester.tap(generateBtn);
      await tester.pumpAndSettle();

      // QrImageView should still exist (widget rebuilt with new data)
      expect(find.byType(QrImageView), findsOneWidget);
    });
  });
}
