import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/calculator/calculator_history_service.dart';
import 'package:my_first_app/tools/calculator/calculator_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CalculationEntry serialization', () {
    test('toJson and fromJson roundtrip', () {
      final entry = CalculationEntry(
        expression: '2 + 3',
        result: '5',
        timestamp: DateTime(2026, 3, 22, 10, 30),
      );

      final json = entry.toJson();
      final restored = CalculationEntry.fromJson(json);

      expect(restored.expression, entry.expression);
      expect(restored.result, entry.result);
      expect(restored.timestamp, entry.timestamp);
    });

    test('toJson produces correct keys', () {
      final entry = CalculationEntry(
        expression: '10 / 2',
        result: '5',
        timestamp: DateTime(2026, 1, 1),
      );

      final json = entry.toJson();
      expect(json.containsKey('expression'), true);
      expect(json.containsKey('result'), true);
      expect(json.containsKey('timestamp'), true);
      expect(json['expression'], '10 / 2');
    });

    test('fromJson parses ISO 8601 timestamp', () {
      final json = {
        'expression': '1+1',
        'result': '2',
        'timestamp': '2026-03-22T10:30:00.000',
      };
      final entry = CalculationEntry.fromJson(json);
      expect(entry.timestamp.year, 2026);
      expect(entry.timestamp.month, 3);
      expect(entry.timestamp.hour, 10);
    });
  });

  group('CalculatorHistoryService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('load returns empty list when no data', () async {
      final service = CalculatorHistoryService();
      final result = await service.load();
      expect(result, isEmpty);
    });

    test('save and load roundtrip', () async {
      final service = CalculatorHistoryService();
      final entries = [
        CalculationEntry(
          expression: '1+1',
          result: '2',
          timestamp: DateTime(2026, 1, 1),
        ),
        CalculationEntry(
          expression: '3*4',
          result: '12',
          timestamp: DateTime(2026, 1, 2),
        ),
      ];

      await service.save(entries);
      final loaded = await service.load();

      expect(loaded.length, 2);
      expect(loaded[0].expression, '1+1');
      expect(loaded[1].result, '12');
    });

    test('add inserts at top and saves', () async {
      final service = CalculatorHistoryService();
      final existing = [
        CalculationEntry(
          expression: 'old',
          result: '0',
          timestamp: DateTime(2026, 1, 1),
        ),
      ];

      final newEntry = CalculationEntry(
        expression: 'new',
        result: '1',
        timestamp: DateTime(2026, 1, 2),
      );

      final updated = await service.add(newEntry, existing);
      expect(updated.length, 2);
      expect(updated[0].expression, 'new');
      expect(updated[1].expression, 'old');

      // Verify persistence
      final loaded = await service.load();
      expect(loaded.length, 2);
      expect(loaded[0].expression, 'new');
    });

    test('add enforces 100-entry limit', () async {
      final service = CalculatorHistoryService();
      final existing = List.generate(
        100,
        (i) => CalculationEntry(
          expression: 'expr_$i',
          result: '$i',
          timestamp: DateTime(2026, 1, 1),
        ),
      );

      final newEntry = CalculationEntry(
        expression: 'newest',
        result: '999',
        timestamp: DateTime(2026, 1, 2),
      );

      final updated = await service.add(newEntry, existing);
      expect(updated.length, CalculatorHistoryService.maxEntries);
      expect(updated.first.expression, 'newest');
      expect(updated.last.expression, 'expr_98');
    });

    test('clear removes all data', () async {
      final service = CalculatorHistoryService();
      final entries = [
        CalculationEntry(
          expression: '1+1',
          result: '2',
          timestamp: DateTime(2026, 1, 1),
        ),
      ];

      await service.save(entries);
      await service.clear();

      final loaded = await service.load();
      expect(loaded, isEmpty);
    });

    test('load handles corrupted data gracefully', () async {
      SharedPreferences.setMockInitialValues({
        'calculator_history': ['not valid json'],
      });

      final service = CalculatorHistoryService();
      expect(() => service.load(), throwsA(isA<FormatException>()));
    });
  });
}
