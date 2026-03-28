import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/pro_service.dart';

void main() {
  group('ProService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('預設值為 false（free user）', () async {
      final service = ProService();
      await service.init();
      expect(service.isPro, isFalse);
    });

    test('setPro(true) 持久化並通知 listeners', () async {
      final service = ProService();
      await service.init();
      var notified = false;
      service.addListener(() => notified = true);

      await service.setPro(true);

      expect(service.isPro, isTrue);
      expect(notified, isTrue);
    });

    test('setPro(false) 持久化並通知 listeners', () async {
      SharedPreferences.setMockInitialValues({'is_pro': true});
      final service = ProService();
      await service.init();
      var notified = false;
      service.addListener(() => notified = true);

      await service.setPro(false);

      expect(service.isPro, isFalse);
      expect(notified, isTrue);
    });

    test('init() 讀取持久化狀態 — Pro user 重啟 App', () async {
      SharedPreferences.setMockInitialValues({'is_pro': true});
      final service = ProService();
      await service.init();
      expect(service.isPro, isTrue);
    });

    test('setPro(true) 後重新初始化仍為 true', () async {
      final service1 = ProService();
      await service1.init();
      await service1.setPro(true);

      // 模擬 App 重啟（同一個 mock prefs，值已持久化）
      final service2 = ProService();
      await service2.init();
      expect(service2.isPro, isTrue);
    });
  });
}
