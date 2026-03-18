import 'package:flutter/material.dart';
import 'package:my_first_app/models/tool_item.dart';

class ToolCard extends StatelessWidget {
  final ToolItem tool;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ToolCard({
    super.key,
    required this.tool,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: tool.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(tool.icon, color: tool.color, size: 28),
                  ),
                  if (isFavorite)
                    const Icon(Icons.favorite, color: Colors.red, size: 16),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tool.fallbackName,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
