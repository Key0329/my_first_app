import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/pages/tool_search_delegate.dart';
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
    context.push(tool.routePath);
  }

  @override
  Widget build(BuildContext context) {
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
                        '工具箱',
                        style: TextStyle(
                          fontSize: DT.fontTitle,
                          fontWeight: FontWeight.w700,
                          color: DT.title(b),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: DT.spaceXs),
                      Text(
                        '${allTools.length} 個工具，隨手可用',
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
                      delegate: ToolSearchDelegate(),
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
                    label: '全部',
                    selected: _selectedCategory == null,
                    onSelected: () =>
                        setState(() => _selectedCategory = null),
                  ),
                  const SizedBox(width: DT.spaceSm),
                  for (final category in ToolCategory.values) ...[
                    _CategoryChip(
                      label: category.label,
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
          // ── 工具 Grid ──
          Expanded(
            child: ListenableBuilder(
              listenable: widget.settings,
              builder: (context, _) {
                final tools = _filteredTools;

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    DT.spaceXl, 0, DT.spaceXl, DT.spaceLg,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: DT.gridSpacing,
                    crossAxisSpacing: DT.gridSpacing,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: tools.length,
                  itemBuilder: (context, index) {
                    final tool = tools[index];
                    return StaggeredFadeIn(
                      index: index,
                      totalItems: tools.length,
                      animate: shouldAnimate,
                      child: ToolCard(
                        tool: tool,
                        isFavorite: widget.settings.isFavorite(tool.id),
                        onTap: () => _openTool(context, tool),
                        onLongPress: () =>
                            widget.settings.toggleFavorite(tool.id),
                      ),
                    );
                  },
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
