import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/tool_card.dart';

class HomePage extends StatefulWidget {
  final AppSettings settings;

  const HomePage({super.key, required this.settings});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  List<ToolItem> get _filteredTools {
    if (_searchQuery.isEmpty) return allTools;
    final query = _searchQuery.toLowerCase();
    return allTools
        .where((tool) => tool.fallbackName.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchBar(
            hintText: '搜尋工具...',
            leading: const Icon(Icons.search),
            onChanged: (value) => setState(() => _searchQuery = value),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: _filteredTools.length,
            itemBuilder: (context, index) {
              final tool = _filteredTools[index];
              return ToolCard(
                tool: tool,
                isFavorite: widget.settings.isFavorite(tool.id),
                onTap: () => _openTool(context, tool),
                onLongPress: () => widget.settings.toggleFavorite(tool.id),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openTool(BuildContext context, ToolItem tool) {
    context.push(tool.routePath);
  }
}
