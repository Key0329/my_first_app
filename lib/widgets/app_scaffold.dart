import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/haptic_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabPaths = ['/tools', '/favorites', '/settings'];
  static const _tabIcons = [
    Icons.grid_view_rounded,
    Icons.favorite_outline,
    Icons.settings_outlined,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _tabPaths.length; i++) {
      if (location == _tabPaths[i]) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;
    final tabLabels = [l10n.tabTools, l10n.tabFavorites, l10n.tabSettings];

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
              AnalyticsService.instance
                  .logTabSwitch(tabName: tabLabels[index]);
              context.go(_tabPaths[index]);
            },
            destinations: List.generate(
              _tabPaths.length,
              (i) => NavigationDestination(
                icon: Icon(_tabIcons[i]),
                label: tabLabels[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
