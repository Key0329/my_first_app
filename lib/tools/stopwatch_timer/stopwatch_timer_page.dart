import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_app/services/timer_notification_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/confirm_dialog.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

/// 碼錶/計時器的漸層色
final List<Color> _stopwatchGradient =
    toolGradients['stopwatch_timer'] ?? [const Color(0xFFF59E0B), const Color(0xFFFBBF24)];

/// Formats a [Duration] as HH:MM:SS.mm (centiseconds).
String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);
  final centiseconds = (d.inMilliseconds.remainder(1000)) ~/ 10;
  return '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}.'
      '${centiseconds.toString().padLeft(2, '0')}';
}

/// A lap entry recorded while the stopwatch is running.
class LapRecord {
  final int number;
  final Duration lapTime;
  final Duration totalTime;

  const LapRecord({
    required this.number,
    required this.lapTime,
    required this.totalTime,
  });
}

/// The Stopwatch & Timer tool page with two tabs.
class StopwatchTimerPage extends StatelessWidget {
  const StopwatchTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ImmersiveToolScaffold(
        toolColor: const Color(0xFF607D8B),
        title: '碼錶 / 計時器',
        heroTag: 'tool_hero_stopwatch_timer',
        headerFlex: 1,
        bodyFlex: 3,
        headerChild: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.timer_outlined), text: '碼錶'),
                Tab(icon: Icon(Icons.hourglass_bottom), text: '計時器'),
              ],
              labelColor: Theme.of(context).colorScheme.onSurface,
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onSurfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        bodyChild: const TabBarView(
          children: [
            _StopwatchTab(),
            _TimerTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stopwatch Tab
// ---------------------------------------------------------------------------

class _StopwatchTab extends StatefulWidget {
  const _StopwatchTab();

  @override
  State<_StopwatchTab> createState() => _StopwatchTabState();
}

class _StopwatchTabState extends State<_StopwatchTab> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  final List<LapRecord> _laps = [];
  Duration _lastLapTotal = Duration.zero;

  void _start() {
    _stopwatch.start();
    _ticker = Timer.periodic(const Duration(milliseconds: 30), (_) {
      setState(() {
        _elapsed = _stopwatch.elapsed;
      });
    });
    setState(() {});
  }

  void _stop() {
    _stopwatch.stop();
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _elapsed = _stopwatch.elapsed;
    });
  }

  Future<void> _confirmReset() async {
    if (_elapsed == Duration.zero && _laps.isEmpty) {
      _reset();
      return;
    }
    final confirmed = await showConfirmDialog(
      context: context,
      title: '重設碼錶',
      message: '確定要重設碼錶嗎？計時與圈數記錄將被清除。',
      confirmLabel: '重設',
    );
    if (confirmed) _reset();
  }

  void _reset() {
    _stopwatch.reset();
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _elapsed = Duration.zero;
      _laps.clear();
      _lastLapTotal = Duration.zero;
    });
  }

  void _lap() {
    final total = _stopwatch.elapsed;
    final lapTime = total - _lastLapTotal;
    _laps.insert(
      0,
      LapRecord(
        number: _laps.length + 1,
        lapTime: lapTime,
        totalTime: total,
      ),
    );
    _lastLapTotal = total;
    setState(() {});
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _stopwatch.isRunning;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        children: [
          const SizedBox(height: DT.space2xl),
          // Display — 高頻更新，不加 AnimatedSwitcher
          Text(
            formatDuration(_elapsed),
            style: theme.textTheme.displayMedium?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: DT.space3xl),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isRunning && _elapsed == Duration.zero)
                ToolGradientButton(
                  gradientColors: _stopwatchGradient,
                  label: '開始',
                  icon: Icons.play_arrow,
                  onPressed: _start,
                )
              else if (isRunning) ...[
                BouncingButton(
                  child: OutlinedButton.icon(
                    onPressed: _lap,
                    icon: const Icon(Icons.flag),
                    label: const Text('分圈'),
                  ),
                ),
                const SizedBox(width: DT.spaceLg),
                BouncingButton(
                  child: FilledButton.icon(
                    onPressed: _stop,
                    icon: const Icon(Icons.pause),
                    label: const Text('暫停'),
                  ),
                ),
              ] else ...[
                BouncingButton(
                  child: OutlinedButton.icon(
                    onPressed: _confirmReset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('重設'),
                  ),
                ),
                const SizedBox(width: DT.spaceLg),
                ToolGradientButton(
                  gradientColors: _stopwatchGradient,
                  label: '繼續',
                  icon: Icons.play_arrow,
                  onPressed: _start,
                ),
              ],
            ],
          ),
          const SizedBox(height: DT.space2xl),
          // Lap list
          if (_laps.isNotEmpty)
            Expanded(
              child: _LapListSection(laps: _laps),
            )
          else
            const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lap List Section (ToolSectionCard 風格 + 可捲動列表)
// ---------------------------------------------------------------------------

class _LapListSection extends StatelessWidget {
  const _LapListSection({required this.laps});

  final List<LapRecord> laps;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);
    final bgColor = brightness == Brightness.dark
        ? DT.brandPrimaryBgDark
        : DT.brandPrimaryBgLight;
    final labelColor = brightness == Brightness.dark
        ? DT.brandPrimarySoft
        : DT.brandPrimary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DT.toolSectionRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DT.toolSectionPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '分圈記錄',
              style: TextStyle(
                fontSize: DT.fontToolLabel,
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: DT.spaceSm),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  final lap = laps[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      child: Text('${lap.number}'),
                    ),
                    title: Text('分圈 ${formatDuration(lap.lapTime)}'),
                    trailing: Text(
                      '總計 ${formatDuration(lap.totalTime)}',
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Timer Tab
// ---------------------------------------------------------------------------

class _TimerTab extends StatefulWidget {
  const _TimerTab();

  @override
  State<_TimerTab> createState() => _TimerTabState();
}

enum _TimerState { idle, running, paused, finished }

class _TimerTabState extends State<_TimerTab> with WidgetsBindingObserver {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  Duration _totalDuration = Duration.zero;
  Duration _remaining = Duration.zero;
  Timer? _ticker;
  _TimerState _state = _TimerState.idle;

  /// Tracks real elapsed time to avoid Timer.periodic drift.
  final Stopwatch _elapsed = Stopwatch();

  final TimerNotificationService _notificationService =
      TimerNotificationService.instance;

  /// 追蹤 App 是否在前景。
  bool _isInForeground = true;

  Duration get _pickerDuration => Duration(
        hours: _hours,
        minutes: _minutes,
        seconds: _seconds,
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notificationService.init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInForeground = state == AppLifecycleState.resumed;
  }

  void _startTimer() {
    final isNewStart = _state == _TimerState.idle;
    if (isNewStart) {
      _totalDuration = _pickerDuration;
      if (_totalDuration == Duration.zero) return;
      _remaining = _totalDuration;
      _elapsed.reset();
    }
    _state = _TimerState.running;
    _elapsed.start();
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        final newRemaining = _totalDuration - _elapsed.elapsed;
        if (newRemaining <= Duration.zero) {
          _remaining = Duration.zero;
          _state = _TimerState.finished;
          _elapsed.stop();
          _ticker?.cancel();
          _ticker = null;
          _onTimerFinished();
        } else {
          _remaining = newRemaining;
        }
      });
    });
    setState(() {});
    // 排程通知（背景用）— 計算剩餘時間
    _notificationService.scheduleTimerNotification(_remaining);
  }

  /// 倒數歸零時觸發：前景播放音效，背景由排程通知處理。
  void _onTimerFinished() {
    // 取消排程通知（前景已到達，不需要再彈通知）
    _notificationService.cancelTimerNotification();

    if (_isInForeground) {
      _notificationService.playCompletionSound();
    }
    // 背景時通知已透過 scheduleTimerNotification 排程，
    // 會在系統層級自動觸發，無需額外處理。
  }

  void _pauseTimer() {
    _elapsed.stop();
    _ticker?.cancel();
    _ticker = null;
    // 暫停時取消排程通知
    _notificationService.cancelTimerNotification();
    setState(() {
      _state = _TimerState.paused;
    });
  }

  Future<void> _confirmResetTimer() async {
    if (_state == _TimerState.idle) {
      _resetTimer();
      return;
    }
    final confirmed = await showConfirmDialog(
      context: context,
      title: '重設計時器',
      message: '確定要重設計時器嗎？目前的倒數計時將被清除。',
      confirmLabel: '重設',
    );
    if (confirmed) _resetTimer();
  }

  void _resetTimer() {
    _elapsed
      ..stop()
      ..reset();
    _ticker?.cancel();
    _ticker = null;
    // 重設時取消排程通知與音效
    _notificationService.cancelTimerNotification();
    _notificationService.stopSound();
    setState(() {
      _state = _TimerState.idle;
      _remaining = Duration.zero;
      _totalDuration = Duration.zero;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _elapsed.stop();
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        children: [
          const SizedBox(height: DT.space2xl),
          if (_state == _TimerState.idle) ...[
            // Duration picker wrapped in ToolSectionCard
            ToolSectionCard(
              label: '設定時間',
              child: _buildDurationPicker(theme),
            ),
          ] else ...[
            // Countdown display
            _buildCountdownDisplay(theme),
          ],
          const SizedBox(height: DT.space3xl),
          // Controls
          _buildControls(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDurationPicker(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NumberPicker(
          label: '時',
          value: _hours,
          maxValue: 23,
          onChanged: (v) => setState(() => _hours = v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DT.spaceSm),
          child: Text(':', style: theme.textTheme.headlineMedium),
        ),
        _NumberPicker(
          label: '分',
          value: _minutes,
          maxValue: 59,
          onChanged: (v) => setState(() => _minutes = v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DT.spaceSm),
          child: Text(':', style: theme.textTheme.headlineMedium),
        ),
        _NumberPicker(
          label: '秒',
          value: _seconds,
          maxValue: 59,
          onChanged: (v) => setState(() => _seconds = v),
        ),
      ],
    );
  }

  Widget _buildCountdownDisplay(ThemeData theme) {
    final isFinished = _state == _TimerState.finished;

    return Column(
      children: [
        // Progress ring — 保持不變
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: _totalDuration.inMilliseconds > 0
                      ? _remaining.inMilliseconds /
                          _totalDuration.inMilliseconds
                      : 0,
                  strokeWidth: 8,
                  backgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                  color: isFinished
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),
              Text(
                formatDuration(_remaining),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: isFinished ? theme.colorScheme.error : null,
                ),
              ),
            ],
          ),
        ),
        if (isFinished) ...[
          const SizedBox(height: DT.spaceLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.alarm, color: theme.colorScheme.error),
              const SizedBox(width: DT.spaceSm),
              Text(
                '時間到！',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildControls() {
    switch (_state) {
      case _TimerState.idle:
        return ToolGradientButton(
          gradientColors: _stopwatchGradient,
          label: '開始',
          icon: Icons.play_arrow,
          onPressed: _pickerDuration > Duration.zero ? _startTimer : null,
        );
      case _TimerState.running:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BouncingButton(
              child: OutlinedButton.icon(
                onPressed: _confirmResetTimer,
                icon: const Icon(Icons.stop),
                label: const Text('重設'),
              ),
            ),
            const SizedBox(width: DT.spaceLg),
            BouncingButton(
              child: FilledButton.icon(
                onPressed: _pauseTimer,
                icon: const Icon(Icons.pause),
                label: const Text('暫停'),
              ),
            ),
          ],
        );
      case _TimerState.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BouncingButton(
              child: OutlinedButton.icon(
                onPressed: _confirmResetTimer,
                icon: const Icon(Icons.stop),
                label: const Text('重設'),
              ),
            ),
            const SizedBox(width: DT.spaceLg),
            ToolGradientButton(
              gradientColors: _stopwatchGradient,
              label: '繼續',
              icon: Icons.play_arrow,
              onPressed: _startTimer,
            ),
          ],
        );
      case _TimerState.finished:
        return BouncingButton(
          child: FilledButton.icon(
            onPressed: _confirmResetTimer,
            icon: const Icon(Icons.refresh),
            label: const Text('重設'),
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Number Picker Widget
// ---------------------------------------------------------------------------

class _NumberPicker extends StatefulWidget {
  final String label;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const _NumberPicker({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  State<_NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<_NumberPicker> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: widget.value);
  }

  @override
  void didUpdateWidget(_NumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        _scrollController.selectedItem != widget.value) {
      _scrollController.jumpToItem(widget.value);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: theme.textTheme.labelSmall),
        const SizedBox(height: DT.spaceXs),
        SizedBox(
          width: 72,
          height: 140,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: _scrollController,
            onSelectedItemChanged: widget.onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.maxValue + 1,
              builder: (context, index) {
                final isSelected = index == widget.value;
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
