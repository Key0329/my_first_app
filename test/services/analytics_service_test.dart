import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/services/analytics_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AnalyticsService', () {
    test('instance is a singleton of correct type', () {
      final instance = AnalyticsService.instance;
      expect(instance, isA<AnalyticsService>());
      expect(identical(instance, AnalyticsService.instance), isTrue);
    });

    test('logToolOpen does not throw without Firebase', () {
      expect(
        () => AnalyticsService.instance.logToolOpen(
          toolId: 'calculator',
          source: 'home',
        ),
        returnsNormally,
      );
    });

    test('logToolComplete does not throw without Firebase', () {
      expect(
        () => AnalyticsService.instance.logToolComplete(
          toolId: 'bmi_calculator',
          resultType: 'bmi_calculated',
        ),
        returnsNormally,
      );
    });

    test('logToolShare does not throw without Firebase', () {
      expect(
        () => AnalyticsService.instance.logToolShare(
          toolId: 'split_bill',
          shareMethod: 'system_share',
        ),
        returnsNormally,
      );
    });

    test('logTabSwitch does not throw without Firebase', () {
      expect(
        () => AnalyticsService.instance.logTabSwitch(tabName: 'favorites'),
        returnsNormally,
      );
    });

    test('logScreenView does not throw without Firebase', () {
      expect(
        () => AnalyticsService.instance.logScreenView(
          screenName: '/tools/calculator',
        ),
        returnsNormally,
      );
    });
  });
}
