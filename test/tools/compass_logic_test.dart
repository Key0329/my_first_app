import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/compass/compass_logic.dart';

void main() {
  group('degreeToDirection', () {
    group('cardinal directions', () {
      test('0° → N', () {
        expect(degreeToDirection(0), 'N');
      });

      test('90° → E', () {
        expect(degreeToDirection(90), 'E');
      });

      test('180° → S', () {
        expect(degreeToDirection(180), 'S');
      });

      test('270° → W', () {
        expect(degreeToDirection(270), 'W');
      });
    });

    group('intercardinal directions', () {
      test('45° → NE', () {
        expect(degreeToDirection(45), 'NE');
      });

      test('135° → SE', () {
        expect(degreeToDirection(135), 'SE');
      });

      test('225° → SW', () {
        expect(degreeToDirection(225), 'SW');
      });

      test('315° → NW', () {
        expect(degreeToDirection(315), 'NW');
      });
    });

    group('boundary values near transitions', () {
      test('22.4° → N (just before NE boundary)', () {
        expect(degreeToDirection(22.4), 'N');
      });

      test('22.5° → NE (exactly at NE boundary)', () {
        expect(degreeToDirection(22.5), 'NE');
      });

      test('67.4° → NE (just before E boundary)', () {
        expect(degreeToDirection(67.4), 'NE');
      });

      test('67.5° → E (exactly at E boundary)', () {
        expect(degreeToDirection(67.5), 'E');
      });

      test('337.4° → NW (just before N boundary wraps)', () {
        expect(degreeToDirection(337.4), 'NW');
      });

      test('337.5° → N (wraps back to N)', () {
        expect(degreeToDirection(337.5), 'N');
      });
    });

    group('normalization', () {
      test('360° → N (full rotation)', () {
        expect(degreeToDirection(360), 'N');
      });

      test('450° → E (360 + 90)', () {
        expect(degreeToDirection(450), 'E');
      });

      test('720° → N (two full rotations)', () {
        expect(degreeToDirection(720), 'N');
      });

      test('-90° → W (negative angle)', () {
        expect(degreeToDirection(-90), 'W');
      });

      test('-180° → S (negative angle)', () {
        expect(degreeToDirection(-180), 'S');
      });

      test('-45° → NW (negative angle)', () {
        expect(degreeToDirection(-45), 'NW');
      });
    });
  });

  group('degreeToDirectionChinese', () {
    test('0° → 北', () {
      expect(degreeToDirectionChinese(0), '北');
    });

    test('90° → 東', () {
      expect(degreeToDirectionChinese(90), '東');
    });

    test('180° → 南', () {
      expect(degreeToDirectionChinese(180), '南');
    });

    test('270° → 西', () {
      expect(degreeToDirectionChinese(270), '西');
    });

    test('45° → 東北', () {
      expect(degreeToDirectionChinese(45), '東北');
    });

    test('-90° → 西 (negative angle)', () {
      expect(degreeToDirectionChinese(-90), '西');
    });
  });
}
