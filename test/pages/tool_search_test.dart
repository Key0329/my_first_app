import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/tool_search_delegate.dart';

void main() {
  group('filterTools', () {
    test('empty query returns all tools', () {
      final results = filterTools('');
      expect(results.length, greaterThan(0));
      // Should return same count as allTools
      expect(results.length, equals(allTools.length));
    });

    test('matches Chinese tool name and category', () {
      final results = filterTools('計算');
      // '計算' matches tool names (計算機, BMI 計算機, 日期計算機) and the 計算 category
      // (which also includes 單位換算, AA 制分帳, 匯率換算)
      expect(results.length, equals(6));
      expect(
        results.map((t) => t.fallbackName),
        containsAll(['計算機', 'BMI 計算機', '日期計算機', '單位換算', 'AA 制分帳', '匯率換算']),
      );
    });

    test('matches single tool by exact name', () {
      final results = filterTools('水平儀');
      expect(results.length, equals(1));
      expect(results.first.id, equals('level'));
    });

    test('matches by category name', () {
      final results = filterTools('測量');
      // ToolCategory.measure has label '測量'
      // level, compass, protractor, screen_ruler, noise_meter = 5 tools
      expect(results.length, equals(5));
    });

    test('matches by route path segment', () {
      final results = filterTools('calculator');
      // /tools/calculator, /tools/bmi-calculator, /tools/date-calculator
      expect(results.length, equals(3));
    });

    test('search is case insensitive', () {
      final results = filterTools('BMI');
      expect(results.length, equals(1));
      expect(results.first.id, equals('bmi_calculator'));
    });

    test('no matching tools returns empty list', () {
      final results = filterTools('zzz_nonexistent');
      expect(results, isEmpty);
    });

    test('partial match works', () {
      final results = filterTools('密碼');
      expect(results.length, equals(1));
      expect(results.first.id, equals('password_generator'));
    });
  });
}
