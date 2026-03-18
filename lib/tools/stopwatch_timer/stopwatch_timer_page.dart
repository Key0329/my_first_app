import 'dart:async';

import 'package:flutter/material.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('碼錶 / 計時器'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.timer_outlined), text: '碼錶'),
              Tab(icon: Icon(Icons.hourglass_bottom), text: '計時器'),
            ],
          ),
        ),
        body: const TabBarView(
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

    return Column(
      children: [
        const SizedBox(height: 40),
        // Display
        Text(
          formatDuration(_elapsed),
          style: theme.textTheme.displayMedium?.copyWith(
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 32),
        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isRunning && _elapsed == Duration.zero)
              FilledButton.icon(
                onPressed: _start,
                icon: const Icon(Icons.play_arrow),
                label: const Text('開始'),
              )
            else if (isRunning) ...[
              OutlinedButton.icon(
                onPressed: _lap,
                icon: const Icon(Icons.flag),
                label: const Text('分圈'),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: _stop,
                icon: const Icon(Icons.pause),
                label: const Text('暫停'),
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('重設'),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: _start,
                icon: const Icon(Icons.play_arrow),
                label: const Text('繼續'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        // Lap list
        if (_laps.isNotEmpty) ...[
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                final lap = _laps[index];
                return ListTile(
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
        ] else
          const Expanded(child: SizedBox.shrink()),
      ],
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

class _TimerTabState extends State<_TimerTab> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  Duration _totalDuration = Duration.zero;
  Duration _remaining = Duration.zero;
  Timer? _ticker;
  _TimerState _state = _TimerState.idle;

  Duration get _pickerDuration => Duration(
        hours: _hours,
        minutes: _minutes,
        seconds: _seconds,
      );

  void _startTimer() {
    if (_state == _TimerState.idle) {
      _totalDuration = _pickerDuration;
      if (_totalDuration == Duration.zero) return;
      _remaining = _totalDuration;
    }
    _state = _TimerState.running;
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        final newRemaining = _remaining - const Duration(milliseconds: 100);
        if (newRemaining <= Duration.zero) {
          _remaining = Duration.zero;
          _state = _TimerState.finished;
          _ticker?.cancel();
          _ticker = null;
          // TODO: Play alarm sound (requires platform channels)
        } else {
          _remaining = newRemaining;
        }
      });
    });
    setState(() {});
  }

  void _pauseTimer() {
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _state = _TimerState.paused;
    });
  }

  void _resetTimer() {
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _state = _TimerState.idle;
      _remaining = Duration.zero;
      _totalDuration = Duration.zero;
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 24),
        if (_state == _TimerState.idle) ...[
          // Duration picker
          _buildDurationPicker(theme),
        ] else ...[
          // Countdown display
          _buildCountdownDisplay(theme),
        ],
        const SizedBox(height: 32),
        // Controls
        _buildControls(),
        const Spacer(),
      ],
    );
  }

  Widget _buildDurationPicker(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _NumberPicker(
            label: '時',
            value: _hours,
            maxValue: 23,
            onChanged: (v) => setState(() => _hours = v),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(':', style: theme.textTheme.headlineMedium),
          ),
          _NumberPicker(
            label: '分',
            value: _minutes,
            maxValue: 59,
            onChanged: (v) => setState(() => _minutes = v),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(':', style: theme.textTheme.headlineMedium),
          ),
          _NumberPicker(
            label: '秒',
            value: _seconds,
            maxValue: 59,
            onChanged: (v) => setState(() => _seconds = v),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownDisplay(ThemeData theme) {
    final isFinished = _state == _TimerState.finished;

    return Column(
      children: [
        // Progress ring
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.alarm, color: theme.colorScheme.error),
              const SizedBox(width: 8),
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
        return FilledButton.icon(
          onPressed: _pickerDuration > Duration.zero ? _startTimer : null,
          icon: const Icon(Icons.play_arrow),
          label: const Text('開始'),
        );
      case _TimerState.running:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _resetTimer,
              icon: const Icon(Icons.stop),
              label: const Text('重設'),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: _pauseTimer,
              icon: const Icon(Icons.pause),
              label: const Text('暫停'),
            ),
          ],
        );
      case _TimerState.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _resetTimer,
              icon: const Icon(Icons.stop),
              label: const Text('重設'),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: _startTimer,
              icon: const Icon(Icons.play_arrow),
              label: const Text('繼續'),
            ),
          ],
        );
      case _TimerState.finished:
        return FilledButton.icon(
          onPressed: _resetTimer,
          icon: const Icon(Icons.refresh),
          label: const Text('重設'),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Number Picker Widget
// ---------------------------------------------------------------------------

class _NumberPicker extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: theme.textTheme.labelSmall),
        const SizedBox(height: 4),
        SizedBox(
          width: 72,
          height: 140,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: value),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: maxValue + 1,
              builder: (context, index) {
                final isSelected = index == value;
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
