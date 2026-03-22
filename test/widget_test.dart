import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/app.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() {
  testWidgets('App renders with tool grid', (WidgetTester tester) async {
    // 設定 hasCompletedOnboarding = true 讓 App 直接進入工具首頁，略過 onboarding
    SharedPreferences.setMockInitialValues({'hasCompletedOnboarding': true});
    final settings = AppSettings();
    await settings.init();
    await tester.pumpWidget(ToolboxApp(settings: settings));
    await tester.pumpAndSettle();

    expect(find.text('工具箱'), findsOneWidget);
    expect(find.text('計算機'), findsOneWidget);
  });
}
