/// Unit definitions and conversion logic for the unit converter tool.
///
/// Supports length, weight, area, temperature, and year categories,
/// including Taiwan-specific units (坪, 台斤, 民國年).
library;

/// A single unit within a category.
class UnitDefinition {
  final String id;
  final String name;

  /// Factor to convert FROM this unit TO the category's base unit.
  /// For units with non-linear conversion (e.g. temperature), use
  /// [toBase] and [fromBase] instead.
  final double toBaseFactor;

  /// Optional custom conversion: value in this unit -> base unit value.
  final double Function(double)? toBase;

  /// Optional custom conversion: base unit value -> value in this unit.
  final double Function(double)? fromBase;

  const UnitDefinition({
    required this.id,
    required this.name,
    this.toBaseFactor = 1.0,
    this.toBase,
    this.fromBase,
  });
}

/// A category of units (e.g. length, weight).
class UnitCategory {
  final String id;
  final String name;
  final List<UnitDefinition> units;

  const UnitCategory({
    required this.id,
    required this.name,
    required this.units,
  });
}

// ---------------------------------------------------------------------------
// Conversion helper
// ---------------------------------------------------------------------------

/// Convert [value] from [source] unit to [target] unit within the same
/// category. Both units must share the same base unit.
double convert(UnitDefinition source, UnitDefinition target, double value) {
  // Convert source value -> base value.
  final baseValue = source.toBase != null
      ? source.toBase!(value)
      : value * source.toBaseFactor;

  // Convert base value -> target value.
  if (target.fromBase != null) {
    return target.fromBase!(baseValue);
  }
  return baseValue / target.toBaseFactor;
}

// ---------------------------------------------------------------------------
// Categories & units
// ---------------------------------------------------------------------------

// ----- Length (base: metre) -----
final _length = UnitCategory(
  id: 'length',
  name: '長度',
  units: [
    const UnitDefinition(id: 'mm', name: '毫米 (mm)', toBaseFactor: 0.001),
    const UnitDefinition(id: 'cm', name: '公分 (cm)', toBaseFactor: 0.01),
    const UnitDefinition(id: 'm', name: '公尺 (m)', toBaseFactor: 1),
    const UnitDefinition(id: 'km', name: '公里 (km)', toBaseFactor: 1000),
    const UnitDefinition(id: 'in', name: '英寸 (in)', toBaseFactor: 0.0254),
    const UnitDefinition(id: 'ft', name: '英尺 (ft)', toBaseFactor: 0.3048),
    const UnitDefinition(id: 'yd', name: '碼 (yd)', toBaseFactor: 0.9144),
    const UnitDefinition(id: 'mi', name: '英里 (mi)', toBaseFactor: 1609.344),
  ],
);

// ----- Weight (base: kilogram) -----
final _weight = UnitCategory(
  id: 'weight',
  name: '重量',
  units: [
    const UnitDefinition(id: 'mg', name: '毫克 (mg)', toBaseFactor: 0.000001),
    const UnitDefinition(id: 'g', name: '公克 (g)', toBaseFactor: 0.001),
    const UnitDefinition(id: 'kg', name: '公斤 (kg)', toBaseFactor: 1),
    const UnitDefinition(id: 't', name: '公噸 (t)', toBaseFactor: 1000),
    const UnitDefinition(
      id: 'oz',
      name: '盎司 (oz)',
      toBaseFactor: 0.028349523125,
    ),
    const UnitDefinition(id: 'lb', name: '磅 (lb)', toBaseFactor: 0.45359237),
    const UnitDefinition(
      id: 'tw_jin',
      name: '台斤',
      toBaseFactor: 0.6, // 1 台斤 = 0.6 kg
    ),
  ],
);

// ----- Area (base: square metre) -----
final _area = UnitCategory(
  id: 'area',
  name: '面積',
  units: [
    const UnitDefinition(id: 'cm2', name: '平方公分 (cm²)', toBaseFactor: 0.0001),
    const UnitDefinition(id: 'm2', name: '平方公尺 (m²)', toBaseFactor: 1),
    const UnitDefinition(id: 'km2', name: '平方公里 (km²)', toBaseFactor: 1000000),
    const UnitDefinition(id: 'ha', name: '公頃 (ha)', toBaseFactor: 10000),
    const UnitDefinition(
      id: 'ft2',
      name: '平方英尺 (ft²)',
      toBaseFactor: 0.09290304,
    ),
    const UnitDefinition(id: 'ac', name: '英畝 (ac)', toBaseFactor: 4046.8564224),
    const UnitDefinition(
      id: 'ping',
      name: '坪',
      toBaseFactor: 3.305785, // 1 坪 = 3.305785 m²
    ),
  ],
);

// ----- Temperature (base: Celsius) -----
final _temperature = UnitCategory(
  id: 'temperature',
  name: '溫度',
  units: [
    const UnitDefinition(id: 'c', name: '攝氏 (°C)', toBaseFactor: 1),
    UnitDefinition(
      id: 'f',
      name: '華氏 (°F)',
      toBase: (f) => (f - 32) * 5 / 9,
      fromBase: (c) => c * 9 / 5 + 32,
    ),
    UnitDefinition(
      id: 'k',
      name: '克氏 (K)',
      toBase: (k) => k - 273.15,
      fromBase: (c) => c + 273.15,
    ),
  ],
);

// ----- Year (base: 西元年 / AD year) -----
final _year = UnitCategory(
  id: 'year',
  name: '年份',
  units: [
    const UnitDefinition(id: 'ad', name: '西元年', toBaseFactor: 1),
    UnitDefinition(
      id: 'roc',
      name: '民國年',
      toBase: (roc) => roc + 1911, // 民國年 + 1911 = 西元年
      fromBase: (ad) => ad - 1911,
    ),
  ],
);

/// All categories available in the unit converter.
final List<UnitCategory> allCategories = [
  _length,
  _weight,
  _area,
  _temperature,
  _year,
];
