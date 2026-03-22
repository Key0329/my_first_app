import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/services/timer_notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock audioplayers platform channels before singleton creation
  setUpAll(() {
    for (final channel in [
      'xyz.luan/audioplayers',
      'xyz.luan/audioplayers.global',
    ]) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        MethodChannel(channel),
        (MethodCall methodCall) async => null,
      );
    }
  });

  group('TimerNotificationService', () {
    test('instance is a singleton of correct type', () {
      final instance = TimerNotificationService.instance;
      expect(instance, isA<TimerNotificationService>());
      expect(identical(instance, TimerNotificationService.instance), isTrue);
    });

    test('cancelTimerNotification returns early before init', () {
      // _initialized is false, should return early without error
      expect(
        () => TimerNotificationService.instance.cancelTimerNotification(),
        returnsNormally,
      );
    });
  });
}
