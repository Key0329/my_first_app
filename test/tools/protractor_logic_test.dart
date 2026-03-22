import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/protractor/protractor_logic.dart';

void main() {
  group('calculateAngleDegrees', () {
    test('arm1=0, arm2=pi/3 → 60 degrees', () {
      final result = calculateAngleDegrees(0, math.pi / 3);
      expect(result, closeTo(60.0, 0.1));
    });

    test('arm1=pi/3, arm2=0 → 300 degrees (reverse)', () {
      final result = calculateAngleDegrees(math.pi / 3, 0);
      expect(result, closeTo(300.0, 0.1));
    });

    test('arm1=0, arm2=pi/2 → 90 degrees', () {
      final result = calculateAngleDegrees(0, math.pi / 2);
      expect(result, closeTo(90.0, 0.1));
    });

    test('arm1=0, arm2=pi → 180 degrees', () {
      final result = calculateAngleDegrees(0, math.pi);
      expect(result, closeTo(180.0, 0.1));
    });

    test('arm1=0, arm2=3*pi/2 → 270 degrees', () {
      final result = calculateAngleDegrees(0, 3 * math.pi / 2);
      expect(result, closeTo(270.0, 0.1));
    });

    test('same angle → 0 degrees', () {
      final result = calculateAngleDegrees(1.0, 1.0);
      expect(result, closeTo(0.0, 0.1));
    });

    test('negative arm angles', () {
      final result = calculateAngleDegrees(-math.pi / 4, math.pi / 4);
      expect(result, closeTo(90.0, 0.1));
    });

    test('both arms negative', () {
      final result = calculateAngleDegrees(-math.pi / 2, -math.pi / 4);
      expect(result, closeTo(45.0, 0.1));
    });

    test('full rotation close to 360 wraps to near 0', () {
      final result = calculateAngleDegrees(0, 2 * math.pi);
      expect(result, closeTo(0.0, 0.1));
    });
  });

  group('normalizeAngle', () {
    test('-45 → 315', () {
      expect(normalizeAngle(-45), closeTo(315.0, 0.1));
    });

    test('-90 → 270', () {
      expect(normalizeAngle(-90), closeTo(270.0, 0.1));
    });

    test('720 → 0', () {
      expect(normalizeAngle(720), closeTo(0.0, 0.1));
    });

    test('361 → 1', () {
      expect(normalizeAngle(361), closeTo(1.0, 0.1));
    });

    test('0 → 0', () {
      expect(normalizeAngle(0), closeTo(0.0, 0.1));
    });

    test('359.9 stays as is', () {
      expect(normalizeAngle(359.9), closeTo(359.9, 0.1));
    });

    test('-180 → 180', () {
      expect(normalizeAngle(-180), closeTo(180.0, 0.1));
    });

    test('-360 → 0', () {
      expect(normalizeAngle(-360), closeTo(0.0, 0.1));
    });

    test('180 → 180', () {
      expect(normalizeAngle(180), closeTo(180.0, 0.1));
    });

    test('1080 (3 full rotations) → 0', () {
      expect(normalizeAngle(1080), closeTo(0.0, 0.1));
    });
  });

  group('angleBetweenPoints', () {
    test('point on positive X-axis and positive Y-axis → 90 degrees', () {
      // Point 1 at (1,0), Point 2 at (0,1), center at (0,0)
      final result = angleBetweenPoints(1, 0, 0, 1, 0, 0);
      expect(result, closeTo(90.0, 0.1));
    });

    test('point on positive Y-axis and positive X-axis → 270 degrees', () {
      // Point 1 at (0,1), Point 2 at (1,0), center at (0,0)
      final result = angleBetweenPoints(0, 1, 1, 0, 0, 0);
      expect(result, closeTo(270.0, 0.1));
    });

    test('opposite points through center → 180 degrees', () {
      // Point 1 at (1,0), Point 2 at (-1,0), center at (0,0)
      final result = angleBetweenPoints(1, 0, -1, 0, 0, 0);
      expect(result, closeTo(180.0, 0.1));
    });

    test('same point → 0 degrees', () {
      final result = angleBetweenPoints(1, 0, 1, 0, 0, 0);
      expect(result, closeTo(0.0, 0.1));
    });

    test('45-degree angle', () {
      // Point 1 at (1,0), Point 2 at (1,1), center at (0,0)
      final result = angleBetweenPoints(1, 0, 1, 1, 0, 0);
      expect(result, closeTo(45.0, 0.1));
    });

    test('with non-origin center point', () {
      // Center at (5,5), Point 1 at (10,5) → pointing right
      // Point 2 at (5,10) → pointing up
      final result = angleBetweenPoints(10, 5, 5, 10, 5, 5);
      expect(result, closeTo(90.0, 0.1));
    });

    test('equilateral triangle configuration → 60 degrees', () {
      // Center at origin, point1 at (1,0), point2 at (cos(60), sin(60))
      final x2 = math.cos(math.pi / 3); // 0.5
      final y2 = math.sin(math.pi / 3); // ~0.866
      final result = angleBetweenPoints(1, 0, x2, y2, 0, 0);
      expect(result, closeTo(60.0, 0.1));
    });

    test('270-degree sweep', () {
      // Point 1 at (0,1), Point 2 at (1,0) relative to center
      // From 90 degrees to 0 degrees → sweep of 270 going counter-clockwise
      // But calculateAngleDegrees computes (arm2 - arm1), so:
      // angle1 = atan2(1, 0) = pi/2, angle2 = atan2(0, 1) = 0
      // diff = (0 - pi/2) * 180/pi = -90 → normalized to 270
      final result = angleBetweenPoints(0, 1, 1, 0, 0, 0);
      expect(result, closeTo(270.0, 0.1));
    });
  });
}
