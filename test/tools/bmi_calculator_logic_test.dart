import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/bmi_calculator/bmi_logic.dart';

void main() {
  group('BmiLogic.calculate', () {
    group('BMI 公式正確性', () {
      test('身高 170cm、體重 70kg 計算正確', () {
        final result = BmiLogic.calculate(170, 70);
        // BMI = 70 / (1.7 * 1.7) = 24.221...
        expect(result.bmi, closeTo(24.22, 0.01));
      });

      test('身高 180cm、體重 80kg 計算正確', () {
        final result = BmiLogic.calculate(180, 80);
        // BMI = 80 / (1.8 * 1.8) = 24.691...
        expect(result.bmi, closeTo(24.69, 0.01));
      });

      test('身高 160cm、體重 50kg 計算正確', () {
        final result = BmiLogic.calculate(160, 50);
        // BMI = 50 / (1.6 * 1.6) = 19.531...
        expect(result.bmi, closeTo(19.53, 0.01));
      });
    });

    group('BMI 分級邊界值', () {
      test('BMI 精確 18.5 歸類為 normal', () {
        // weight = 18.5 * (1.70 * 1.70) = 53.465kg
        final heightCm = 170.0;
        final weightKg = 18.5 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(18.5, 0.001));
        expect(result.category, BmiCategory.normal);
      });

      test('BMI 18.499（低於 18.5）歸類為 underweight', () {
        final heightCm = 170.0;
        final weightKg = 18.499 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.category, BmiCategory.underweight);
      });

      test('BMI 精確 24.9 歸類為 normal', () {
        final heightCm = 170.0;
        final weightKg = 24.9 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(24.9, 0.001));
        expect(result.category, BmiCategory.normal);
      });

      test('BMI 精確 25.0 歸類為 overweight', () {
        final heightCm = 170.0;
        final weightKg = 25.0 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(25.0, 0.001));
        expect(result.category, BmiCategory.overweight);
      });

      test('BMI 29.9 歸類為 overweight', () {
        final heightCm = 170.0;
        final weightKg = 29.9 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(29.9, 0.001));
        expect(result.category, BmiCategory.overweight);
      });

      test('BMI 精確 30.0 歸類為 obese', () {
        final heightCm = 170.0;
        final weightKg = 30.0 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(30.0, 0.001));
        expect(result.category, BmiCategory.obese);
      });

      test('BMI 35.0 歸類為 obese', () {
        final heightCm = 170.0;
        final weightKg = 35.0 * (heightCm / 100) * (heightCm / 100);
        final result = BmiLogic.calculate(heightCm, weightKg);
        expect(result.bmi, closeTo(35.0, 0.001));
        expect(result.category, BmiCategory.obese);
      });
    });

    group('各分級代表案例', () {
      test('過輕：身高 170cm、體重 45kg', () {
        final result = BmiLogic.calculate(170, 45);
        expect(result.category, BmiCategory.underweight);
      });

      test('正常：身高 170cm、體重 65kg', () {
        final result = BmiLogic.calculate(170, 65);
        expect(result.category, BmiCategory.normal);
      });

      test('過重：身高 170cm、體重 80kg', () {
        final result = BmiLogic.calculate(170, 80);
        expect(result.category, BmiCategory.overweight);
      });

      test('肥胖：身高 170cm、體重 95kg', () {
        final result = BmiLogic.calculate(170, 95);
        expect(result.category, BmiCategory.obese);
      });
    });

    group('BmiResult 屬性', () {
      test('result 包含 bmi double 值', () {
        final result = BmiLogic.calculate(170, 70);
        expect(result.bmi, isA<double>());
      });

      test('result 包含 category BmiCategory 值', () {
        final result = BmiLogic.calculate(170, 70);
        expect(result.category, isA<BmiCategory>());
      });
    });
  });

  group('BmiLogic.healthyWeightRange', () {
    test('身高 170cm 的健康體重範圍下限正確', () {
      final (min, max) = BmiLogic.healthyWeightRange(170);
      // min = 18.5 * 1.70^2 = 53.465
      expect(min, closeTo(53.465, 0.01));
    });

    test('身高 170cm 的健康體重範圍上限正確', () {
      final (min, max) = BmiLogic.healthyWeightRange(170);
      // max = 24.9 * 1.70^2 = 71.961
      expect(max, closeTo(71.961, 0.01));
    });

    test('身高 160cm 的健康體重範圍正確', () {
      final (min, max) = BmiLogic.healthyWeightRange(160);
      // min = 18.5 * 1.60^2 = 47.36
      // max = 24.9 * 1.60^2 = 63.744
      expect(min, closeTo(47.36, 0.01));
      expect(max, closeTo(63.744, 0.01));
    });

    test('身高 180cm 的健康體重範圍正確', () {
      final (min, max) = BmiLogic.healthyWeightRange(180);
      // min = 18.5 * 1.80^2 = 59.94
      // max = 24.9 * 1.80^2 = 80.676
      expect(min, closeTo(59.94, 0.01));
      expect(max, closeTo(80.676, 0.01));
    });

    test('min 小於 max', () {
      final (min, max) = BmiLogic.healthyWeightRange(170);
      expect(min, lessThan(max));
    });
  });

  group('BmiCategory.color', () {
    test('underweight 回傳藍色', () {
      expect(BmiCategory.underweight.color, const Color(0xFF2196F3));
    });

    test('normal 回傳綠色', () {
      expect(BmiCategory.normal.color, const Color(0xFF4CAF50));
    });

    test('overweight 回傳橙色', () {
      expect(BmiCategory.overweight.color, const Color(0xFFFF9800));
    });

    test('obese 回傳紅色', () {
      expect(BmiCategory.obese.color, const Color(0xFFF44336));
    });
  });
}
