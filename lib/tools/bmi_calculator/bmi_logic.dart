import 'package:flutter/material.dart';

/// BMI 分級（依據 WHO 標準）
enum BmiCategory {
  /// 過輕：BMI < 18.5
  underweight,

  /// 正常：18.5 <= BMI <= 24.9
  normal,

  /// 過重：25.0 <= BMI <= 29.9
  overweight,

  /// 肥胖：BMI >= 30.0
  obese;

  /// 各分級對應顯示顏色
  Color get color {
    switch (this) {
      case BmiCategory.underweight:
        return const Color(0xFF2196F3); // 藍
      case BmiCategory.normal:
        return const Color(0xFF4CAF50); // 綠
      case BmiCategory.overweight:
        return const Color(0xFFFF9800); // 橙
      case BmiCategory.obese:
        return const Color(0xFFF44336); // 紅
    }
  }
}

/// BMI 計算結果
class BmiResult {
  const BmiResult({required this.bmi, required this.category});

  /// BMI 數值（四捨五入至小數點後兩位）
  final double bmi;

  /// BMI 分級
  final BmiCategory category;
}

/// BMI 計算邏輯
class BmiLogic {
  BmiLogic._();

  /// 計算 BMI 並回傳結果。
  ///
  /// - [heightCm]：身高（公分）
  /// - [weightKg]：體重（公斤）
  ///
  /// 公式：BMI = weight(kg) / height(m)²
  static BmiResult calculate(double heightCm, double weightKg) {
    final heightM = heightCm / 100.0;
    final bmi = weightKg / (heightM * heightM);
    final rounded = double.parse(bmi.toStringAsFixed(2));
    return BmiResult(bmi: rounded, category: _classify(bmi));
  }

  /// 計算指定身高的健康體重範圍（BMI 18.5–24.9）。
  ///
  /// 回傳 `(min, max)` record，單位為公斤，四捨五入至小數點後三位。
  static (double min, double max) healthyWeightRange(double heightCm) {
    final heightM = heightCm / 100.0;
    final heightMSquared = heightM * heightM;
    final min = double.parse((18.5 * heightMSquared).toStringAsFixed(3));
    final max = double.parse((24.9 * heightMSquared).toStringAsFixed(3));
    return (min, max);
  }

  /// 依據 BMI 數值回傳對應分級。
  static BmiCategory _classify(double bmi) {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25.0) return BmiCategory.normal;
    if (bmi < 30.0) return BmiCategory.overweight;
    return BmiCategory.obese;
  }
}
