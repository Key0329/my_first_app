import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/tool_search_delegate.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/review_service.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_card.dart';

class HomePage extends StatefulWidget {
  final AppSettings settings;

  const HomePage({super.key, required this.settings});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToolCategory? _selectedCategory;
  bool _hasAnimated = false;

  List<ToolItem> get _filteredTools {
    if (_selectedCategory == null) return allTools;
    return allTools
        .where((tool) => tool.category == _selectedCategory)
        .toList();
  }

  void _openTool(BuildContext context, ToolItem tool) {
    AnalyticsService.instance.logToolOpen(toolId: tool.id, source: 'home');
    widget.settings.addRecentTool(tool.id);
    ReviewService.instance.recordToolUseAndPrompt();
    context.push(tool.routePath);
  }

  void _toggleFavorite(BuildContext context, ToolItem tool) {
    final l10n = AppLocalizations.of(context)!;
    final wasFavorite = widget.settings.isFavorite(tool.id);
    widget.settings.toggleFavorite(tool.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasFavorite ? l10n.homeFavoriteRemoved : l10n.homeFavoriteAdded),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _categoryLabel(AppLocalizations l10n, ToolCategory category) {
    switch (category) {
      case ToolCategory.calculate:
        return l10n.categoryCalculate;
      case ToolCategory.measure:
        return l10n.categoryMeasure;
      case ToolCategory.life:
        return l10n.categoryLife;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final b = Theme.of(context).brightness;
    final shouldAnimate = !_hasAnimated;
    if (!_hasAnimated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hasAnimated = true);
      });
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 標題區（64dp）──
          Padding(
            padding: const EdgeInsets.fromLTRB(
              DT.spaceXl, DT.spaceLg, DT.spaceXl, DT.spaceMd,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeTitle,
                        style: TextStyle(
                          fontSize: DT.fontTitle,
                          fontWeight: FontWeight.w700,
                          color: DT.title(b),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: DT.spaceXs),
                      Text(
                        l10n.homeSubtitle,
                        style: TextStyle(
                          fontSize: DT.fontSubtitle,
                          fontWeight: FontWeight.w400,
                          color: DT.subtitle(b),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // 搜尋按鈕（40x40 圓形）
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: ToolSearchDelegate(searchHint: l10n.searchHint),
                    );
                  },
                  child: Container(
                    width: DT.searchButtonSize,
                    height: DT.searchButtonSize,
                    decoration: BoxDecoration(
                      color: DT.searchIconBg(b),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search,
                      size: DT.searchIconSize,
                      color: DT.searchIconColor(b),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ── 分類 Tab 列（36dp）──
          SizedBox(
            height: 36,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DT.spaceXl),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryChip(
                    label: l10n.categoryAll,
                    selected: _selectedCategory == null,
                    onSelected: () =>
                        setState(() => _selectedCategory = null),
                  ),
                  const SizedBox(width: DT.spaceSm),
                  for (final category in ToolCategory.values) ...[
                    _CategoryChip(
                      label: _categoryLabel(l10n, category),
                      selected: _selectedCategory == category,
                      onSelected: () =>
                          setState(() => _selectedCategory = category),
                    ),
                    const SizedBox(width: DT.spaceSm),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: DT.spaceLg),
          // ── 內容區（最近使用 + 工具 Grid）──
          Expanded(
            child: ListenableBuilder(
              listenable: widget.settings,
              builder: (context, _) {
                final tools = _filteredTools;
                final recentToolIds = widget.settings.recentTools;
                final recentTools = recentToolIds
                    .map((id) => allTools.cast<ToolItem?>().firstWhere(
                          (t) => t!.id == id,
                          orElse: () => null,
                        ))
                    .whereType<ToolItem>()
                    .toList();

                return CustomScrollView(
                  slivers: [
                    // ── 最近使用區段 ──
                    if (recentTools.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            DT.spaceXl, 0, DT.spaceXl, DT.spaceSm,
                          ),
                          child: Text(
                            l10n.homeRecentTools,
                            style: TextStyle(
                              fontSize: DT.fontSubtitle,
                              fontWeight: FontWeight.w600,
                              color: DT.subtitle(b),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: DT.spaceXl,
                            ),
                            itemCount: recentTools.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: DT.spaceMd),
                            itemBuilder: (context, index) {
                              final tool = recentTools[index];
                              final gradient = toolGradients[tool.id];
                              return GestureDetector(
                                onTap: () => _openTool(context, tool),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        gradient: gradient != null
                                            ? LinearGradient(
                                                colors: gradient,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        color: gradient == null
                                            ? tool.color
                                            : null,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        tool.icon,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: DT.spaceXs),
                                    Text(
                                      tool.fallbackName,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: DT.subtitle(b),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: DT.spaceMd),
                      ),
                    ],
                    // ── 工具 Grid ──
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        DT.spaceXl, 0, DT.spaceXl, DT.spaceLg,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: DT.gridSpacing,
                          crossAxisSpacing: DT.gridSpacing,
                          childAspectRatio: 1.2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final tool = tools[index];
                            return StaggeredFadeIn(
                              index: index,
                              totalItems: tools.length,
                              animate: shouldAnimate,
                              child: ToolCard(
                                tool: tool,
                                isFavorite:
                                    widget.settings.isFavorite(tool.id),
                                onTap: () => _openTool(context, tool),
                                onLongPress: () =>
                                    _toggleFavorite(context, tool),
                                onFavoriteToggle: () =>
                                    _toggleFavorite(context, tool),
                              ),
                            );
                          },
                          childCount: tools.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? DT.tagActiveBg(b) : DT.tagInactiveBg(b),
          borderRadius: BorderRadius.circular(DT.radiusXl),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: DT.fontTab,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? DT.tagActiveText(b) : DT.tagInactiveText(b),
          ),
        ),
      ),
    );
  }
}
