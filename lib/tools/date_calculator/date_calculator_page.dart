import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/share_card_generator.dart';
import 'package:my_first_app/widgets/share_card_template.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:share_plus/share_plus.dart';
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

  // ── 分享卡片 ──
  final GlobalKey _shareCardKey = GlobalKey();

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
    final l10n = AppLocalizations.of(context)!;
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
            Text(l10n.tool_date_calculator_interval_label, style: labelStyle),
            const SizedBox(height: 8),
            Text(l10n.tool_date_calculator_result_days(r.totalDays), style: whiteStyle),
            const SizedBox(height: 4),
            Text(
              '${l10n.tool_date_calculator_result_weeks(r.weeks, r.remainingDays)} / ${l10n.tool_date_calculator_result_months(r.months, r.monthRemainingDays)}',
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
            Text(l10n.tool_date_calculator_target_date, style: labelStyle),
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
            Text(l10n.tool_date_calculator_business_label, style: labelStyle),
            const SizedBox(height: 8),
            Text(l10n.tool_date_calculator_result_business_days(r.businessDays), style: whiteStyle),
            const SizedBox(height: 4),
            Text(
              '${l10n.tool_date_calculator_result_calendar_days(r.calendarDays)} / ${l10n.tool_date_calculator_result_weekend_days(r.weekendDays)}',
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

  // ── 分享卡片結果內容 ──
  Widget _buildShareCardResult() {
    final l10n = AppLocalizations.of(context)!;
    const resultTextColor = Color(0xFF333333);

    switch (_tabController.index) {
      case 0:
        final r = _intervalResult;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_formatDate(_intervalStart)} ~ ${_formatDate(_intervalEnd)}',
              style: const TextStyle(
                fontSize: 14,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.tool_date_calculator_result_days(r.totalDays),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: _toolColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.tool_date_calculator_result_weeks(r.weeks, r.remainingDays)} / ${l10n.tool_date_calculator_result_months(r.months, r.monthRemainingDays)}',
              style: const TextStyle(
                fontSize: 13,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      case 1:
        final result = _addSubResult;
        final days = int.tryParse(_daysController.text) ?? 0;
        final op = _isSubtract ? l10n.tool_date_calculator_subtract : l10n.tool_date_calculator_add;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_formatDate(_addSubBase)} $op ${l10n.tool_date_calculator_result_days(days)}',
              style: const TextStyle(
                fontSize: 14,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _formatDate(result),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: _toolColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _weekdayName(result),
              style: const TextStyle(
                fontSize: 13,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      case 2:
        final r = _bizResult;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_formatDate(_bizStart)} ~ ${_formatDate(_bizEnd)}',
              style: const TextStyle(
                fontSize: 14,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.tool_date_calculator_result_business_days(r.businessDays),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: _toolColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.tool_date_calculator_result_calendar_days(r.calendarDays)} / ${l10n.tool_date_calculator_result_weekend_days(r.weekendDays)}',
              style: const TextStyle(
                fontSize: 13,
                color: resultTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String get _shareText {
    final l10n = AppLocalizations.of(context)!;
    switch (_tabController.index) {
      case 0:
        final r = _intervalResult;
        return '${l10n.tool_date_calculator_interval_label}: ${_formatDate(_intervalStart)} ~ ${_formatDate(_intervalEnd)}, ${l10n.tool_date_calculator_result_days(r.totalDays)}\n\nhttps://spectra.app/tools/date-calculator';
      case 1:
        final result = _addSubResult;
        final days = int.tryParse(_daysController.text) ?? 0;
        final op = _isSubtract ? l10n.tool_date_calculator_subtract : l10n.tool_date_calculator_add;
        return '${_formatDate(_addSubBase)} $op ${l10n.tool_date_calculator_result_days(days)} = ${_formatDate(result)} (${_weekdayName(result)})\n\nhttps://spectra.app/tools/date-calculator';
      case 2:
        final r = _bizResult;
        return '${l10n.tool_date_calculator_business_label}: ${_formatDate(_bizStart)} ~ ${_formatDate(_bizEnd)}, ${l10n.tool_date_calculator_result_business_days(r.businessDays)}\n\nhttps://spectra.app/tools/date-calculator';
      default:
        return '';
    }
  }

  Future<void> _shareAsImage() async {
    AnalyticsService.instance.logToolShare(
      toolId: 'date_calculator',
      shareMethod: 'system_share',
    );

    final xFile = await ShareCardGenerator.capture(_shareCardKey);
    if (xFile != null) {
      await Share.shareXFiles(
        [xFile],
        text: _shareText,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = toolGradients['date_calculator'] ?? [_toolColor, _toolColor];

    return Stack(
      children: [
        ImmersiveToolScaffold(
          toolId: 'date_calculator',
          toolColor: _toolColor,
          title: l10n.tool_date_calculator_title,
          heroTag: 'tool_hero_date_calculator',
          headerFlex: 2,
          bodyFlex: 3,
          actions: [
            IconButton(
              onPressed: _shareAsImage,
              icon: const Icon(Icons.share),
              tooltip: l10n.commonShare,
            ),
          ],
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
        ),
        // 隱藏的分享卡片（用於截圖）
        Offstage(
          child: RepaintBoundary(
            key: _shareCardKey,
            child: ShareCardTemplate(
              toolName: l10n.tool_date_calculator_title,
              gradientColors: colors,
              resultChild: _buildShareCardResult(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context)!;
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
            tabs: [
              Tab(text: l10n.tool_date_calculator_tab_interval),
              Tab(text: l10n.tool_date_calculator_tab_add_sub),
              Tab(text: l10n.tool_date_calculator_tab_business),
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
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 2,
            child: ToolSectionCard(
              label: l10n.tool_date_calculator_start_date,
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
              label: l10n.tool_date_calculator_end_date,
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
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 3,
            child: ToolSectionCard(
              label: l10n.tool_date_calculator_base_date,
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
              label: l10n.tool_date_calculator_days,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _daysController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.tool_date_calculator_enter_days,
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
                    segments: [
                      ButtonSegment(
                        value: false,
                        label: Text(l10n.tool_date_calculator_add),
                        icon: const Icon(Icons.add),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text(l10n.tool_date_calculator_subtract),
                        icon: const Icon(Icons.remove),
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
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaggeredFadeIn(
            index: 0,
            totalItems: 2,
            child: ToolSectionCard(
              label: l10n.tool_date_calculator_start_date,
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
              label: l10n.tool_date_calculator_end_date,
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
