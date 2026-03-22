import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() {
  group('AppSettings — recentTools', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    // 1. recentTools 預設為空清單
    test('recentTools defaults to empty list', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.recentTools, isEmpty);
    });

    // 2. addRecentTool() 將工具加到清單最前面
    test('addRecentTool adds tool to front of list', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.addRecentTool('calculator');
      expect(settings.recentTools, ['calculator']);

      await settings.addRecentTool('compass');
      expect(settings.recentTools, ['compass', 'calculator']);

      await settings.addRecentTool('flashlight');
      expect(settings.recentTools.first, 'flashlight');
      expect(settings.recentTools, ['flashlight', 'compass', 'calculator']);
    });

    // 3. 加入重複的工具時，移到最前面（去重）
    test('adding duplicate tool moves it to front', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.addRecentTool('calculator');
      await settings.addRecentTool('compass');
      await settings.addRecentTool('calculator'); // 重複加入

      expect(settings.recentTools.first, 'calculator');
      expect(settings.recentTools.length, 2);
      expect(settings.recentTools, ['calculator', 'compass']);
    });

    // 4. 清單最多保留 5 筆
    test('list respects max 5 items', () async {
      final settings = AppSettings();
      await settings.init();

      for (final tool in ['a', 'b', 'c', 'd', 'e', 'f']) {
        await settings.addRecentTool(tool);
      }

      expect(settings.recentTools.length, 5);
      // 最後加入的排在最前面，最舊的被淘汰
      expect(settings.recentTools.first, 'f');
      expect(settings.recentTools, isNot(contains('a')));
      expect(settings.recentTools, ['f', 'e', 'd', 'c', 'b']);
    });

    // 5. clearRecentTools() 清除所有項目
    test('clearRecentTools clears all entries', () async {
      final settings = AppSettings();
      await settings.init();

      await settings.addRecentTool('calculator');
      await settings.addRecentTool('compass');
      expect(settings.recentTools, isNotEmpty);

      await settings.clearRecentTools();
      expect(settings.recentTools, isEmpty);
    });

    // 6. recentTools 跨實例持久化（SharedPreferences mock）
    test('recent tools persist across instances', () async {
      final settings1 = AppSettings();
      await settings1.init();
      await settings1.addRecentTool('calculator');
      await settings1.addRecentTool('compass');
      await settings1.addRecentTool('flashlight');

      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.recentTools, ['flashlight', 'compass', 'calculator']);
    });

    // 額外：clearRecentTools 後重新實例化，應為空
    test('cleared recent tools do not persist across instances', () async {
      final settings1 = AppSettings();
      await settings1.init();
      await settings1.addRecentTool('calculator');
      await settings1.clearRecentTools();

      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.recentTools, isEmpty);
    });

    // 額外：addRecentTool 觸發 notifyListeners
    test('addRecentTool notifies listeners', () async {
      final settings = AppSettings();
      await settings.init();
      var notifyCount = 0;
      settings.addListener(() => notifyCount++);

      await settings.addRecentTool('calculator');
      expect(notifyCount, 1);

      await settings.addRecentTool('compass');
      expect(notifyCount, 2);
    });

    // 額外：clearRecentTools 觸發 notifyListeners
    test('clearRecentTools notifies listeners', () async {
      final settings = AppSettings();
      await settings.init();
      await settings.addRecentTool('calculator');

      var notified = false;
      settings.addListener(() => notified = true);
      await settings.clearRecentTools();
      expect(notified, isTrue);
    });
  });
}
