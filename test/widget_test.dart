import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/app.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() {
  testWidgets('App renders with tool grid', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = AppSettings();
    await settings.init();
    await tester.pumpWidget(ToolboxApp(settings: settings));
    await tester.pumpAndSettle();

    expect(find.text('工具箱 Pro'), findsOneWidget);
    expect(find.text('計算機'), findsOneWidget);
  });
}
