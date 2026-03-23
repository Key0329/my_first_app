import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';

/// 文字統計結果。
class TextStats {
  final int charsWithSpaces;
  final int charsNoSpaces;
  final int words;
  final int lines;
  final int paragraphs;
  final int readingTimeMinutes;
  final bool isLessThanOneMinute;

  const TextStats({
    required this.charsWithSpaces,
    required this.charsNoSpaces,
    required this.words,
    required this.lines,
    required this.paragraphs,
    required this.readingTimeMinutes,
    required this.isLessThanOneMinute,
  });

  static const empty = TextStats(
    charsWithSpaces: 0,
    charsNoSpaces: 0,
    words: 0,
    lines: 0,
    paragraphs: 0,
    readingTimeMinutes: 0,
    isLessThanOneMinute: false,
  );
}

// CJK Unicode range regex.
final _cjkRegex = RegExp(
  r'[\u4e00-\u9fff\u3400-\u4dbf\uf900-\ufaff\u2e80-\u2eff\u3000-\u303f]',
);

/// 計算文字統計資訊。
TextStats computeTextStats(String text) {
  if (text.trim().isEmpty) return TextStats.empty;

  final charsWithSpaces = text.length;
  final charsNoSpaces = text.replaceAll(RegExp(r'\s'), '').length;

  // 行數：以換行分割
  final lines = text.split('\n').length;

  // 段落數：以空行分割，過濾空段落
  final paragraphs = text
      .split(RegExp(r'\n\s*\n'))
      .where((p) => p.trim().isNotEmpty)
      .length;

  // 字數：CJK 字元每個算一個字，英文以空白分詞
  int cjkCount = _cjkRegex.allMatches(text).length;
  // 移除 CJK 字元後，計算剩餘的英文字數
  final nonCjk = text.replaceAll(_cjkRegex, ' ');
  final latinWords = nonCjk
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .length;
  final words = cjkCount + latinWords;

  // 閱讀時間：中文 300 字/分鐘，英文 200 字/分鐘
  final minutes = (cjkCount / 300) + (latinWords / 200);
  final roundedMinutes = minutes.ceil();
  final isLessThanOne = words > 0 && roundedMinutes < 1;

  return TextStats(
    charsWithSpaces: charsWithSpaces,
    charsNoSpaces: charsNoSpaces,
    words: words,
    lines: lines,
    paragraphs: paragraphs,
    readingTimeMinutes: roundedMinutes < 1 ? 1 : roundedMinutes,
    isLessThanOneMinute: isLessThanOne,
  );
}

/// 文字計數器頁面。
class WordCounterPage extends StatefulWidget {
  const WordCounterPage({super.key});

  @override
  State<WordCounterPage> createState() => _WordCounterPageState();
}

class _WordCounterPageState extends State<WordCounterPage> {
  static const Color _toolColor = Color(0xFF3B82F6);

  final TextEditingController _controller = TextEditingController();
  TextStats _stats = TextStats.empty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _stats = computeTextStats(_controller.text);
    });
  }

  void _clearText() {
    _controller.clear();
  }

  void _copySummary() {
    final l10n = AppLocalizations.of(context)!;
    final text = _controller.text;
    if (text.isEmpty) return;

    final readingTime = _stats.isLessThanOneMinute
        ? l10n.wordCounterReadingTimeLessThan1
        : l10n.wordCounterReadingTimeValue(_stats.readingTimeMinutes);

    final summary =
        '${l10n.wordCounterCharsWithSpaces}: ${_stats.charsWithSpaces}\n'
        '${l10n.wordCounterCharsNoSpaces}: ${_stats.charsNoSpaces}\n'
        '${l10n.wordCounterWords}: ${_stats.words}\n'
        '${l10n.wordCounterLines}: ${_stats.lines}\n'
        '${l10n.wordCounterParagraphs}: ${_stats.paragraphs}\n'
        '${l10n.wordCounterReadingTime}: $readingTime';

    Clipboard.setData(ClipboardData(text: summary));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.wordCounterCopiedSummary)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: l10n.wordCounterTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          tooltip: l10n.commonCopy,
          onPressed: _controller.text.isEmpty ? null : _copySummary,
        ),
        IconButton(
          icon: const Icon(Icons.clear_all),
          tooltip: l10n.commonReset,
          onPressed: _controller.text.isEmpty ? null : _clearText,
        ),
      ],
      headerChild: const SizedBox.shrink(),
      bodyChild: Padding(
        padding: const EdgeInsets.all(DT.spaceLg),
        child: Column(
          children: [
            // ── 文字輸入區 ──
            Expanded(
              flex: 3,
              child: StaggeredFadeIn(
                index: 0,
                totalItems: 7,
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: l10n.wordCounterInputHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DT.radiusMd),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.withValues(alpha: 0.05),
                    contentPadding: const EdgeInsets.all(DT.spaceLg),
                  ),
                ),
              ),
            ),
            const SizedBox(height: DT.spaceLg),
            // ── 統計結果 Grid ──
            Expanded(flex: 2, child: _buildStatsGrid(l10n, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(AppLocalizations l10n, bool isDark) {
    final readingTimeValue = _controller.text.isEmpty
        ? '0'
        : _stats.isLessThanOneMinute
        ? l10n.wordCounterReadingTimeLessThan1
        : l10n.wordCounterReadingTimeValue(_stats.readingTimeMinutes);

    final items = [
      _StatItem(l10n.wordCounterCharsWithSpaces, '${_stats.charsWithSpaces}'),
      _StatItem(l10n.wordCounterCharsNoSpaces, '${_stats.charsNoSpaces}'),
      _StatItem(l10n.wordCounterWords, '${_stats.words}'),
      _StatItem(l10n.wordCounterLines, '${_stats.lines}'),
      _StatItem(l10n.wordCounterParagraphs, '${_stats.paragraphs}'),
      _StatItem(l10n.wordCounterReadingTime, readingTimeValue),
    ];

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.2,
      mainAxisSpacing: DT.spaceSm,
      crossAxisSpacing: DT.spaceSm,
      physics: const NeverScrollableScrollPhysics(),
      children: items.asMap().entries.map((entry) {
        return StaggeredFadeIn(
          index: entry.key + 1,
          totalItems: 7,
          child: _buildStatCard(entry.value, isDark),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(_StatItem item, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : _toolColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(DT.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DT.spaceSm,
        vertical: DT.spaceMd,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _toolColor,
              ),
            ),
          ),
          const SizedBox(height: DT.spaceXs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  const _StatItem(this.label, this.value);
}
