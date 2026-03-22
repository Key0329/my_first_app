import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

/// 番茄鐘階段類型。
enum PomodoroPhase { work, shortBreak, longBreak }

/// 番茄鐘計時器狀態。
enum PomodoroState { idle, running, paused }

/// 番茄鐘計時器，使用 ChangeNotifier 讓 UI 響應。
class PomodoroTimer extends ChangeNotifier {
  /// 可自訂的時長（分鐘）。
  int workMinutes;
  int shortBreakMinutes;
  int longBreakMinutes;

  /// 每幾個工作階段後進入長休息。
  static const int sessionsBeforeLongBreak = 4;

  PomodoroTimer({
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
  });

  // ── 狀態 ──
  PomodoroState _state = PomodoroState.idle;
  PomodoroPhase _phase = PomodoroPhase.work;
  int _remainingSeconds = 25 * 60;
  int _completedSessions = 0;
  Timer? _timer;

  // ── 今日統計 ──
  int _todayCount = 0;
  int _todayMinutes = 0;
  String _todayDate = '';

  // ── 階段結束回調 ──
  VoidCallback? onPhaseComplete;

  // ── Getters ──
  PomodoroState get state => _state;
  PomodoroPhase get phase => _phase;
  int get remainingSeconds => _remainingSeconds;
  int get completedSessions => _completedSessions;
  int get todayCount => _todayCount;
  int get todayMinutes => _todayMinutes;

  /// 當前階段的總秒數。
  int get totalSeconds {
    switch (_phase) {
      case PomodoroPhase.work:
        return workMinutes * 60;
      case PomodoroPhase.shortBreak:
        return shortBreakMinutes * 60;
      case PomodoroPhase.longBreak:
        return longBreakMinutes * 60;
    }
  }

  /// 進度比例（0.0 ~ 1.0）。
  double get progress {
    if (totalSeconds == 0) return 0;
    return 1.0 - (_remainingSeconds / totalSeconds);
  }

  /// 格式化剩餘時間為 MM:SS。
  String get formattedTime {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  /// 載入今日統計。
  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final savedDate = prefs.getString('pomodoro_today_date') ?? '';

    if (savedDate == today) {
      _todayCount = prefs.getInt('pomodoro_today_count') ?? 0;
      _todayMinutes = prefs.getInt('pomodoro_today_minutes') ?? 0;
    } else {
      // 新的一天，歸零
      _todayCount = 0;
      _todayMinutes = 0;
    }
    _todayDate = today;
    _remainingSeconds = workMinutes * 60;
    notifyListeners();
  }

  Future<void> _saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pomodoro_today_date', _todayDate);
    await prefs.setInt('pomodoro_today_count', _todayCount);
    await prefs.setInt('pomodoro_today_minutes', _todayMinutes);
  }

  /// 開始計時。
  void start() {
    if (_state == PomodoroState.running) return;
    if (_state == PomodoroState.idle) {
      _remainingSeconds = totalSeconds;
    }
    _state = PomodoroState.running;
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    notifyListeners();
  }

  /// 暫停計時。
  void pause() {
    if (_state != PomodoroState.running) return;
    _timer?.cancel();
    _timer = null;
    _state = PomodoroState.paused;
    notifyListeners();
  }

  /// 重設當前階段。
  void reset() {
    _timer?.cancel();
    _timer = null;
    _state = PomodoroState.idle;
    _remainingSeconds = totalSeconds;
    notifyListeners();
  }

  /// 跳過當前階段（不計入統計）。
  void skip() {
    _timer?.cancel();
    _timer = null;
    _state = PomodoroState.idle;
    _advancePhase(completed: false);
    notifyListeners();
  }

  /// 更新工作時長。
  void setWorkMinutes(int minutes) {
    workMinutes = minutes;
    if (_phase == PomodoroPhase.work && _state == PomodoroState.idle) {
      _remainingSeconds = workMinutes * 60;
      notifyListeners();
    }
  }

  /// 更新短休息時長。
  void setShortBreakMinutes(int minutes) {
    shortBreakMinutes = minutes;
    if (_phase == PomodoroPhase.shortBreak && _state == PomodoroState.idle) {
      _remainingSeconds = shortBreakMinutes * 60;
      notifyListeners();
    }
  }

  /// 更新長休息時長。
  void setLongBreakMinutes(int minutes) {
    longBreakMinutes = minutes;
    if (_phase == PomodoroPhase.longBreak && _state == PomodoroState.idle) {
      _remainingSeconds = longBreakMinutes * 60;
      notifyListeners();
    }
  }

  void _tick(Timer timer) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      notifyListeners();
    } else {
      timer.cancel();
      _timer = null;
      _state = PomodoroState.idle;
      _advancePhase(completed: true);
      onPhaseComplete?.call();
      notifyListeners();
    }
  }

  void _advancePhase({required bool completed}) {
    if (_phase == PomodoroPhase.work && completed) {
      _completedSessions++;
      _todayCount++;
      _todayMinutes += workMinutes;
      _saveStats();

      if (_completedSessions % sessionsBeforeLongBreak == 0) {
        _phase = PomodoroPhase.longBreak;
      } else {
        _phase = PomodoroPhase.shortBreak;
      }
    } else if (_phase == PomodoroPhase.work && !completed) {
      // Skipped work — go to break without counting
      if ((_completedSessions + 1) % sessionsBeforeLongBreak == 0) {
        _phase = PomodoroPhase.longBreak;
      } else {
        _phase = PomodoroPhase.shortBreak;
      }
    } else {
      // Rest phase done or skipped → go to work
      _phase = PomodoroPhase.work;
    }
    _remainingSeconds = totalSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
