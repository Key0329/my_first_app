import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';

void main() {
  group('ToolCategory enum', () {
    test('has exactly three values: calculate, measure, life', () {
      expect(ToolCategory.values.length, 3);
      expect(ToolCategory.values, containsAll([
        ToolCategory.calculate,
        ToolCategory.measure,
        ToolCategory.life,
      ]));
    });

    test('each category has a label', () {
      expect(ToolCategory.calculate.label, '計算');
      expect(ToolCategory.measure.label, '測量');
      expect(ToolCategory.life.label, '生活');
    });
  });

  group('ToolItem', () {
    test('requires category parameter', () {
      const item = ToolItem(
        id: 'test',
        nameKey: 'tool_test',
        fallbackName: '測試',
        icon: Icons.star,
        routePath: '/tools/test',
        category: ToolCategory.life,
      );

      expect(item.category, ToolCategory.life);
    });
  });

  group('allTools backward compatibility', () {
    test('all entries are still valid ToolItem instances', () {
      expect(allTools, isNotEmpty);
      for (final tool in allTools) {
        expect(tool.id, isNotEmpty);
        expect(tool.nameKey, isNotEmpty);
        expect(tool.fallbackName, isNotEmpty);
        expect(tool.routePath, isNotEmpty);
      }
    });

    test('all entries have a valid category', () {
      for (final tool in allTools) {
        expect(
          ToolCategory.values.contains(tool.category),
          isTrue,
          reason: 'Tool "${tool.id}" should have a valid ToolCategory',
        );
      }
    });

    test('allTools contains expected tool ids', () {
      final ids = allTools.map((t) => t.id).toList();
      expect(ids, containsAll([
        'calculator',
        'unit_converter',
        'qr_generator',
        'flashlight',
        'level',
        'compass',
        'stopwatch_timer',
        'noise_meter',
        'password_generator',
        'color_picker',
        'protractor',
        'bmi_calculator',
        'split_bill',
        'random_wheel',
        'screen_ruler',
      ]));
    });
  });
}
