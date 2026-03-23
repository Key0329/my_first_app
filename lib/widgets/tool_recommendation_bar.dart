import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/models/tool_relations.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 工具推薦列，顯示在工具頁面底部。
///
/// 根據 [toolId] 從 [toolRelations] 取得 1-2 個推薦工具，
/// 以水平排列的 Chip 呈現（icon + 名稱），點擊導航至該工具。
class ToolRecommendationBar extends StatelessWidget {
  const ToolRecommendationBar({super.key, required this.toolId});

  final String toolId;

  @override
  Widget build(BuildContext context) {
    final recommendations = getRecommendations(toolId);
    if (recommendations.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DT.toolBodyPadding,
        vertical: DT.spaceSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.recommendationTitle,
            style: DT
                .labelMedium(Theme.of(context).brightness)
                .copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.outline,
                ),
          ),
          const SizedBox(height: DT.spaceXs),
          Row(
            children: recommendations.map((tool) {
              final gradient = toolGradients[tool.id];
              return Padding(
                padding: const EdgeInsets.only(right: DT.spaceSm),
                child: ActionChip(
                  avatar: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: gradient != null
                          ? LinearGradient(colors: gradient)
                          : null,
                      color: gradient == null ? tool.color : null,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(tool.icon, size: 14, color: Colors.white),
                  ),
                  label: Text(tool.fallbackName),
                  onPressed: () => context.push(tool.routePath),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
