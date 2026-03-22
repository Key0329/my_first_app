import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/noise_meter/noise_meter_logic.dart';

void main() {
  // ---------------------------------------------------------------------------
  // getDbColor
  // ---------------------------------------------------------------------------
  group('getDbColor', () {
    test('db < 45 → 綠色 (0xFF4CAF50)', () {
      expect(getDbColor(0), const Color(0xFF4CAF50));
      expect(getDbColor(20), const Color(0xFF4CAF50));
      expect(getDbColor(44.9), const Color(0xFF4CAF50));
    });

    test('45 <= db < 70 → 黃色 (0xFFFFC107)', () {
      expect(getDbColor(45), const Color(0xFFFFC107));
      expect(getDbColor(55), const Color(0xFFFFC107));
      expect(getDbColor(69.9), const Color(0xFFFFC107));
    });

    test('70 <= db < 90 → 橘色 (0xFFFF9800)', () {
      expect(getDbColor(70), const Color(0xFFFF9800));
      expect(getDbColor(80), const Color(0xFFFF9800));
      expect(getDbColor(89.9), const Color(0xFFFF9800));
    });

    test('db >= 90 → 紅色 (0xFFF44336)', () {
      expect(getDbColor(90), const Color(0xFFF44336));
      expect(getDbColor(100), const Color(0xFFF44336));
      expect(getDbColor(130), const Color(0xFFF44336));
    });

    group('boundary values', () {
      test('exactly 45 → 黃色', () {
        expect(getDbColor(45), const Color(0xFFFFC107));
      });

      test('exactly 70 → 橘色', () {
        expect(getDbColor(70), const Color(0xFFFF9800));
      });

      test('exactly 90 → 紅色', () {
        expect(getDbColor(90), const Color(0xFFF44336));
      });
    });
  });

  // ---------------------------------------------------------------------------
  // classifyDbLevel
  // ---------------------------------------------------------------------------
  group('classifyDbLevel', () {
    test('db < 30 → quiet', () {
      expect(classifyDbLevel(0), 'quiet');
      expect(classifyDbLevel(20), 'quiet');
      expect(classifyDbLevel(29.9), 'quiet');
    });

    test('30 <= db < 60 → moderate', () {
      expect(classifyDbLevel(30), 'moderate');
      expect(classifyDbLevel(50), 'moderate');
      expect(classifyDbLevel(59.9), 'moderate');
    });

    test('60 <= db < 85 → loud', () {
      expect(classifyDbLevel(60), 'loud');
      expect(classifyDbLevel(75), 'loud');
      expect(classifyDbLevel(84.9), 'loud');
    });

    test('db >= 85 → dangerous', () {
      expect(classifyDbLevel(85), 'dangerous');
      expect(classifyDbLevel(100), 'dangerous');
      expect(classifyDbLevel(130), 'dangerous');
    });

    group('boundary values', () {
      test('exactly 30 → moderate', () {
        expect(classifyDbLevel(30), 'moderate');
      });

      test('exactly 60 → loud', () {
        expect(classifyDbLevel(60), 'loud');
      });

      test('exactly 85 → dangerous', () {
        expect(classifyDbLevel(85), 'dangerous');
      });
    });
  });

  // ---------------------------------------------------------------------------
  // getActiveReferenceIndex
  // ---------------------------------------------------------------------------
  group('getActiveReferenceIndex', () {
    test('db < 30 → -1', () {
      expect(getActiveReferenceIndex(0), -1);
      expect(getActiveReferenceIndex(25), -1);
      expect(getActiveReferenceIndex(29.9), -1);
    });

    test('30 <= db < 60 → 0 (耳語)', () {
      expect(getActiveReferenceIndex(30), 0);
      expect(getActiveReferenceIndex(45), 0);
      expect(getActiveReferenceIndex(59.9), 0);
    });

    test('60 <= db < 80 → 1 (對話)', () {
      expect(getActiveReferenceIndex(60), 1);
      expect(getActiveReferenceIndex(65), 1);
      expect(getActiveReferenceIndex(79.9), 1);
    });

    test('80 <= db < 110 → 2 (交通)', () {
      expect(getActiveReferenceIndex(80), 2);
      expect(getActiveReferenceIndex(85), 2);
      expect(getActiveReferenceIndex(109.9), 2);
    });

    test('db >= 110 → 3 (演唱會)', () {
      expect(getActiveReferenceIndex(110), 3);
      expect(getActiveReferenceIndex(115), 3);
      expect(getActiveReferenceIndex(130), 3);
    });

    group('boundary values', () {
      test('exactly 30 → 0', () {
        expect(getActiveReferenceIndex(30), 0);
      });

      test('exactly 60 → 1', () {
        expect(getActiveReferenceIndex(60), 1);
      });

      test('exactly 80 → 2', () {
        expect(getActiveReferenceIndex(80), 2);
      });

      test('exactly 110 → 3', () {
        expect(getActiveReferenceIndex(110), 3);
      });
    });
  });
}
