import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/screen_ruler/screen_ruler_logic.dart';

void main() {
  group('calculatePpi', () {
    test('credit card width (85.6 mm) at 250 px yields expected PPI', () {
      // (250 / 85.6) * 25.4 ≈ 74.18
      final ppi = calculatePpi(250, 85.6);
      expect(ppi, closeTo((250 / 85.6) * 25.4, 0.01));
    });

    test('standard high-PPI device (~460 PPI)', () {
      // If 85.6 mm maps to ~1550 px → PPI ≈ 459.93
      // (1550 / 85.6) * 25.4 ≈ 459.9299
      final ppi = calculatePpi(1550, 85.6);
      expect(ppi, closeTo((1550 / 85.6) * 25.4, 0.01));
    });

    test('1 inch reference (25.4 mm) at 100 px → PPI = 100', () {
      final ppi = calculatePpi(100, 25.4);
      expect(ppi, closeTo(100.0, 0.01));
    });
  });

  group('pixelsToCm', () {
    test('with PPI=100, 100 pixels → 2.54 cm', () {
      final cm = pixelsToCm(100, 100);
      expect(cm, closeTo(2.54, 0.01));
    });

    test('with PPI=200, 200 pixels → 2.54 cm', () {
      final cm = pixelsToCm(200, 200);
      expect(cm, closeTo(2.54, 0.01));
    });

    test('with PPI=100, 0 pixels → 0 cm', () {
      final cm = pixelsToCm(0, 100);
      expect(cm, closeTo(0.0, 0.01));
    });
  });

  group('pixelsToInches', () {
    test('with PPI=100, 100 pixels → 1.0 inch', () {
      final inches = pixelsToInches(100, 100);
      expect(inches, closeTo(1.0, 0.01));
    });

    test('with PPI=160, 320 pixels → 2.0 inches', () {
      final inches = pixelsToInches(320, 160);
      expect(inches, closeTo(2.0, 0.01));
    });

    test('with PPI=100, 0 pixels → 0 inches', () {
      final inches = pixelsToInches(0, 100);
      expect(inches, closeTo(0.0, 0.01));
    });
  });

  group('cmToPixels', () {
    test('with PPI=100, 2.54 cm → 100 pixels', () {
      final px = cmToPixels(2.54, 100);
      expect(px, closeTo(100.0, 0.01));
    });

    test('with PPI=200, 1.0 cm → ~78.74 pixels', () {
      // 1.0 / 2.54 * 200 ≈ 78.74
      final px = cmToPixels(1.0, 200);
      expect(px, closeTo(78.74, 0.01));
    });
  });

  group('round-trip conversions', () {
    test('cmToPixels(pixelsToCm(x, ppi), ppi) ≈ x', () {
      const ppi = 163.0;
      const originalPixels = 487.0;

      final cm = pixelsToCm(originalPixels, ppi);
      final backToPixels = cmToPixels(cm, ppi);

      expect(backToPixels, closeTo(originalPixels, 0.01));
    });

    test('round-trip with high PPI value', () {
      const ppi = 460.0;
      const originalPixels = 1234.56;

      final cm = pixelsToCm(originalPixels, ppi);
      final backToPixels = cmToPixels(cm, ppi);

      expect(backToPixels, closeTo(originalPixels, 0.01));
    });

    test('pixelsToInches and back via cmToPixels', () {
      const ppi = 120.0;
      const originalPixels = 360.0;

      final inches = pixelsToInches(originalPixels, ppi);
      final cm = inches * 2.54;
      final backToPixels = cmToPixels(cm, ppi);

      expect(backToPixels, closeTo(originalPixels, 0.01));
    });
  });
}
