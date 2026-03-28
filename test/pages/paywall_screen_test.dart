import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';
import 'package:my_first_app/pages/paywall_screen.dart';

Widget _wrap({required ProService proService}) {
  final iapService = InAppPurchaseService(proService: proService);
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ProService>.value(value: proService),
      Provider<InAppPurchaseService>.value(value: iapService),
    ],
    child: const MaterialApp(
      home: Scaffold(body: PaywallScreen()),
    ),
  );
}

void main() {
  group('PaywallScreen', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('免費用戶顯示升級 CTA 按鈕', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(proService: proService));
      await tester.pump();

      expect(find.byKey(const Key('paywall_upgrade_button')), findsOneWidget);
    });

    testWidgets('顯示「回復購買」連結', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(proService: proService));
      await tester.pump();

      expect(find.byKey(const Key('paywall_restore_button')), findsOneWidget);
    });

    testWidgets('顯示 NT\$90 定價文字', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(proService: proService));
      await tester.pump();

      expect(find.textContaining('90'), findsWidgets);
    });

    testWidgets('顯示三項 Pro 功能說明', (tester) async {
      SharedPreferences.setMockInitialValues({'is_pro': false});
      final proService = ProService();
      await proService.init();

      await tester.pumpWidget(_wrap(proService: proService));
      await tester.pump();

      expect(
        find.byKey(const Key('paywall_feature_list')),
        findsOneWidget,
      );
    });
  });
}
