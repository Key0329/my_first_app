import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'date_calculator_logic.dart';

/// 日期計算機工具頁面。
///
/// 提供三種模式：
/// 1. 日期區間（Date Interval）
/// 2. 加減天數（Add/Subtract Days）
/// 3. 工作日計算（Business Days）
class DateCalculatorPage extends StatefulWidget {
  const DateCalculatorPage({super.key});

  @override
  State<DateCalculatorPage> createState() => _DateCalculatorPageState();
}

class _DateCalculatorPageState extends State<DateCalculatorPage>
    with SingleTickerProviderStateMixin {
  static const Color _toolColor = Color(0xFF5C6BC0);

  late final TabController _tabController;

  // ── Mode 1: Date Interval ──
  DateTime _intervalStart = DateTime.now();
  DateTime _intervalEnd = DateTime.now();

  // ── Mode 2: Add/Subtract Days ──
  DateTime _addSubBase = DateTime.now();
  final TextEditingController _daysController = TextEditingController(text: '0');
  bool _isSubtract = false;

  // ── Mode 3: Business Days ──
  DateTime _bizStart = DateTime.now();
  DateTime _bizEnd = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  // ── Date Picker Helper ──
  Future<DateTime?> _pickDate(BuildContext context, DateTime initial) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  String _weekdayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  // ── Computed Results ──
  DateIntervalResult get _intervalResult =>
      DateCalculatorLogic.dateInterval(_intervalStart, _intervalEnd);

  DateTime get _addSubResult {
    final days = int.tryParse(_daysController.text) ?? 0;
    return DateCalculatorLogic.addDays(
      _addSubBase,
      _isSubtract ? -days : days,
    );
  }

  BusinessDaysResult get _bizResult =>
      DateCalculatorLogic.businessDays(_bizStart, _bizEnd);

  // ── Header Display ──
  Widget _buildHeaderContent() {
    final theme = Theme.of(context);
    final whiteStyle = theme.textTheme.displaySmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: Colors.white.withValues(alpha: 0.8),
    );

    switch (_tabController.index) {
      case 0:
        final r = _intervalResult;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('日期區間', style: labelStyle),
            const SizedBox(height: 8),
            Text('${r.totalDays} 天', style: whiteStyle),
            const SizedBox(height: 4),
            Text(
              '${r.weeks} 週 ${r.remainingDays} 天 / ${r.months} 個月 ${r.monthRemainingDays} 天',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        );
      case 1:
        final result = _addSubResult;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('目標日期', style: labelStyle),
            const SizedBox(height: 8),
            Text(_formatDate(result), style: whiteStyle),
            const SizedBox(height: 4),
            Text(
              _weekdayName(result),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        );
      case 2:
        final r = _bizResult;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('工作日計算', style: labelStyle),
            const SizedBox(height: 8),
            Text('${r.businessDays} 工作日', style: whiteStyle),
            const SizedBox(height: 4),
            Text(
              '${r.calendarDays} 日曆天 / ${r.weekendDays} 天週末',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImmersiveToolScaffold(
      toolId: 'date_calculator',
      toolColor: _toolColor,
      title: '日期計算機',
      heroTag: 'tool_hero_date_calculator',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: SafeArea(
        top: true,
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _buildHeaderContent(),
          ),
        ),
      ),
      bodyChild: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // ── Tab Bar ──
        Material(
          color: Colors.transparent,
          child: TabBar(
            controller: _tabController,
            labelColor: _toolColor,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            indicatorColor: _toolColor,
            tabs: const [
              Tab(text: '日期區間'),
              Tab(text: '加減天數'),
              Tab(text: '工作日'),
            ],
          ),
        ),
        // ── Tab Content ──
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildIntervalTab(),
              _buildAddSubTab(),
              _buildBusinessDaysTab(),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 1: Date Interval
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildIntervalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 2,
            child: ToolSectionCard(
              label: '開始日期',
              child: _DatePickerTile(
                date: _intervalStart,
                onTap: () async {
                  final picked = await _pickDate(context, _intervalStart);
                  if (picked != null) {
                    setState(() => _intervalStart = picked);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),
          StaggeredFadeIn(
            index: 1,
            totalItems: 2,
            child: ToolSectionCard(
              label: '結束日期',
              child: _DatePickerTile(
                date: _intervalEnd,
                onTap: () async {
                  final picked = await _pickDate(context, _intervalEnd);
                  if (picked != null) {
                    setState(() => _intervalEnd = picked);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 2: Add/Subtract Days
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildAddSubTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 3,
            child: ToolSectionCard(
              label: '基準日期',
              child: _DatePickerTile(
                date: _addSubBase,
                onTap: () async {
                  final picked = await _pickDate(context, _addSubBase);
                  if (picked != null) {
                    setState(() => _addSubBase = picked);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),
          StaggeredFadeIn(
            index: 1,
            totalItems: 3,
            child: ToolSectionCard(
              label: '天數',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _daysController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '輸入天數',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _toolColor,
                                width: 2,
                              ),
                            ),
                            floatingLabelStyle: TextStyle(color: _toolColor),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DT.toolSectionGap),
                  // 加 / 減 Toggle
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        label: Text('加'),
                        icon: Icon(Icons.add),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text('減'),
                        icon: Icon(Icons.remove),
                      ),
                    ],
                    selected: {_isSubtract},
                    onSelectionChanged: (values) {
                      setState(() => _isSubtract = values.first);
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return null;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return _toolColor;
                        }
                        return null;
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 3: Business Days
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildBusinessDaysTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 2,
            child: ToolSectionCard(
              label: '開始日期',
              child: _DatePickerTile(
                date: _bizStart,
                onTap: () async {
                  final picked = await _pickDate(context, _bizStart);
                  if (picked != null) {
                    setState(() => _bizStart = picked);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),
          StaggeredFadeIn(
            index: 1,
            totalItems: 2,
            child: ToolSectionCard(
              label: '結束日期',
              child: _DatePickerTile(
                date: _bizEnd,
                onTap: () async {
                  final picked = await _pickDate(context, _bizEnd);
                  if (picked != null) {
                    setState(() => _bizEnd = picked);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Date Picker Tile：可點擊的日期選擇列
// ─────────────────────────────────────────────────────────────────────────────

class _DatePickerTile extends StatelessWidget {
  const _DatePickerTile({
    required this.date,
    required this.onTap,
  });

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const toolColor = Color(0xFF5C6BC0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DT.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DT.spaceSm),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: toolColor),
            const SizedBox(width: DT.spaceLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy/MM/dd').format(date),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE').format(date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.edit_calendar,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
