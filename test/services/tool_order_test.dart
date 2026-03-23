import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/user_preferences_service.dart';

void main() {
  group('UserPreferencesService — toolOrder', () {
    // 輔助：建立已呼叫 loadFromPrefs 的 service 實例
    Future<UserPreferencesService> buildService() async {
      final prefs = await SharedPreferences.getInstance();
      final service = UserPreferencesService(prefs);
      service.loadFromPrefs();
      return service;
    }

    // 1. 預設 toolOrder 為空清單
    test('toolOrder defaults to empty list', () async {
      SharedPreferences.setMockInitialValues({});
      final service = await buildService();
      expect(service.toolOrder, isEmpty);
    });

    // 2. 沒有儲存排序時，getOrderedToolIds 原樣回傳 allToolIds
    test(
      'getOrderedToolIds returns allToolIds unchanged when no saved order',
      () async {
        SharedPreferences.setMockInitialValues({});
        final service = await buildService();

        const all = ['calculator', 'compass', 'flashlight'];
        expect(service.getOrderedToolIds(all), equals(all));
      },
    );

    // 3. 根據儲存的排序重新排列工具
    test('getOrderedToolIds reorders based on saved order', () async {
      SharedPreferences.setMockInitialValues({
        'tool_order': ['flashlight', 'calculator', 'compass'],
      });
      final service = await buildService();

      const all = ['calculator', 'compass', 'flashlight'];
      expect(
        service.getOrderedToolIds(all),
        equals(['flashlight', 'calculator', 'compass']),
      );
    });

    // 4. 不在排序中的新工具附加到尾部
    test('getOrderedToolIds appends new tools not in saved order', () async {
      SharedPreferences.setMockInitialValues({
        'tool_order': ['calculator', 'compass'],
      });
      final service = await buildService();

      const all = ['calculator', 'compass', 'flashlight', 'ruler'];
      final result = service.getOrderedToolIds(all);
      expect(result.first, 'calculator');
      expect(result[1], 'compass');
      // 新工具保持原始相對順序附加到尾部
      expect(result[2], 'flashlight');
      expect(result[3], 'ruler');
      expect(result.length, 4);
    });

    // 5. 儲存排序中不存在於 allToolIds 的 ID 應被忽略
    test(
      'getOrderedToolIds ignores saved IDs not present in allToolIds',
      () async {
        SharedPreferences.setMockInitialValues({
          'tool_order': ['deleted_tool', 'calculator', 'another_gone'],
        });
        final service = await buildService();

        const all = ['calculator', 'compass'];
        final result = service.getOrderedToolIds(all);
        // deleted_tool 和 another_gone 不在 all 中，應被略過
        expect(result, isNot(contains('deleted_tool')));
        expect(result, isNot(contains('another_gone')));
        // calculator 排在第一位（saved order 中的有效項目）
        expect(result.first, 'calculator');
        // compass 附加到尾部
        expect(result[1], 'compass');
        expect(result.length, 2);
      },
    );

    // 6. setToolOrder 儲存並觸發 notifyListeners
    test('setToolOrder saves order and notifies listeners', () async {
      SharedPreferences.setMockInitialValues({});
      final service = await buildService();

      var notifyCount = 0;
      service.addListener(() => notifyCount++);

      await service.setToolOrder(['compass', 'calculator', 'flashlight']);

      // 通知已觸發
      expect(notifyCount, 1);
      // 記憶體狀態已更新
      expect(
        service.toolOrder,
        equals(['compass', 'calculator', 'flashlight']),
      );

      // 驗證已寫入 SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(
        prefs.getStringList('tool_order'),
        equals(['compass', 'calculator', 'flashlight']),
      );
    });

    // 7. loadFromPrefs 從 SharedPreferences 還原已儲存的排序
    test('loadFromPrefs restores saved tool order', () async {
      SharedPreferences.setMockInitialValues({
        'tool_order': ['ruler', 'bmi', 'calculator'],
      });
      final service = await buildService();

      expect(service.toolOrder, equals(['ruler', 'bmi', 'calculator']));
    });
  });
}
