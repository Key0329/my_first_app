import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/level/level_logic.dart';

void main() {
  group('accelToAngle', () {
    test('0 accel returns 0 degrees', () {
      expect(accelToAngle(0), 0.0);
    });

    test('9.81 (full g) returns 90 degrees', () {
      expect(accelToAngle(9.81), closeTo(90.0, 1e-9));
    });

    test('-9.81 (negative full g) returns -90 degrees', () {
      expect(accelToAngle(-9.81), closeTo(-90.0, 1e-9));
    });

    test('value beyond +g is clamped to 90 degrees', () {
      expect(accelToAngle(20.0), closeTo(90.0, 1e-9));
    });

    test('value beyond -g is clamped to -90 degrees', () {
      expect(accelToAngle(-20.0), closeTo(-90.0, 1e-9));
    });

    test('custom g parameter is respected', () {
      // With g = 1.0, accelValue of 1.0 should give 90 degrees.
      expect(accelToAngle(1.0, g: 1.0), closeTo(90.0, 1e-9));
    });
  });

  group('isLevel', () {
    test('(0.0, 0.0) returns true', () {
      expect(isLevel(0.0, 0.0), isTrue);
    });

    test('(0.4, 0.4) returns true (within default 0.5 tolerance)', () {
      expect(isLevel(0.4, 0.4), isTrue);
    });

    test('(0.6, 0.0) returns false (angleX exceeds tolerance)', () {
      expect(isLevel(0.6, 0.0), isFalse);
    });

    test('(0.0, 0.6) returns false (angleY exceeds tolerance)', () {
      expect(isLevel(0.0, 0.6), isFalse);
    });

    test('(-0.3, 0.3) returns true (negative values within tolerance)', () {
      expect(isLevel(-0.3, 0.3), isTrue);
    });

    test('custom tolerance: (1.0, 1.0) with tolerance 1.5 returns true', () {
      expect(isLevel(1.0, 1.0, tolerance: 1.5), isTrue);
    });

    test('custom tolerance: (1.0, 1.0) with tolerance 0.5 returns false', () {
      expect(isLevel(1.0, 1.0, tolerance: 0.5), isFalse);
    });

    test('exactly at tolerance boundary returns false (uses strict <)', () {
      expect(isLevel(0.5, 0.0), isFalse);
      expect(isLevel(0.0, 0.5), isFalse);
    });
  });
}
