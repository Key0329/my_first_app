import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/timer_notification_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'pomodoro_timer.dart';

/// 番茄鐘工具頁面。
class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  static const Color _toolColor = Color(0xFFE74C3C);

  final PomodoroTimer _timer = PomodoroTimer();
  final AudioPlayer _noisePlayer = AudioPlayer();
  String? _activeNoise;

  @override
  void initState() {
    super.initState();
    _timer.onPhaseComplete = _onPhaseComplete;
    _timer.loadStats();
    _timer.addListener(_onTimerChanged);
  }

  @override
  void dispose() {
    _timer.removeListener(_onTimerChanged);
    _timer.dispose();
    _noisePlayer.dispose();
    super.dispose();
  }

  void _onTimerChanged() {
    if (mounted) setState(() {});
  }

  void _onPhaseComplete() {
    final l10n = AppLocalizations.of(context)!;
    // 播放提示音
    TimerNotificationService.instance.playCompletionSound();

    // 顯示本地通知
    final isWorkDone = _timer.phase != PomodoroPhase.work; // 已經切換了
    final message =
        isWorkDone ? l10n.pomodoroWorkComplete : l10n.pomodoroBreakComplete;
    TimerNotificationService.instance.init().then((_) {
      // 不用排程 — 直接顯示即時通知比較合適
      // 但 scheduleTimerNotification 需要 duration，改用立即顯示
    });
    // 用 SnackBar 作為前景提示
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _toggleNoise(String noiseId) async {
    if (_activeNoise == noiseId) {
      await _noisePlayer.stop();
      setState(() => _activeNoise = null);
    } else {
      await _noisePlayer.stop();
      await _noisePlayer.setReleaseMode(ReleaseMode.loop);
      await _noisePlayer.play(AssetSource('audio/$noiseId.mp3'));
      setState(() => _activeNoise = noiseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: l10n.pomodoroTitle,
      headerFlex: 3,
      bodyFlex: 4,
      headerChild: _buildTimerDisplay(l10n),
      bodyChild: _buildBody(l10n),
    );
  }

  Widget _buildTimerDisplay(AppLocalizations l10n) {
    final phaseLabel = switch (_timer.phase) {
      PomodoroPhase.work => l10n.pomodoroWork,
      PomodoroPhase.shortBreak => l10n.pomodoroShortBreak,
      PomodoroPhase.longBreak => l10n.pomodoroLongBreak,
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 階段標籤
          Text(
            phaseLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          // 圓形進度環 + 倒數時間
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 進度環
                SizedBox.expand(
                  child: CustomPaint(
                    painter: _CircleProgressPainter(
                      progress: _timer.progress,
                      color: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                ),
                // 時間文字
                Text(
                  _timer.formattedTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w300,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          // 番茄數
          Text(
            l10n.pomodoroSession(
              _timer.completedSessions % PomodoroTimer.sessionsBeforeLongBreak + 1,
              PomodoroTimer.sessionsBeforeLongBreak,
            ),
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── 控制按鈕 ──
          StaggeredFadeIn(
            index: 0,
            totalItems: 5,
            child: _buildControls(l10n),
          ),
          const SizedBox(height: DT.spaceLg),
          // ── 今日統計 ──
          StaggeredFadeIn(
            index: 1,
            totalItems: 5,
            child: _buildStatsCard(l10n, isDark),
          ),
          const SizedBox(height: DT.spaceLg),
          // ── 白噪音 ──
          StaggeredFadeIn(
            index: 2,
            totalItems: 5,
            child: _buildNoiseSelector(l10n, isDark),
          ),
          const SizedBox(height: DT.spaceLg),
          // ── 設定 ──
          StaggeredFadeIn(
            index: 3,
            totalItems: 5,
            child: _buildSettings(l10n, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(AppLocalizations l10n) {
    final isRunning = _timer.state == PomodoroState.running;
    final isPaused = _timer.state == PomodoroState.paused;
    final isIdle = _timer.state == PomodoroState.idle;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Reset
        IconButton.filled(
          onPressed: isIdle ? null : () => _timer.reset(),
          icon: const Icon(Icons.replay),
          tooltip: l10n.pomodoroReset,
          style: IconButton.styleFrom(
            backgroundColor: _toolColor.withValues(alpha: 0.15),
            foregroundColor: _toolColor,
          ),
        ),
        const SizedBox(width: DT.spaceLg),
        // Start / Pause / Resume
        FilledButton.icon(
          onPressed: () {
            if (isRunning) {
              _timer.pause();
            } else {
              _timer.start();
            }
          },
          icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
          label: Text(
            isRunning
                ? l10n.pomodoroPause
                : isPaused
                    ? l10n.pomodoroResume
                    : l10n.pomodoroStart,
          ),
          style: FilledButton.styleFrom(
            backgroundColor: _toolColor,
            padding: const EdgeInsets.symmetric(
              horizontal: DT.space2xl,
              vertical: DT.spaceMd,
            ),
          ),
        ),
        const SizedBox(width: DT.spaceLg),
        // Skip
        IconButton.filled(
          onPressed: isIdle ? null : () => _timer.skip(),
          icon: const Icon(Icons.skip_next),
          tooltip: l10n.pomodoroSkip,
          style: IconButton.styleFrom(
            backgroundColor: _toolColor.withValues(alpha: 0.15),
            foregroundColor: _toolColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(DT.spaceLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : _toolColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(DT.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pomodoroTodayStats,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          Row(
            children: [
              Icon(Icons.local_fire_department,
                  color: _toolColor, size: 20),
              const SizedBox(width: DT.spaceXs),
              Text(l10n.pomodoroTodayCount(_timer.todayCount)),
              const Spacer(),
              Icon(Icons.access_time, color: _toolColor, size: 20),
              const SizedBox(width: DT.spaceXs),
              Text(l10n.pomodoroTodayMinutes(_timer.todayMinutes)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoiseSelector(AppLocalizations l10n, bool isDark) {
    final noises = [
      ('rain', l10n.pomodoroNoiseRain, Icons.water_drop),
      ('cafe', l10n.pomodoroNoiseCafe, Icons.coffee),
      ('forest', l10n.pomodoroNoiseForest, Icons.forest),
    ];

    return Container(
      padding: const EdgeInsets.all(DT.spaceLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : _toolColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(DT.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pomodoroWhiteNoise,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          Wrap(
            spacing: DT.spaceSm,
            children: noises.map((noise) {
              final isActive = _activeNoise == noise.$1;
              return ChoiceChip(
                avatar: Icon(noise.$3, size: 18),
                label: Text(noise.$2),
                selected: isActive,
                onSelected: (_) => _toggleNoise(noise.$1),
                selectedColor: _toolColor.withValues(alpha: 0.2),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings(AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(DT.spaceLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : _toolColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(DT.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pomodoroSettings,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: DT.spaceSm),
          // 工作時長
          _buildDurationSlider(
            label: l10n.pomodoroWorkDuration,
            value: _timer.workMinutes,
            min: 1,
            max: 60,
            onChanged: (v) => _timer.setWorkMinutes(v.round()),
            l10n: l10n,
          ),
          // 短休息
          _buildDurationSlider(
            label: l10n.pomodoroShortBreakDuration,
            value: _timer.shortBreakMinutes,
            min: 1,
            max: 30,
            onChanged: (v) => _timer.setShortBreakMinutes(v.round()),
            l10n: l10n,
          ),
          // 長休息
          _buildDurationSlider(
            label: l10n.pomodoroLongBreakDuration,
            value: _timer.longBreakMinutes,
            min: 5,
            max: 60,
            onChanged: (v) => _timer.setLongBreakMinutes(v.round()),
            l10n: l10n,
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSlider({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<double> onChanged,
    required AppLocalizations l10n,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(
              l10n.pomodoroMinutes(value),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _toolColor,
              ),
            ),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          activeColor: _toolColor,
          onChanged: _timer.state == PomodoroState.idle ? onChanged : null,
        ),
      ],
    );
  }
}

/// 圓形進度環畫筆。
class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;
    const strokeWidth = 6.0;

    // 背景圓
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // 進度弧
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.backgroundColor != backgroundColor;
}
