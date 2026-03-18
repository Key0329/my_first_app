import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/stopwatch_timer/stopwatch_timer_page.dart';

void main() {
  group('formatDuration', () {
    test('zero duration', () {
      expect(formatDuration(Duration.zero), equals('00:00:00.00'));
    });

    test('only centiseconds', () {
      expect(
        formatDuration(const Duration(milliseconds: 50)),
        equals('00:00:00.05'),
      );
    });

    test('only seconds', () {
      expect(
        formatDuration(const Duration(seconds: 7)),
        equals('00:00:07.00'),
      );
    });

    test('only minutes', () {
      expect(
        formatDuration(const Duration(minutes: 5)),
        equals('00:05:00.00'),
      );
    });

    test('only hours', () {
      expect(
        formatDuration(const Duration(hours: 2)),
        equals('02:00:00.00'),
      );
    });

    test('mixed duration', () {
      expect(
        formatDuration(
          const Duration(hours: 1, minutes: 23, seconds: 45, milliseconds: 670),
        ),
        equals('01:23:45.67'),
      );
    });

    test('maximum typical stopwatch value', () {
      expect(
        formatDuration(
          const Duration(hours: 99, minutes: 59, seconds: 59, milliseconds: 990),
        ),
        equals('99:59:59.99'),
      );
    });

    test('rounds down centiseconds (truncates)', () {
      // 123 ms -> 12 centiseconds (integer division)
      expect(
        formatDuration(const Duration(milliseconds: 123)),
        equals('00:00:00.12'),
      );
    });

    test('999 milliseconds shows 99 centiseconds', () {
      expect(
        formatDuration(const Duration(milliseconds: 999)),
        equals('00:00:00.99'),
      );
    });

    test('single digit values are zero-padded', () {
      expect(
        formatDuration(
          const Duration(hours: 1, minutes: 2, seconds: 3, milliseconds: 40),
        ),
        equals('01:02:03.04'),
      );
    });
  });

  group('LapRecord', () {
    test('stores number, lapTime, and totalTime', () {
      const lap = LapRecord(
        number: 1,
        lapTime: Duration(seconds: 30),
        totalTime: Duration(seconds: 30),
      );
      expect(lap.number, equals(1));
      expect(lap.lapTime, equals(const Duration(seconds: 30)));
      expect(lap.totalTime, equals(const Duration(seconds: 30)));
    });

    test('second lap has different lap and total times', () {
      const lap = LapRecord(
        number: 2,
        lapTime: Duration(seconds: 15),
        totalTime: Duration(seconds: 45),
      );
      expect(lap.number, equals(2));
      expect(lap.lapTime, equals(const Duration(seconds: 15)));
      expect(lap.totalTime, equals(const Duration(seconds: 45)));
    });
  });
}
