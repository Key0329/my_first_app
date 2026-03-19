import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';

void main() {
  group('BentoSize enum', () {
    test('has exactly three values: large, medium, small', () {
      expect(BentoSize.values.length, 3);
      expect(BentoSize.values, containsAll([
        BentoSize.large,
        BentoSize.medium,
        BentoSize.small,
      ]));
    });
  });

  group('ToolItem.defaultBentoSize', () {
    test('defaults to BentoSize.medium when not specified', () {
      const item = ToolItem(
        id: 'test',
        nameKey: 'tool_test',
        fallbackName: '測試',
        icon: Icons.star,
        color: Color(0xFF000000),
        routePath: '/tools/test',
      );

      expect(item.defaultBentoSize, BentoSize.medium);
    });

    test('can be set to BentoSize.large', () {
      const item = ToolItem(
        id: 'test_large',
        nameKey: 'tool_test_large',
        fallbackName: '測試大',
        icon: Icons.star,
        color: Color(0xFF000000),
        routePath: '/tools/test-large',
        defaultBentoSize: BentoSize.large,
      );

      expect(item.defaultBentoSize, BentoSize.large);
    });

    test('can be set to BentoSize.small', () {
      const item = ToolItem(
        id: 'test_small',
        nameKey: 'tool_test_small',
        fallbackName: '測試小',
        icon: Icons.star,
        color: Color(0xFF000000),
        routePath: '/tools/test-small',
        defaultBentoSize: BentoSize.small,
      );

      expect(item.defaultBentoSize, BentoSize.small);
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

    test('all existing entries default to BentoSize.medium', () {
      for (final tool in allTools) {
        expect(
          tool.defaultBentoSize,
          BentoSize.medium,
          reason: 'Tool "${tool.id}" should default to BentoSize.medium',
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
        'invoice_checker',
      ]));
    });
  });
}
