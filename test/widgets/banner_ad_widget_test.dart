import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/widgets/banner_ad_widget.dart';

Widget _wrap(Widget child, ProService proService) {
  return ChangeNotifierProvider<ProService>.value(
    value: proService,
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('BannerAdWidget', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Pro 用戶顯示 banner_ad_empty（零高度）', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': true});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(const BannerAdWidget(), proService));

      // Pro 用戶：顯示 banner_ad_empty（SizedBox.shrink 或廣告未載入時的佔位）
      expect(find.byKey(const Key('banner_ad_empty')), findsOneWidget);
      // 確認不顯示廣告容器
      expect(find.byKey(const Key('banner_ad_container')), findsNothing);
    });

    testWidgets('免費用戶渲染不崩潰（AdMob 測試環境無法載入廣告）', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(const BannerAdWidget(), proService));
      // AdMob 在測試環境無法載入，會顯示 banner_ad_empty
      expect(find.byKey(const Key('banner_ad_empty')), findsOneWidget);
    });

    testWidgets('isPro 從 false 切換為 true 時 banner 消失', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(const BannerAdWidget(), proService));
      // 升級前：顯示 empty（因 AdMob 無法在測試中載入）
      expect(find.byKey(const Key('banner_ad_empty')), findsOneWidget);

      // 升級為 Pro
      await proService.setPro(true);
      await tester.pump();

      // 升級後：仍顯示 empty（Pro 狀態下直接回傳 shrink）
      expect(find.byKey(const Key('banner_ad_empty')), findsOneWidget);
      expect(find.byKey(const Key('banner_ad_container')), findsNothing);
    });
  });
}
