import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/flashlight/flashlight_logic.dart';

void main() {
  group('SOS Pattern 結構', () {
    test('SOS pattern 共有 9 個步驟', () {
      expect(sosPattern.length, 9);
    });

    test('前 3 步為 dot（S）', () {
      for (final step in sosPattern.sublist(0, 3)) {
        expect(isDot(step), isTrue, reason: 'onMs=${step.onMs} 應為 dot');
        expect(isDash(step), isFalse);
      }
    });

    test('中間 3 步為 dash（O）', () {
      for (final step in sosPattern.sublist(3, 6)) {
        expect(isDash(step), isTrue, reason: 'onMs=${step.onMs} 應為 dash');
        expect(isDot(step), isFalse);
      }
    });

    test('最後 3 步為 dot（S）', () {
      for (final step in sosPattern.sublist(6, 9)) {
        expect(isDot(step), isTrue, reason: 'onMs=${step.onMs} 應為 dot');
        expect(isDash(step), isFalse);
      }
    });
  });

  group('SOS 時長計算', () {
    test('dot 時長（200ms）短於 dash 時長（600ms）', () {
      final dot = sosPattern.first; // 第一個 dot
      final dash = sosPattern[3]; // 第一個 dash
      expect(dot.onMs, lessThan(dash.onMs));
      expect(dot.onMs, 200);
      expect(dash.onMs, 600);
    });

    test('完整 SOS 週期總時長為 6800ms', () {
      // S: (200+200)+(200+200)+(200+600) = 1600
      // O: (600+200)+(600+200)+(600+600) = 2800
      // S: (200+200)+(200+200)+(200+1400) = 2400
      // Total = 6800
      expect(sosPatternTotalDurationMs(), 6800);
    });
  });

  group('isDot / isDash 判斷', () {
    test('isDot 對 onMs=200 回傳 true', () {
      expect(isDot(const SosStep(onMs: 200, offMs: 200)), isTrue);
    });

    test('isDot 對 onMs=100 回傳 true（邊界：<= 200）', () {
      expect(isDot(const SosStep(onMs: 100, offMs: 200)), isTrue);
    });

    test('isDot 對 onMs=600 回傳 false', () {
      expect(isDot(const SosStep(onMs: 600, offMs: 200)), isFalse);
    });

    test('isDash 對 onMs=600 回傳 true', () {
      expect(isDash(const SosStep(onMs: 600, offMs: 200)), isTrue);
    });

    test('isDash 對 onMs=201 回傳 true（邊界：> 200）', () {
      expect(isDash(const SosStep(onMs: 201, offMs: 200)), isTrue);
    });

    test('isDash 對 onMs=200 回傳 false', () {
      expect(isDash(const SosStep(onMs: 200, offMs: 200)), isFalse);
    });

    test('isDot 和 isDash 互斥（不會同時為 true）', () {
      for (final step in sosPattern) {
        expect(
          isDot(step) != isDash(step),
          isTrue,
          reason: 'onMs=${step.onMs} 應只滿足 isDot 或 isDash 其一',
        );
      }
    });
  });
}
