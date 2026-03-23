import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/unit_converter/units_data.dart';

void main() {
  /// Helper: find a unit by its [id] within a category found by [categoryId].
  UnitDefinition findUnit(String categoryId, String unitId) {
    final category = allCategories.firstWhere((c) => c.id == categoryId);
    return category.units.firstWhere((u) => u.id == unitId);
  }

  group('Length conversions', () {
    test('1 km = 1000 m', () {
      final km = findUnit('length', 'km');
      final m = findUnit('length', 'm');
      expect(convert(km, m, 1), equals(1000));
    });

    test('1 m = 100 cm', () {
      final m = findUnit('length', 'm');
      final cm = findUnit('length', 'cm');
      expect(convert(m, cm, 1), equals(100));
    });

    test('1 mile = 1609.344 m', () {
      final mi = findUnit('length', 'mi');
      final m = findUnit('length', 'm');
      expect(convert(mi, m, 1), closeTo(1609.344, 1e-6));
    });

    test('1 ft = 12 in', () {
      final ft = findUnit('length', 'ft');
      final inch = findUnit('length', 'in');
      expect(convert(ft, inch, 1), closeTo(12, 1e-6));
    });

    test('0 m = 0 km', () {
      final m = findUnit('length', 'm');
      final km = findUnit('length', 'km');
      expect(convert(m, km, 0), equals(0));
    });
  });

  group('Weight conversions', () {
    test('1 kg = 1000 g', () {
      final kg = findUnit('weight', 'kg');
      final g = findUnit('weight', 'g');
      expect(convert(kg, g, 1), equals(1000));
    });

    test('1 lb ≈ 0.4536 kg', () {
      final lb = findUnit('weight', 'lb');
      final kg = findUnit('weight', 'kg');
      expect(convert(lb, kg, 1), closeTo(0.45359237, 1e-8));
    });

    test('台斤: 1 台斤 = 0.6 kg', () {
      final twJin = findUnit('weight', 'tw_jin');
      final kg = findUnit('weight', 'kg');
      expect(convert(twJin, kg, 1), equals(0.6));
    });

    test('台斤: 5 kg = 8.333... 台斤', () {
      final kg = findUnit('weight', 'kg');
      final twJin = findUnit('weight', 'tw_jin');
      expect(convert(kg, twJin, 5), closeTo(8.333333, 1e-4));
    });

    test('台斤: 10 台斤 = 6 kg', () {
      final twJin = findUnit('weight', 'tw_jin');
      final kg = findUnit('weight', 'kg');
      expect(convert(twJin, kg, 10), equals(6));
    });
  });

  group('Area conversions', () {
    test('1 km² = 1,000,000 m²', () {
      final km2 = findUnit('area', 'km2');
      final m2 = findUnit('area', 'm2');
      expect(convert(km2, m2, 1), equals(1000000));
    });

    test('坪: 1 坪 = 3.305785 m²', () {
      final ping = findUnit('area', 'ping');
      final m2 = findUnit('area', 'm2');
      expect(convert(ping, m2, 1), closeTo(3.305785, 1e-6));
    });

    test('坪: 10 坪 = 33.05785 m²', () {
      final ping = findUnit('area', 'ping');
      final m2 = findUnit('area', 'm2');
      expect(convert(ping, m2, 10), closeTo(33.05785, 1e-5));
    });

    test('坪: round-trip 10 m² -> 坪 -> m² ≈ 10', () {
      final ping = findUnit('area', 'ping');
      final m2 = findUnit('area', 'm2');
      final inPing = convert(m2, ping, 10);
      final backToM2 = convert(ping, m2, inPing);
      expect(backToM2, closeTo(10, 1e-8));
    });
  });

  group('Temperature conversions', () {
    test('0 °C = 32 °F', () {
      final c = findUnit('temperature', 'c');
      final f = findUnit('temperature', 'f');
      expect(convert(c, f, 0), equals(32));
    });

    test('100 °C = 212 °F', () {
      final c = findUnit('temperature', 'c');
      final f = findUnit('temperature', 'f');
      expect(convert(c, f, 100), equals(212));
    });

    test('32 °F = 0 °C', () {
      final f = findUnit('temperature', 'f');
      final c = findUnit('temperature', 'c');
      expect(convert(f, c, 32), closeTo(0, 1e-10));
    });

    test('0 °C = 273.15 K', () {
      final c = findUnit('temperature', 'c');
      final k = findUnit('temperature', 'k');
      expect(convert(c, k, 0), equals(273.15));
    });

    test('273.15 K = 0 °C', () {
      final k = findUnit('temperature', 'k');
      final c = findUnit('temperature', 'c');
      expect(convert(k, c, 273.15), closeTo(0, 1e-10));
    });

    test('-40 °C = -40 °F', () {
      final c = findUnit('temperature', 'c');
      final f = findUnit('temperature', 'f');
      expect(convert(c, f, -40), closeTo(-40, 1e-10));
    });
  });

  group('Year conversions (民國年 ↔ 西元年)', () {
    test('民國 113 年 = 西元 2024 年', () {
      final roc = findUnit('year', 'roc');
      final ad = findUnit('year', 'ad');
      expect(convert(roc, ad, 113), equals(2024));
    });

    test('西元 2024 年 = 民國 113 年', () {
      final ad = findUnit('year', 'ad');
      final roc = findUnit('year', 'roc');
      expect(convert(ad, roc, 2024), equals(113));
    });

    test('民國 1 年 = 西元 1912 年', () {
      final roc = findUnit('year', 'roc');
      final ad = findUnit('year', 'ad');
      expect(convert(roc, ad, 1), equals(1912));
    });

    test('西元 1911 年 = 民國 0 年', () {
      final ad = findUnit('year', 'ad');
      final roc = findUnit('year', 'roc');
      expect(convert(ad, roc, 1911), equals(0));
    });
  });

  group('Same-unit identity', () {
    test('converting a unit to itself returns the same value', () {
      final m = findUnit('length', 'm');
      expect(convert(m, m, 42), equals(42));
    });

    test('temperature identity: 100 °C -> °C = 100', () {
      final c = findUnit('temperature', 'c');
      expect(convert(c, c, 100), equals(100));
    });
  });

  group('Category structure', () {
    test('allCategories contains all 5 categories', () {
      expect(allCategories.length, equals(5));
      final ids = allCategories.map((c) => c.id).toList();
      expect(
        ids,
        containsAll(['length', 'weight', 'area', 'temperature', 'year']),
      );
    });

    test('each category has at least 2 units', () {
      for (final cat in allCategories) {
        expect(
          cat.units.length,
          greaterThanOrEqualTo(2),
          reason: '${cat.name} should have at least 2 units',
        );
      }
    });

    test('Taiwan-specific units exist', () {
      // 坪 in area
      expect(
        allCategories
            .firstWhere((c) => c.id == 'area')
            .units
            .any((u) => u.id == 'ping'),
        isTrue,
      );
      // 台斤 in weight
      expect(
        allCategories
            .firstWhere((c) => c.id == 'weight')
            .units
            .any((u) => u.id == 'tw_jin'),
        isTrue,
      );
      // 民國年 in year
      expect(
        allCategories
            .firstWhere((c) => c.id == 'year')
            .units
            .any((u) => u.id == 'roc'),
        isTrue,
      );
    });
  });
}
