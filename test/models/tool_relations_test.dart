import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/models/tool_relations.dart';

void main() {
  group('toolRelations', () {
    test('every tool in allTools has relations defined', () {
      for (final tool in allTools) {
        final recs = getRecommendations(tool.id);
        expect(
          recs.isNotEmpty,
          true,
          reason: '${tool.id} should have at least one recommendation',
        );
      }
    });

    test('all relation target IDs exist in allTools', () {
      final allIds = allTools.map((t) => t.id).toSet();
      for (final entry in toolRelations.entries) {
        for (final targetId in entry.value) {
          expect(
            allIds.contains(targetId),
            true,
            reason:
                'Relation target "$targetId" (from "${entry.key}") not found in allTools',
          );
        }
      }
    });

    test('no tool recommends itself', () {
      for (final entry in toolRelations.entries) {
        expect(
          entry.value.contains(entry.key),
          false,
          reason: '${entry.key} should not recommend itself',
        );
      }
    });

    test('each tool has 1-2 recommendations', () {
      for (final tool in allTools) {
        final recs = getRecommendations(tool.id);
        expect(
          recs.length,
          inInclusiveRange(1, 2),
          reason: '${tool.id} should have 1-2 recommendations',
        );
      }
    });

    test('getRecommendations returns ToolItem objects', () {
      final recs = getRecommendations('calculator');
      expect(recs, isNotEmpty);
      expect(recs.first, isA<ToolItem>());
    });

    test('fallback returns same-category tools for unknown ID', () {
      // Unknown ID should return empty (no matching tool in allTools)
      final recs = getRecommendations('nonexistent_tool');
      expect(recs, isEmpty);
    });
  });
}
