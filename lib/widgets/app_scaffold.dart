import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/haptic_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabs = [
    ('/tools', Icons.grid_view_rounded, '工具'),
    ('/favorites', Icons.favorite_outline, '收藏'),
    ('/settings', Icons.settings_outlined, '設定'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _tabs.length; i++) {
      if (location == _tabs[i].$1) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0.5, thickness: 0.5, color: DT.navBorder(b)),
          NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              HapticService.selection();
              final tabName = _tabs[index].$3;
              AnalyticsService.instance.logTabSwitch(tabName: tabName);
              context.go(_tabs[index].$1);
            },
            destinations: _tabs
                .map(
                  (tab) => NavigationDestination(
                    icon: Icon(tab.$2),
                    label: tab.$3,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
