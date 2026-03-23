import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/tool_search_delegate.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/review_service.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/shimmer_loading.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_card.dart';

class HomePage extends StatefulWidget {
  final AppSettings settings;

  const HomePage({super.key, required this.settings});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToolTag? _selectedTag;
  bool _hasAnimated = false;

  List<ToolItem> get _orderedTools {
    final orderedIds = widget.settings.getOrderedToolIds(
      allTools.map((t) => t.id).toList(),
    );
    return orderedIds
        .map(
          (id) => allTools.cast<ToolItem?>().firstWhere(
            (t) => t!.id == id,
            orElse: () => null,
          ),
        )
        .whereType<ToolItem>()
        .toList();
  }

  List<ToolItem> get _filteredTools {
    final ordered = _orderedTools;
    if (_selectedTag == null) return ordered;
    return ordered.where((tool) => tool.tags.contains(_selectedTag)).toList();
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
        content: Text(
          wasFavorite ? l10n.homeFavoriteRemoved : l10n.homeFavoriteAdded,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showReorderSheet(BuildContext context, AppLocalizations l10n) {
    final orderedTools = List<ToolItem>.from(_orderedTools);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              expand: false,
              builder: (ctx, scrollController) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(DT.spaceLg),
                      child: Column(
                        children: [
                          Text(
                            l10n.reorderToolsTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: DT.spaceXs),
                          Text(
                            l10n.reorderToolsHint,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ReorderableListView.builder(
                        scrollController: scrollController,
                        itemCount: orderedTools.length,
                        onReorder: (oldIndex, newIndex) {
                          setSheetState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item = orderedTools.removeAt(oldIndex);
                            orderedTools.insert(newIndex, item);
                          });
                          widget.settings.setToolOrder(
                            orderedTools.map((t) => t.id).toList(),
                          );
                        },
                        itemBuilder: (ctx, index) {
                          final tool = orderedTools[index];
                          final gradient = toolGradients[tool.id];
                          return ListTile(
                            key: ValueKey(tool.id),
                            leading: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: gradient != null
                                    ? LinearGradient(colors: gradient)
                                    : null,
                                color: gradient == null ? tool.color : null,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                tool.icon,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            title: Text(tool.fallbackName),
                            trailing: const Icon(Icons.drag_handle),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  String _tagLabel(AppLocalizations l10n, ToolTag tag) {
    switch (tag) {
      case ToolTag.calculate:
        return l10n.tagCalculate;
      case ToolTag.measure:
        return l10n.tagMeasure;
      case ToolTag.life:
        return l10n.tagLife;
      case ToolTag.productivity:
        return l10n.tagProductivity;
      case ToolTag.finance:
        return l10n.tagFinance;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final b = Theme.of(context).brightness;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final gridCrossAxisCount = screenWidth > 900
        ? 4
        : screenWidth > 600
        ? 3
        : 2;
    final shouldAnimate = !_hasAnimated;
    if (!_hasAnimated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hasAnimated = true);
      });
    }

    return SafeArea(
      child: ListenableBuilder(
        listenable: widget.settings,
        builder: (context, _) {
          final tools = _filteredTools;
          final recentToolIds = widget.settings.recentTools;
          final recentTools = recentToolIds
              .map(
                (id) => allTools.cast<ToolItem?>().firstWhere(
                  (t) => t!.id == id,
                  orElse: () => null,
                ),
              )
              .whereType<ToolItem>()
              .toList();

          final streakCount = widget.settings.streakCount;
          final dailyRec = widget.settings.getDailyRecommendation(
            allTools.map((t) => t.id).toList(),
          );
          final dailyTool = dailyRec != null
              ? allTools.cast<ToolItem?>().firstWhere(
                  (t) => t!.id == dailyRec,
                  orElse: () => null,
                )
              : null;

          return CustomScrollView(
            slivers: [
              // ── SliverAppBar（標題 + 搜尋欄，滾動縮小）──
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: DT.pageBg(b),
                surfaceTintColor: Colors.transparent,
                expandedHeight: 130,
                toolbarHeight: 60,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      DT.spaceXl,
                      DT.spaceLg,
                      DT.spaceXl,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.homeTitle,
                                style: TextStyle(
                                  fontSize: DT.fontTitle,
                                  fontWeight: FontWeight.w700,
                                  color: DT.title(b),
                                  height: 1.2,
                                ),
                              ),
                            ),
                            // 排序按鈕
                            Semantics(
                              label: l10n.a11yReorderTools,
                              button: true,
                              child: GestureDetector(
                                onTap: () => _showReorderSheet(context, l10n),
                                child: Container(
                                  width: DT.searchButtonSize,
                                  height: DT.searchButtonSize,
                                  decoration: BoxDecoration(
                                    color: DT.searchIconBg(b),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.sort,
                                    size: DT.searchIconSize,
                                    color: DT.searchIconColor(b),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DT.spaceSm),
                        // ── Placeholder 搜尋欄 ──
                        Semantics(
                          label: l10n.a11ySearchTools,
                          button: true,
                          child: GestureDetector(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: ToolSearchDelegate(
                                  searchHint: l10n.searchHint,
                                ),
                              );
                            },
                            child: Container(
                              height: 44,
                              padding: const EdgeInsets.symmetric(
                                horizontal: DT.spaceLg,
                              ),
                              decoration: BoxDecoration(
                                color: DT.cardBg(b),
                                borderRadius: BorderRadius.circular(
                                  DT.radiusMd,
                                ),
                                border: Border.all(
                                  color: DT.cardBorder(b),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: DT.iconSm,
                                    color: DT.subtitle(b),
                                  ),
                                  const SizedBox(width: DT.spaceMd),
                                  Expanded(
                                    child: Text(
                                      l10n.searchHint,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: DT.subtitle(b),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ── 分類 Tab 列 ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    DT.spaceMd,
                    0,
                    DT.spaceMd,
                  ),
                  child: SizedBox(
                    height: 36,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DT.spaceXl,
                      ),
                      children: [
                        _CategoryChip(
                          label: l10n.categoryAll,
                          selected: _selectedTag == null,
                          onSelected: () => setState(() => _selectedTag = null),
                        ),
                        const SizedBox(width: DT.spaceSm),
                        for (final tag in ToolTag.values) ...[
                          _CategoryChip(
                            label: _tagLabel(l10n, tag),
                            selected: _selectedTag == tag,
                            onSelected: () =>
                                setState(() => _selectedTag = tag),
                          ),
                          const SizedBox(width: DT.spaceSm),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // ── Streak + 每日推薦 ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DT.spaceXl,
                    0,
                    DT.spaceXl,
                    DT.spaceSm,
                  ),
                  child: Row(
                    children: [
                      if (streakCount > 0) ...[
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          l10n.homeStreak(streakCount),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (dailyTool != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      DT.spaceXl,
                      0,
                      DT.spaceXl,
                      DT.spaceMd,
                    ),
                    child: _DailyRecommendCard(
                      tool: dailyTool,
                      l10n: l10n,
                      onTap: () => _openTool(context, dailyTool),
                    ),
                  ),
                ),
              // ── 最近使用（僅在「全部」tab 顯示）──
              if (recentTools.isNotEmpty && _selectedTag == null) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      DT.spaceXl,
                      0,
                      DT.spaceXl,
                      DT.spaceSm,
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
                                  color: gradient == null ? tool.color : null,
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
                const SliverToBoxAdapter(child: SizedBox(height: DT.spaceMd)),
              ],
              // ── 工具 Grid（含 Tab 切換動畫）──
              if (!_hasAnimated)
                const SliverToBoxAdapter(child: ShimmerToolGrid())
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    DT.spaceXl,
                    0,
                    DT.spaceXl,
                    DT.spaceLg,
                  ),
                  sliver: SliverGrid(
                    key: ValueKey(_selectedTag),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: DT.gridSpacing,
                          crossAxisSpacing: DT.gridSpacing,
                          childAspectRatio: 1.2,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final tool = tools[index];
                      return StaggeredFadeIn(
                        index: index,
                        totalItems: tools.length,
                        animate: shouldAnimate,
                        child: ToolCard(
                          tool: tool,
                          isFavorite: widget.settings.isFavorite(tool.id),
                          onTap: () => _openTool(context, tool),
                          onLongPress: () => _toggleFavorite(context, tool),
                          onFavoriteToggle: () =>
                              _toggleFavorite(context, tool),
                        ),
                      );
                    }, childCount: tools.length),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DailyRecommendCard extends StatelessWidget {
  const _DailyRecommendCard({
    required this.tool,
    required this.l10n,
    required this.onTap,
  });

  final ToolItem tool;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final isDark = b == Brightness.dark;
    final gradient = toolGradients[tool.id];
    final color = gradient?.first ?? tool.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DT.spaceLg),
        decoration: BoxDecoration(
          gradient: gradient != null
              ? LinearGradient(
                  colors: [
                    gradient.first.withValues(alpha: isDark ? 0.3 : 0.12),
                    gradient.last.withValues(alpha: isDark ? 0.15 : 0.06),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(DT.radiusMd),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: gradient != null
                    ? LinearGradient(colors: gradient)
                    : null,
                color: gradient == null ? color : null,
                shape: BoxShape.circle,
              ),
              child: Icon(tool.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: DT.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeDailyRecommend,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    tool.fallbackName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    l10n.homeDailyRecommendHint,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
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
