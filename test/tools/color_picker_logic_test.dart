import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/color_picker/color_picker_logic.dart';

void main() {
  // ---------------------------------------------------------------------------
  // to8bit
  // ---------------------------------------------------------------------------
  group('to8bit', () {
    test('converts 0.0 to 0', () {
      expect(to8bit(0.0), 0);
    });

    test('converts 1.0 to 255', () {
      expect(to8bit(1.0), 255);
    });

    test('converts 0.5 to 128', () {
      expect(to8bit(0.5), 128);
    });

    test('clamps values below 0.0', () {
      expect(to8bit(-0.1), 0);
    });

    test('clamps values above 1.0', () {
      expect(to8bit(1.1), 255);
    });
  });

  // ---------------------------------------------------------------------------
  // colorToHex
  // ---------------------------------------------------------------------------
  group('colorToHex', () {
    test('pure red returns #FF0000', () {
      expect(colorToHex(const Color.fromARGB(255, 255, 0, 0)), '#FF0000');
    });

    test('pure green returns #00FF00', () {
      expect(colorToHex(const Color.fromARGB(255, 0, 255, 0)), '#00FF00');
    });

    test('pure blue returns #0000FF', () {
      expect(colorToHex(const Color.fromARGB(255, 0, 0, 255)), '#0000FF');
    });

    test('white returns #FFFFFF', () {
      expect(colorToHex(const Color.fromARGB(255, 255, 255, 255)), '#FFFFFF');
    });

    test('black returns #000000', () {
      expect(colorToHex(const Color.fromARGB(255, 0, 0, 0)), '#000000');
    });

    test('arbitrary color #FF5733', () {
      expect(
        colorToHex(const Color.fromARGB(255, 255, 87, 51)),
        '#FF5733',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // colorToRgbString
  // ---------------------------------------------------------------------------
  group('colorToRgbString', () {
    test('pure red returns "255, 0, 0"', () {
      expect(
        colorToRgbString(const Color.fromARGB(255, 255, 0, 0)),
        '255, 0, 0',
      );
    });

    test('arbitrary color returns correct string', () {
      expect(
        colorToRgbString(const Color.fromARGB(255, 128, 64, 32)),
        '128, 64, 32',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // hexToColor
  // ---------------------------------------------------------------------------
  group('hexToColor', () {
    test('parses #FF5733 to correct Color', () {
      final color = hexToColor('#FF5733');
      expect(color, isNotNull);
      expect(to8bit(color!.r), 255);
      expect(to8bit(color.g), 87);
      expect(to8bit(color.b), 51);
    });

    test('parses without # prefix', () {
      final color = hexToColor('00FF00');
      expect(color, isNotNull);
      expect(to8bit(color!.r), 0);
      expect(to8bit(color.g), 255);
      expect(to8bit(color.b), 0);
    });

    test('returns null for invalid hex string', () {
      expect(hexToColor('ZZZZZZ'), isNull);
    });

    test('returns null for wrong length', () {
      expect(hexToColor('#FFF'), isNull);
    });

    test('returns null for empty string', () {
      expect(hexToColor(''), isNull);
    });

    test('handles lowercase hex', () {
      final color = hexToColor('#ff5733');
      expect(color, isNotNull);
      expect(to8bit(color!.r), 255);
      expect(to8bit(color.g), 87);
      expect(to8bit(color.b), 51);
    });
  });

  // ---------------------------------------------------------------------------
  // rgbToHsl
  // ---------------------------------------------------------------------------
  group('rgbToHsl', () {
    test('pure red → h=0, s=1, l=0.5', () {
      final hsl = rgbToHsl(255, 0, 0);
      expect(hsl['h'], closeTo(0, 0.5));
      expect(hsl['s'], closeTo(1.0, 0.01));
      expect(hsl['l'], closeTo(0.5, 0.01));
    });

    test('pure white → h=0, s=0, l=1', () {
      final hsl = rgbToHsl(255, 255, 255);
      expect(hsl['h'], closeTo(0, 0.5));
      expect(hsl['s'], closeTo(0.0, 0.01));
      expect(hsl['l'], closeTo(1.0, 0.01));
    });

    test('pure black → h=0, s=0, l=0', () {
      final hsl = rgbToHsl(0, 0, 0);
      expect(hsl['h'], closeTo(0, 0.5));
      expect(hsl['s'], closeTo(0.0, 0.01));
      expect(hsl['l'], closeTo(0.0, 0.01));
    });

    test('pure green → h=120, s=1, l=0.5', () {
      final hsl = rgbToHsl(0, 255, 0);
      expect(hsl['h'], closeTo(120, 0.5));
      expect(hsl['s'], closeTo(1.0, 0.01));
      expect(hsl['l'], closeTo(0.5, 0.01));
    });

    test('pure blue → h=240, s=1, l=0.5', () {
      final hsl = rgbToHsl(0, 0, 255);
      expect(hsl['h'], closeTo(240, 0.5));
      expect(hsl['s'], closeTo(1.0, 0.01));
      expect(hsl['l'], closeTo(0.5, 0.01));
    });
  });

  // ---------------------------------------------------------------------------
  // hslToColor
  // ---------------------------------------------------------------------------
  group('hslToColor', () {
    test('h=0, s=1, l=0.5 → pure red', () {
      final color = hslToColor(0, 1.0, 0.5);
      expect(to8bit(color.r), 255);
      expect(to8bit(color.g), 0);
      expect(to8bit(color.b), 0);
    });

    test('h=0, s=0, l=1 → white', () {
      final color = hslToColor(0, 0.0, 1.0);
      expect(to8bit(color.r), 255);
      expect(to8bit(color.g), 255);
      expect(to8bit(color.b), 255);
    });

    test('h=0, s=0, l=0 → black', () {
      final color = hslToColor(0, 0.0, 0.0);
      expect(to8bit(color.r), 0);
      expect(to8bit(color.g), 0);
      expect(to8bit(color.b), 0);
    });
  });

  // ---------------------------------------------------------------------------
  // RGB → HSL → RGB round-trip
  // ---------------------------------------------------------------------------
  group('RGB → HSL → RGB round-trip', () {
    void roundTripTest(String label, int r, int g, int b) {
      test(label, () {
        final hsl = rgbToHsl(r, g, b);
        final result = hslToColor(hsl['h']!, hsl['s']!, hsl['l']!);

        final rResult = to8bit(result.r);
        final gResult = to8bit(result.g);
        final bResult = to8bit(result.b);

        expect(rResult, closeTo(r, 1), reason: 'Red channel mismatch');
        expect(gResult, closeTo(g, 1), reason: 'Green channel mismatch');
        expect(bResult, closeTo(b, 1), reason: 'Blue channel mismatch');
      });
    }

    roundTripTest('pure red (255, 0, 0)', 255, 0, 0);
    roundTripTest('pure green (0, 255, 0)', 0, 255, 0);
    roundTripTest('pure blue (0, 0, 255)', 0, 0, 255);
    roundTripTest('white (255, 255, 255)', 255, 255, 255);
    roundTripTest('black (0, 0, 0)', 0, 0, 0);
    roundTripTest('arbitrary (128, 64, 32)', 128, 64, 32);
    roundTripTest('arbitrary (255, 87, 51)', 255, 87, 51);
    roundTripTest('grey (128, 128, 128)', 128, 128, 128);
    roundTripTest('cyan (0, 255, 255)', 0, 255, 255);
    roundTripTest('magenta (255, 0, 255)', 255, 0, 255);
    roundTripTest('yellow (255, 255, 0)', 255, 255, 0);
  });
}
