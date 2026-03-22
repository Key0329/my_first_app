import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// 計時器通知與音效服務。
///
/// 負責：
/// - 前景結束時播放提示音
/// - 背景結束時顯示本地通知
/// - 啟動計時器時排程通知、取消/重設時取消排程
class TimerNotificationService {
  TimerNotificationService._();

  static final TimerNotificationService instance =
      TimerNotificationService._();

  static const int _timerNotificationId = 0;
  static const String _channelId = 'timer_channel';
  static const String _channelName = '計時器通知';
  static const String _channelDescription = '倒數計時結束提醒';

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _initialized = false;

  /// 初始化通知外掛與時區資料。
  Future<void> init() async {
    if (_initialized) return;

    try {
      // 初始化時區
      tz.initializeTimeZones();

      // Android 初始化設定
      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS/macOS 初始化設定
      const darwinSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
      );

      await _notificationsPlugin.initialize(initSettings);

      // Android 13+ 需要請求通知權限
      if (!kIsWeb && Platform.isAndroid) {
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }

      _initialized = true;
    } catch (e) {
      debugPrint('通知服務初始化失敗: $e');
    }
  }

  /// 播放計時器完成提示音。
  Future<void> playCompletionSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/timer_complete.wav'));
    } catch (e) {
      debugPrint('播放計時器提示音失敗: $e');
    }
  }

  /// 停止提示音播放。
  Future<void> stopSound() async {
    try {
      await _audioPlayer.stop();
    } catch (_) {}
  }

  /// 在指定 [duration] 後排程一則本地通知。
  ///
  /// 當使用者啟動倒數計時器時呼叫此方法。
  Future<void> scheduleTimerNotification(Duration duration) async {
    if (!_initialized) await init();
    if (!_initialized) return; // init failed (e.g. in tests)

    try {
      final scheduledDate =
          tz.TZDateTime.now(tz.local).add(duration);

      const androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      );

      const darwinDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
        macOS: darwinDetails,
      );

      await _notificationsPlugin.zonedSchedule(
        _timerNotificationId,
        '計時器',
        '時間到！',
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint('排程通知失敗: $e');
    }
  }

  /// 取消已排程的計時器通知。
  ///
  /// 當使用者取消或重設計時器時呼叫此方法。
  Future<void> cancelTimerNotification() async {
    if (!_initialized) return;
    try {
      await _notificationsPlugin.cancel(_timerNotificationId);
    } catch (e) {
      debugPrint('取消通知失敗: $e');
    }
  }

  /// 釋放資源。
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
