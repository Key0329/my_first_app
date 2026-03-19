import 'package:flutter/material.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.tool,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
  });

  final ToolItem tool;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final cardColor = DT.cardBg(b);
    final borderColor = DT.cardBorder(b);
    final gradient = toolGradients[tool.id];

    return Hero(
      tag: 'tool_hero_${tool.id}',
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(DT.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(DT.radiusLg),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DT.radiusLg),
              border: Border.all(color: borderColor, width: 0.5),
            ),
            padding: const EdgeInsets.only(
              top: DT.spaceLg,
              bottom: DT.radiusMd,
              left: DT.spaceMd,
              right: DT.spaceMd,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 漸層圓角方塊 icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: gradient != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: gradient,
                          )
                        : null,
                    color: gradient == null ? tool.color : null,
                    borderRadius: BorderRadius.circular(DT.radiusMd),
                  ),
                  child: Icon(
                    tool.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 10),
                // 工具名稱
                Text(
                  tool.fallbackName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: DT.toolName(b),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isFavorite) ...[
                  const SizedBox(height: DT.spaceXs),
                  Icon(Icons.favorite, color: DT.brandPrimary, size: 12),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
