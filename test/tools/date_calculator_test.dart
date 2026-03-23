import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/date_calculator/date_calculator_logic.dart';

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // DateInterval（日期區間計算）
  // ─────────────────────────────────────────────────────────────────────────
  group('DateCalculatorLogic.dateInterval', () {
    test('Jan 1 2026 to Mar 22 2026 = 80 days', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 22),
      );
      expect(result.totalDays, 80);
    });

    test('Jan 1 2026 to Mar 22 2026 = 11 weeks 3 days', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 22),
      );
      expect(result.weeks, 11);
      expect(result.remainingDays, 3);
    });

    test('Jan 1 2026 to Mar 22 2026 = 2 months 21 days', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 22),
      );
      expect(result.months, 2);
      expect(result.monthRemainingDays, 21);
    });

    test('同一天差距為 0', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 3, 22),
        DateTime(2026, 3, 22),
      );
      expect(result.totalDays, 0);
      expect(result.weeks, 0);
      expect(result.remainingDays, 0);
      expect(result.months, 0);
      expect(result.monthRemainingDays, 0);
    });

    test('結束日期在開始日期之前時回傳正值（取絕對值）', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 3, 22),
        DateTime(2026, 1, 1),
      );
      expect(result.totalDays, 80);
    });

    test('跨年計算正確：Dec 31 2025 to Jan 1 2026 = 1 day', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2025, 12, 31),
        DateTime(2026, 1, 1),
      );
      expect(result.totalDays, 1);
    });

    test('整月計算：Jan 1 to Feb 1 = 1 month 0 days', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 1, 1),
        DateTime(2026, 2, 1),
      );
      expect(result.months, 1);
      expect(result.monthRemainingDays, 0);
    });

    test('跨閏年 Feb 28 to Mar 1 2028 = 2 days（2028 為閏年）', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2028, 2, 28),
        DateTime(2028, 3, 1),
      );
      expect(result.totalDays, 2);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // addDays（日期加減天數）
  // ─────────────────────────────────────────────────────────────────────────
  group('DateCalculatorLogic.addDays', () {
    test('Mar 1 2026 + 30 days = Mar 31 2026', () {
      final result = DateCalculatorLogic.addDays(DateTime(2026, 3, 1), 30);
      expect(result, DateTime(2026, 3, 31));
    });

    test('Mar 22 2026 - 10 days = Mar 12 2026', () {
      final result = DateCalculatorLogic.addDays(DateTime(2026, 3, 22), -10);
      expect(result, DateTime(2026, 3, 12));
    });

    test('加 0 天回傳同一天', () {
      final base = DateTime(2026, 6, 15);
      final result = DateCalculatorLogic.addDays(base, 0);
      expect(result, base);
    });

    test('跨月加法：Jan 30 + 5 = Feb 4', () {
      final result = DateCalculatorLogic.addDays(DateTime(2026, 1, 30), 5);
      expect(result, DateTime(2026, 2, 4));
    });

    test('跨年加法：Dec 30 2025 + 5 = Jan 4 2026', () {
      final result = DateCalculatorLogic.addDays(DateTime(2025, 12, 30), 5);
      expect(result, DateTime(2026, 1, 4));
    });

    test('大量天數：Jan 1 2026 + 365 = Jan 1 2027', () {
      final result = DateCalculatorLogic.addDays(DateTime(2026, 1, 1), 365);
      expect(result, DateTime(2027, 1, 1));
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // businessDays（工作日計算，排除週末）
  // ─────────────────────────────────────────────────────────────────────────
  group('DateCalculatorLogic.businessDays', () {
    test(
      'Mon Mar 2 2026 to Fri Mar 13 2026：11 calendar days, 10 business days',
      () {
        final result = DateCalculatorLogic.businessDays(
          DateTime(2026, 3, 2),
          DateTime(2026, 3, 13),
        );
        expect(result.calendarDays, 11);
        expect(result.businessDays, 10);
      },
    );

    test('同一天：0 calendar days, 0 business days', () {
      final result = DateCalculatorLogic.businessDays(
        DateTime(2026, 3, 2),
        DateTime(2026, 3, 2),
      );
      expect(result.calendarDays, 0);
      expect(result.businessDays, 0);
    });

    test(
      '純週末：Sat Mar 7 to Sun Mar 8 = 1 calendar day, 0 business days, 2 weekend days',
      () {
        final result = DateCalculatorLogic.businessDays(
          DateTime(2026, 3, 7),
          DateTime(2026, 3, 8),
        );
        expect(result.calendarDays, 1);
        expect(result.businessDays, 0);
        expect(result.weekendDays, 2);
      },
    );

    test(
      '一整週 Mon to Mon：7 calendar days, 6 business days（Mon-Fri + next Mon inclusive）',
      () {
        // Mar 2 2026 = Monday, Mar 9 2026 = Monday
        final result = DateCalculatorLogic.businessDays(
          DateTime(2026, 3, 2),
          DateTime(2026, 3, 9),
        );
        expect(result.calendarDays, 7);
        // Inclusive [Mon2..Mon9]: Mon2,Tue3,Wed4,Thu5,Fri6,Sat7,Sun8,Mon9
        // business=6, weekend=2
        expect(result.businessDays, 6);
      },
    );

    test('結束日期在開始日期之前時回傳正值', () {
      final result = DateCalculatorLogic.businessDays(
        DateTime(2026, 3, 13),
        DateTime(2026, 3, 2),
      );
      expect(result.calendarDays, 11);
      expect(result.businessDays, 10);
    });

    test(
      'Fri to Mon = 3 calendar days, 2 business days（Fri + Mon inclusive）',
      () {
        // Mar 6 2026 = Friday, Mar 9 2026 = Monday
        final result = DateCalculatorLogic.businessDays(
          DateTime(2026, 3, 6),
          DateTime(2026, 3, 9),
        );
        expect(result.calendarDays, 3);
        // Inclusive [Fri6, Sat7, Sun8, Mon9] → business=2, weekend=2
        expect(result.businessDays, 2);
      },
    );

    test('businessDays + weekendDays = calendarDays + 1（閉區間）', () {
      final result = DateCalculatorLogic.businessDays(
        DateTime(2026, 3, 2),
        DateTime(2026, 3, 13),
      );
      // [start, end] 閉區間共 calendarDays + 1 天
      expect(result.businessDays + result.weekendDays, result.calendarDays + 1);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // DateIntervalResult 資料類別
  // ─────────────────────────────────────────────────────────────────────────
  group('DateIntervalResult', () {
    test('totalDays, weeks, remainingDays 一致性', () {
      final result = DateCalculatorLogic.dateInterval(
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 22),
      );
      expect(result.weeks * 7 + result.remainingDays, result.totalDays);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // BusinessDaysResult 資料類別
  // ─────────────────────────────────────────────────────────────────────────
  group('BusinessDaysResult', () {
    test('businessDays + weekendDays = calendarDays + 1（閉區間含首尾）', () {
      final result = DateCalculatorLogic.businessDays(
        DateTime(2026, 3, 2),
        DateTime(2026, 3, 13),
      );
      expect(result.businessDays + result.weekendDays, result.calendarDays + 1);
    });
  });
}
