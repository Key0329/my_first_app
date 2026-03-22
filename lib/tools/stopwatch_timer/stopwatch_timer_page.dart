import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/timer_notification_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/confirm_dialog.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

final Color _toolColor =
    toolGradients['stopwatch_timer']?.first ?? const Color(0xFF607D8B);

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
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: ImmersiveToolScaffold(
        toolId: 'stopwatch_timer',
        toolColor: _toolColor,
        title: '碼錶 / 計時器',
        heroTag: 'tool_hero_stopwatch_timer',
        headerFlex: 1,
        bodyFlex: 3,
        headerChild: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              tabs: [
                Tab(icon: const Icon(Icons.timer_outlined), text: l10n.stopwatchTitle),
                Tab(icon: const Icon(Icons.hourglass_bottom), text: l10n.timerTitle),
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
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: '重設碼錶',
      message: l10n.stopwatchResetConfirm,
      confirmLabel: l10n.commonReset,
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

  void _exportLaps(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Format laps in chronological order (reversed since _laps is newest-first)
    final buffer = StringBuffer();
    for (final lap in _laps.reversed) {
      buffer.writeln('#${lap.number}  ${formatDuration(lap.lapTime)}');
    }
    Clipboard.setData(ClipboardData(text: buffer.toString().trimRight()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.stopwatchLapsExported)),
    );
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
    final l10n = AppLocalizations.of(context)!;

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
                  label: l10n.stopwatchStart,
                  icon: Icons.play_arrow,
                  onPressed: _start,
                )
              else if (isRunning) ...[
                BouncingButton(
                  child: OutlinedButton.icon(
                    onPressed: _lap,
                    icon: const Icon(Icons.flag),
                    label: Text(l10n.stopwatchLap),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, DT.toolButtonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(DT.toolButtonRadius),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: DT.spaceLg),
                BouncingButton(
                  child: FilledButton.icon(
                    onPressed: _stop,
                    icon: const Icon(Icons.pause),
                    label: Text(l10n.stopwatchPause),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, DT.toolButtonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(DT.toolButtonRadius),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                BouncingButton(
                  child: OutlinedButton.icon(
                    onPressed: _confirmReset,
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.commonReset),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, DT.toolButtonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(DT.toolButtonRadius),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: DT.spaceLg),
                ToolGradientButton(
                  gradientColors: _stopwatchGradient,
                  label: l10n.stopwatchContinue,
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
              child: _LapListSection(
                laps: _laps,
                onExport: () => _exportLaps(context),
              ),
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
  const _LapListSection({required this.laps, required this.onExport});

  final List<LapRecord> laps;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '分圈記錄',
                  style: TextStyle(
                    fontSize: DT.fontToolLabel,
                    color: labelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: onExport,
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: l10n.stopwatchExportLaps,
                  visualDensity: VisualDensity.compact,
                ),
              ],
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

  /// Stores the duration when the timer starts, for repeat functionality.
  Duration _lastTimerDuration = Duration.zero;

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
      _lastTimerDuration = _totalDuration;
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

  /// Quickly set a duration (in minutes) and start the timer.
  void _quickSetAndStart(int minutes) {
    _hours = 0;
    _minutes = minutes;
    _seconds = 0;
    _state = _TimerState.idle;
    _totalDuration = Duration.zero;
    _remaining = Duration.zero;
    _elapsed
      ..stop()
      ..reset();
    _ticker?.cancel();
    _ticker = null;
    _notificationService.cancelTimerNotification();
    _notificationService.stopSound();
    // Now start the timer with the quick-set duration
    _startTimer();
  }

  /// Repeat the last timer duration.
  void _repeatTimer() {
    _notificationService.stopSound();
    _hours = _lastTimerDuration.inHours;
    _minutes = _lastTimerDuration.inMinutes.remainder(60);
    _seconds = _lastTimerDuration.inSeconds.remainder(60);
    _state = _TimerState.idle;
    _totalDuration = Duration.zero;
    _remaining = Duration.zero;
    _elapsed
      ..stop()
      ..reset();
    _ticker?.cancel();
    _ticker = null;
    _notificationService.cancelTimerNotification();
    _startTimer();
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
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: '重設計時器',
      message: l10n.stopwatchResetConfirm,
      confirmLabel: l10n.commonReset,
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
            // Quick-set time buttons
            _buildQuickSetChips(),
            const SizedBox(height: DT.spaceLg),
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

  Widget _buildQuickSetChips() {
    final l10n = AppLocalizations.of(context)!;
    final chips = <MapEntry<String, int>>[
      MapEntry(l10n.stopwatchQuickSet3, 3),
      MapEntry(l10n.stopwatchQuickSet5, 5),
      MapEntry(l10n.stopwatchQuickSet10, 10),
      MapEntry(l10n.stopwatchQuickSet15, 15),
      MapEntry(l10n.stopwatchQuickSet30, 30),
    ];

    return Wrap(
      spacing: DT.spaceSm,
      runSpacing: DT.spaceXs,
      alignment: WrapAlignment.center,
      children: chips.map((entry) {
        return ActionChip(
          label: Text(entry.key),
          onPressed: () => _quickSetAndStart(entry.value),
        );
      }).toList(),
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
    final l10n = AppLocalizations.of(context)!;
    switch (_state) {
      case _TimerState.idle:
        return ToolGradientButton(
          gradientColors: _stopwatchGradient,
          label: l10n.stopwatchStart,
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
                label: Text(l10n.commonReset),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, DT.toolButtonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DT.toolButtonRadius),
                  ),
                ),
              ),
            ),
            const SizedBox(width: DT.spaceLg),
            BouncingButton(
              child: FilledButton.icon(
                onPressed: _pauseTimer,
                icon: const Icon(Icons.pause),
                label: Text(l10n.stopwatchPause),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, DT.toolButtonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DT.toolButtonRadius),
                  ),
                ),
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
                label: Text(l10n.commonReset),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, DT.toolButtonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DT.toolButtonRadius),
                  ),
                ),
              ),
            ),
            const SizedBox(width: DT.spaceLg),
            ToolGradientButton(
              gradientColors: _stopwatchGradient,
              label: l10n.stopwatchContinue,
              icon: Icons.play_arrow,
              onPressed: _startTimer,
            ),
          ],
        );
      case _TimerState.finished:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BouncingButton(
              child: OutlinedButton.icon(
                onPressed: _confirmResetTimer,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.commonReset),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, DT.toolButtonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DT.toolButtonRadius),
                  ),
                ),
              ),
            ),
            if (_lastTimerDuration > Duration.zero) ...[
              const SizedBox(width: DT.spaceLg),
              ToolGradientButton(
                gradientColors: _stopwatchGradient,
                label: l10n.stopwatchRepeat,
                icon: Icons.replay,
                onPressed: _repeatTimer,
              ),
            ],
          ],
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
