import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/pomodoro/pomodoro_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 完成一個 25 分鐘 work phase 所需的時間。
/// _tick 邏輯：remainingSeconds > 0 才遞減；
/// 所以需要 totalSeconds 次 tick 降到 0，再一次 tick 觸發 phase complete。
const _kOneWorkPhase = Duration(seconds: 25 * 60 + 1);

/// 完成一個 5 分鐘 shortBreak 所需的時間。
const _kOneShortBreak = Duration(seconds: 5 * 60 + 1);

/// 完成一個 15 分鐘 longBreak 所需的時間。
const _kOneLongBreak = Duration(seconds: 15 * 60 + 1);

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // ── 1. 初始狀態 ──────────────────────────────────────────────────────────
  group('初始狀態', () {
    test('state 為 idle', () {
      final timer = PomodoroTimer();
      expect(timer.state, PomodoroState.idle);
      timer.dispose();
    });

    test('phase 為 work', () {
      final timer = PomodoroTimer();
      expect(timer.phase, PomodoroPhase.work);
      timer.dispose();
    });

    test('remainingSeconds 為 25 * 60', () {
      final timer = PomodoroTimer();
      expect(timer.remainingSeconds, equals(25 * 60));
      timer.dispose();
    });

    test('totalSeconds 為 25 * 60', () {
      final timer = PomodoroTimer();
      expect(timer.totalSeconds, equals(25 * 60));
      timer.dispose();
    });

    test('completedSessions 為 0', () {
      final timer = PomodoroTimer();
      expect(timer.completedSessions, equals(0));
      timer.dispose();
    });
  });

  // ── 2. start() ──────────────────────────────────────────────────────────
  group('start()', () {
    test('state 變為 running', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        expect(timer.state, PomodoroState.running);
        async.elapse(const Duration(seconds: 1));
      });
      timer.dispose();
    });

    test('重複呼叫 start() 不會有副作用', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        timer.start(); // 第二次應被忽略
        expect(timer.state, PomodoroState.running);
        async.elapse(const Duration(seconds: 1));
      });
      timer.dispose();
    });

    test('每秒 tick 一次，remainingSeconds 遞減', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 3));
        expect(timer.remainingSeconds, equals(25 * 60 - 3));
      });
      timer.dispose();
    });

    test('從 paused 繼續 start() 不重置時間', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 10));
        timer.pause();
        final remaining = timer.remainingSeconds;
        timer.start();
        expect(timer.state, PomodoroState.running);
        expect(timer.remainingSeconds, equals(remaining));
      });
      timer.dispose();
    });
  });

  // ── 3. pause() ──────────────────────────────────────────────────────────
  group('pause()', () {
    test('state 變為 paused', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 5));
        timer.pause();
        expect(timer.state, PomodoroState.paused);
      });
      timer.dispose();
    });

    test('暫停後 remainingSeconds 不再減少', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 5));
        timer.pause();
        final remaining = timer.remainingSeconds;
        async.elapse(const Duration(seconds: 10));
        expect(timer.remainingSeconds, equals(remaining));
      });
      timer.dispose();
    });

    test('idle 狀態呼叫 pause() 不改變狀態', () {
      final timer = PomodoroTimer();
      timer.pause();
      expect(timer.state, PomodoroState.idle);
      timer.dispose();
    });
  });

  // ── 4. reset() ──────────────────────────────────────────────────────────
  group('reset()', () {
    test('state 變為 idle', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 5));
        timer.reset();
        expect(timer.state, PomodoroState.idle);
      });
      timer.dispose();
    });

    test('remainingSeconds 重置為 totalSeconds', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 30));
        timer.reset();
        expect(timer.remainingSeconds, equals(timer.totalSeconds));
      });
      timer.dispose();
    });

    test('reset 後不再有 tick', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 5));
        timer.reset();
        final remaining = timer.remainingSeconds;
        async.elapse(const Duration(seconds: 5));
        expect(timer.remainingSeconds, equals(remaining));
      });
      timer.dispose();
    });

    test('paused 狀態 reset() 也能正常運作', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 10));
        timer.pause();
        timer.reset();
        expect(timer.state, PomodoroState.idle);
        expect(timer.remainingSeconds, equals(25 * 60));
      });
      timer.dispose();
    });
  });

  // ── 5. skip() ──────────────────────────────────────────────────────────
  group('skip()', () {
    test('work → shortBreak（第一次跳過）', () {
      final timer = PomodoroTimer();
      timer.skip();
      expect(timer.phase, PomodoroPhase.shortBreak);
      expect(timer.state, PomodoroState.idle);
      timer.dispose();
    });

    test('shortBreak → work', () {
      final timer = PomodoroTimer();
      timer.skip(); // work → shortBreak
      timer.skip(); // shortBreak → work
      expect(timer.phase, PomodoroPhase.work);
      timer.dispose();
    });

    test('skip 不計入 completedSessions', () {
      final timer = PomodoroTimer();
      timer.skip();
      expect(timer.completedSessions, equals(0));
      timer.dispose();
    });

    test('skip 後 state 為 idle', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 10));
        timer.skip();
        expect(timer.state, PomodoroState.idle);
      });
      timer.dispose();
    });

    test('skip 後 remainingSeconds 更新為新階段的 totalSeconds', () {
      final timer = PomodoroTimer();
      timer.skip(); // work → shortBreak
      expect(timer.remainingSeconds, equals(timer.shortBreakMinutes * 60));
      timer.dispose();
    });
  });

  // ── 6. 階段循環（Phase cycling）──────────────────────────────────────────
  group('階段循環', () {
    test('完成第 1 個 work → shortBreak', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(_kOneWorkPhase);
        expect(timer.phase, PomodoroPhase.shortBreak);
        expect(timer.completedSessions, equals(1));
      });
      timer.dispose();
    });

    test('完成第 1 個 work → shortBreak，完成後 → work（第 2 個）', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        // 第 1 個 work
        timer.start();
        async.elapse(_kOneWorkPhase);
        expect(timer.phase, PomodoroPhase.shortBreak);

        // shortBreak
        timer.start();
        async.elapse(_kOneShortBreak);
        expect(timer.phase, PomodoroPhase.work);
      });
      timer.dispose();
    });

    test('完成 4 個 work session 後進入 longBreak', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        for (var i = 0; i < 4; i++) {
          timer.start();
          async.elapse(_kOneWorkPhase);
          if (i < 3) {
            timer.start();
            async.elapse(_kOneShortBreak);
          }
        }
        expect(timer.completedSessions, equals(4));
        expect(timer.phase, PomodoroPhase.longBreak);
      });
      timer.dispose();
    });

    test('sessionsBeforeLongBreak 為 4', () {
      expect(PomodoroTimer.sessionsBeforeLongBreak, equals(4));
    });

    test('完成 4 work 後 longBreak，longBreak 完成後回到 work', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        // 完成 4 個 work（中間夾 3 個 shortBreak）
        for (var i = 0; i < 4; i++) {
          timer.start();
          async.elapse(_kOneWorkPhase);
          if (i < 3) {
            timer.start();
            async.elapse(_kOneShortBreak);
          }
        }
        expect(timer.phase, PomodoroPhase.longBreak);

        // 完成 longBreak → 回到 work
        timer.start();
        async.elapse(_kOneLongBreak);
        expect(timer.phase, PomodoroPhase.work);
      });
      timer.dispose();
    });
  });

  // ── 7. formattedTime ─────────────────────────────────────────────────────
  group('formattedTime', () {
    test('預設顯示 "25:00"', () {
      final timer = PomodoroTimer();
      expect(timer.formattedTime, equals('25:00'));
      timer.dispose();
    });

    test('59 秒顯示 "00:59"', () {
      final timer = PomodoroTimer(workMinutes: 1);
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 1));
        expect(timer.formattedTime, equals('00:59'));
      });
      timer.dispose();
    });

    test('1分30秒剩餘顯示 "01:30"', () {
      final timer = PomodoroTimer(workMinutes: 5);
      fakeAsync((async) {
        timer.start();
        // 5 分鐘 = 300 秒，減去 90 秒後剩 210 秒 = 3:30
        // 減去 3.5 分鐘後剩 1.5 分鐘 = 1:30
        async.elapse(const Duration(minutes: 3, seconds: 30));
        expect(timer.formattedTime, equals('01:30'));
      });
      timer.dispose();
    });

    test('shortBreak 初始顯示 "05:00"', () {
      final timer = PomodoroTimer();
      timer.skip(); // work → shortBreak
      expect(timer.formattedTime, equals('05:00'));
      timer.dispose();
    });
  });

  // ── 8. setWorkMinutes() ──────────────────────────────────────────────────
  group('setWorkMinutes()', () {
    test('idle 時更新工作時長並同步 remainingSeconds', () {
      final timer = PomodoroTimer();
      timer.setWorkMinutes(30);
      expect(timer.workMinutes, equals(30));
      expect(timer.remainingSeconds, equals(30 * 60));
      timer.dispose();
    });

    test('running 時不同步 remainingSeconds', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 5));
        final remaining = timer.remainingSeconds;
        timer.setWorkMinutes(30);
        expect(timer.workMinutes, equals(30));
        // remainingSeconds 應維持計時中的值，不被重設
        expect(timer.remainingSeconds, equals(remaining));
      });
      timer.dispose();
    });

    test('shortBreak phase 時 setWorkMinutes 不影響 remainingSeconds', () {
      final timer = PomodoroTimer();
      timer.skip(); // work → shortBreak
      timer.setWorkMinutes(30);
      expect(timer.remainingSeconds, equals(5 * 60)); // 仍為 shortBreak 時長
      timer.dispose();
    });
  });

  // ── 9. setShortBreakMinutes() ────────────────────────────────────────────
  group('setShortBreakMinutes()', () {
    test('idle + shortBreak phase 時同步 remainingSeconds', () {
      final timer = PomodoroTimer();
      timer.skip(); // work → shortBreak
      timer.setShortBreakMinutes(10);
      expect(timer.shortBreakMinutes, equals(10));
      expect(timer.remainingSeconds, equals(10 * 60));
      timer.dispose();
    });
  });

  // ── 10. setLongBreakMinutes() ────────────────────────────────────────────
  group('setLongBreakMinutes()', () {
    test('idle + longBreak phase 時同步 remainingSeconds', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        // 完成 4 個 work（中間夾 3 個 shortBreak）以進入 longBreak
        for (var i = 0; i < 4; i++) {
          timer.start();
          async.elapse(_kOneWorkPhase);
          if (i < 3) {
            timer.start();
            async.elapse(_kOneShortBreak);
          }
        }
        expect(timer.phase, PomodoroPhase.longBreak);
        timer.setLongBreakMinutes(20);
        expect(timer.longBreakMinutes, equals(20));
        expect(timer.remainingSeconds, equals(20 * 60));
      });
      timer.dispose();
    });
  });

  // ── 11. progress ─────────────────────────────────────────────────────────
  group('progress', () {
    test('idle 時 progress 為 0', () {
      final timer = PomodoroTimer();
      // idle 狀態：remainingSeconds == totalSeconds，1 - (total/total) = 0
      expect(timer.progress, equals(0.0));
      timer.dispose();
    });

    test('計時到一半時 progress 約為 0.5', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(minutes: 12, seconds: 30));
        expect(timer.progress, closeTo(0.5, 0.01));
      });
      timer.dispose();
    });

    test('remainingSeconds 為 0 時 progress 為 1.0', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        // 讓秒數剛好降到 0（totalSeconds 次 tick）
        async.elapse(const Duration(seconds: 25 * 60));
        expect(timer.remainingSeconds, equals(0));
        expect(timer.progress, equals(1.0));
      });
      timer.dispose();
    });
  });

  // ── 12. onPhaseComplete 回調 ─────────────────────────────────────────────
  group('onPhaseComplete 回調', () {
    test('phase 結束時觸發 onPhaseComplete', () {
      final timer = PomodoroTimer(workMinutes: 1);
      var callCount = 0;
      timer.onPhaseComplete = () => callCount++;

      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 1 * 60 + 1));
        expect(callCount, equals(1));
      });
      timer.dispose();
    });

    test('未設定 onPhaseComplete 不拋錯', () {
      final timer = PomodoroTimer(workMinutes: 1);
      timer.onPhaseComplete = null;

      fakeAsync((async) {
        expect(
          () {
            timer.start();
            async.elapse(const Duration(seconds: 1 * 60 + 1));
          },
          returnsNormally,
        );
      });
      timer.dispose();
    });
  });

  // ── 13. loadStats() ──────────────────────────────────────────────────────
  group('loadStats()', () {
    test('第一次載入 todayCount 和 todayMinutes 為 0', () async {
      SharedPreferences.setMockInitialValues({});
      final timer = PomodoroTimer();
      await timer.loadStats();
      expect(timer.todayCount, equals(0));
      expect(timer.todayMinutes, equals(0));
      timer.dispose();
    });

    test('同一天載入已儲存的統計', () async {
      final today = _todayDateString();
      SharedPreferences.setMockInitialValues({
        'pomodoro_today_date': today,
        'pomodoro_today_count': 3,
        'pomodoro_today_minutes': 75,
      });
      final timer = PomodoroTimer();
      await timer.loadStats();
      expect(timer.todayCount, equals(3));
      expect(timer.todayMinutes, equals(75));
      timer.dispose();
    });

    test('日期不同時歸零統計', () async {
      SharedPreferences.setMockInitialValues({
        'pomodoro_today_date': '2000-01-01',
        'pomodoro_today_count': 5,
        'pomodoro_today_minutes': 125,
      });
      final timer = PomodoroTimer();
      await timer.loadStats();
      expect(timer.todayCount, equals(0));
      expect(timer.todayMinutes, equals(0));
      timer.dispose();
    });

    test('loadStats 後 remainingSeconds 更新為 workMinutes * 60', () async {
      SharedPreferences.setMockInitialValues({});
      final timer = PomodoroTimer(workMinutes: 30);
      await timer.loadStats();
      expect(timer.remainingSeconds, equals(30 * 60));
      timer.dispose();
    });
  });

  // ── 14. ChangeNotifier 通知 ──────────────────────────────────────────────
  group('ChangeNotifier', () {
    test('start() 觸發 notifyListeners', () {
      final timer = PomodoroTimer();
      var notified = false;
      timer.addListener(() => notified = true);

      fakeAsync((async) {
        timer.start();
        expect(notified, isTrue);
        async.elapse(const Duration(seconds: 1));
      });
      timer.dispose();
    });

    test('pause() 觸發 notifyListeners', () {
      final timer = PomodoroTimer();
      fakeAsync((async) {
        timer.start();
        async.elapse(const Duration(seconds: 1));
        var notified = false;
        timer.addListener(() => notified = true);
        timer.pause();
        expect(notified, isTrue);
      });
      timer.dispose();
    });

    test('reset() 觸發 notifyListeners', () {
      final timer = PomodoroTimer();
      var notified = false;
      timer.addListener(() => notified = true);
      timer.reset();
      expect(notified, isTrue);
      timer.dispose();
    });

    test('skip() 觸發 notifyListeners', () {
      final timer = PomodoroTimer();
      var notified = false;
      timer.addListener(() => notified = true);
      timer.skip();
      expect(notified, isTrue);
      timer.dispose();
    });
  });
}

/// 回傳今天的日期字串（與 PomodoroTimer._todayDate 格式一致：yyyy-MM-dd）。
String _todayDateString() {
  final now = DateTime.now();
  final y = now.year.toString().padLeft(4, '0');
  final m = now.month.toString().padLeft(2, '0');
  final d = now.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}
