import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/split_bill/split_bill_page.dart';

void main() {
  // ---------------------------------------------------------------------------
  // calculateSplitBill
  // ---------------------------------------------------------------------------

  group('calculateSplitBill', () {
    group('整除情況', () {
      test('1500 ÷ 3 → base=500, remainder=0', () {
        final result = calculateSplitBill(total: 1500, count: 3);
        expect(result.base, equals(500));
        expect(result.remainder, equals(0));
        expect(result.isEvenSplit, isTrue);
        expect(result.firstPersonAmount, equals(500));
      });

      test('200 ÷ 2 → base=100, remainder=0', () {
        final result = calculateSplitBill(total: 200, count: 2);
        expect(result.base, equals(100));
        expect(result.remainder, equals(0));
        expect(result.isEvenSplit, isTrue);
      });

      test('600 ÷ 4 → base=150, remainder=0', () {
        final result = calculateSplitBill(total: 600, count: 4);
        expect(result.base, equals(150));
        expect(result.remainder, equals(0));
        expect(result.isEvenSplit, isTrue);
      });

      test('1000 ÷ 10 → base=100, remainder=0', () {
        final result = calculateSplitBill(total: 1000, count: 10);
        expect(result.base, equals(100));
        expect(result.remainder, equals(0));
        expect(result.isEvenSplit, isTrue);
      });
    });

    group('有餘數情況', () {
      test('10 ÷ 3 → base=3, remainder=1', () {
        final result = calculateSplitBill(total: 10, count: 3);
        expect(result.base, equals(3));
        expect(result.remainder, equals(1));
        expect(result.isEvenSplit, isFalse);
        expect(result.firstPersonAmount, equals(4));
      });

      test('100 ÷ 3 → base=33, remainder=1', () {
        final result = calculateSplitBill(total: 100, count: 3);
        expect(result.base, equals(33));
        expect(result.remainder, equals(1));
        expect(result.firstPersonAmount, equals(34));
      });

      test('101 ÷ 2 → base=50, remainder=1', () {
        final result = calculateSplitBill(total: 101, count: 2);
        expect(result.base, equals(50));
        expect(result.remainder, equals(1));
        expect(result.firstPersonAmount, equals(51));
      });

      test('7 ÷ 3 → base=2, remainder=1', () {
        final result = calculateSplitBill(total: 7, count: 3);
        expect(result.base, equals(2));
        expect(result.remainder, equals(1));
        expect(result.firstPersonAmount, equals(3));
      });

      test('最大人數 30：100 ÷ 30 → base=3, remainder=10', () {
        final result = calculateSplitBill(total: 100, count: 30);
        expect(result.base, equals(3));
        expect(result.remainder, equals(10));
        expect(result.firstPersonAmount, equals(13));
        // 驗證總額一致性：第一人 13 + 其餘 29 人各 3 = 13 + 87 = 100
        final total = result.firstPersonAmount + result.base * 29;
        expect(total, equals(100));
      });
    });

    group('邊界值', () {
      test('總金額為 0 時，每人均為 0', () {
        final result = calculateSplitBill(total: 0, count: 5);
        expect(result.base, equals(0));
        expect(result.remainder, equals(0));
        expect(result.isEvenSplit, isTrue);
        expect(result.firstPersonAmount, equals(0));
      });

      test('最少 2 人：100 ÷ 2 → base=50', () {
        final result = calculateSplitBill(total: 100, count: 2);
        expect(result.base, equals(50));
        expect(result.remainder, equals(0));
      });

      test('金額 1 ÷ 2 → base=0, remainder=1（第一人付 1）', () {
        final result = calculateSplitBill(total: 1, count: 2);
        expect(result.base, equals(0));
        expect(result.remainder, equals(1));
        expect(result.firstPersonAmount, equals(1));
      });

      test('總額等於人數：5 ÷ 5 → base=1, remainder=0', () {
        final result = calculateSplitBill(total: 5, count: 5);
        expect(result.base, equals(1));
        expect(result.remainder, equals(0));
      });
    });

    group('總額一致性驗證（第一人 + 其餘人 = 總額）', () {
      void expectTotalConsistency(int total, int count) {
        final result = calculateSplitBill(total: total, count: count);
        final computed =
            result.firstPersonAmount + result.base * (count - 1);
        expect(
          computed,
          equals(total),
          reason: '$total ÷ $count 計算後總和應等於 $total，實際為 $computed',
        );
      }

      test('1500 ÷ 3', () => expectTotalConsistency(1500, 3));
      test('1001 ÷ 4', () => expectTotalConsistency(1001, 4));
      test('9999 ÷ 7', () => expectTotalConsistency(9999, 7));
      test('50000 ÷ 13', () => expectTotalConsistency(50000, 13));
      test('1 ÷ 30', () => expectTotalConsistency(1, 30));
    });
  });

  // ---------------------------------------------------------------------------
  // formatWithThousands
  // ---------------------------------------------------------------------------

  group('formatWithThousands', () {
    test('0 → "0"', () {
      expect(formatWithThousands(0), equals('0'));
    });

    test('999 → "999"（不加逗號）', () {
      expect(formatWithThousands(999), equals('999'));
    });

    test('1000 → "1,000"', () {
      expect(formatWithThousands(1000), equals('1,000'));
    });

    test('1500 → "1,500"', () {
      expect(formatWithThousands(1500), equals('1,500'));
    });

    test('10000 → "10,000"', () {
      expect(formatWithThousands(10000), equals('10,000'));
    });

    test('1000000 → "1,000,000"', () {
      expect(formatWithThousands(1000000), equals('1,000,000'));
    });

    test('123456789 → "123,456,789"', () {
      expect(formatWithThousands(123456789), equals('123,456,789'));
    });
  });

  // ---------------------------------------------------------------------------
  // SplitBillResult 屬性
  // ---------------------------------------------------------------------------

  group('SplitBillResult', () {
    test('isEvenSplit 在 remainder=0 時為 true', () {
      const result = SplitBillResult(base: 100, remainder: 0);
      expect(result.isEvenSplit, isTrue);
    });

    test('isEvenSplit 在 remainder>0 時為 false', () {
      const result = SplitBillResult(base: 100, remainder: 1);
      expect(result.isEvenSplit, isFalse);
    });

    test('firstPersonAmount = base + remainder', () {
      const result = SplitBillResult(base: 33, remainder: 2);
      expect(result.firstPersonAmount, equals(35));
    });

    test('整除時 firstPersonAmount = base', () {
      const result = SplitBillResult(base: 500, remainder: 0);
      expect(result.firstPersonAmount, equals(500));
    });
  });
}
