import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/analytics_route_observer.dart';
import 'package:my_first_app/l10n/l10n.dart';
import 'package:my_first_app/pages/favorites_page.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/pages/settings_page.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/app_theme.dart';
import 'package:my_first_app/pages/onboarding_page.dart';
import 'package:my_first_app/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class ToolboxApp extends StatefulWidget {
  final AppSettings settings;
  final ProService proService;
  final InAppPurchaseService iapService;

  const ToolboxApp({
    super.key,
    required this.settings,
    required this.proService,
    required this.iapService,
  });

  @override
  State<ToolboxApp> createState() => _ToolboxAppState();
}

class _ToolboxAppState extends State<ToolboxApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _buildRouter();
  }

  @override
  void dispose() {
    widget.iapService.dispose();
    _router.dispose();
    super.dispose();
  }

  GoRouter _buildRouter() {
    final initialLocation = widget.settings.hasCompletedOnboarding
        ? '/tools'
        : '/onboarding';

    return GoRouter(
      initialLocation: initialLocation,
      observers: [AnalyticsRouteObserver()],
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnboardingPage(
            onComplete: () {
              widget.settings.completeOnboarding();
              _router.go('/tools');
            },
          ),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/tools',
              builder: (context, state) => HomePage(settings: widget.settings),
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) =>
                  FavoritesPage(settings: widget.settings),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) =>
                  SettingsPage(settings: widget.settings),
            ),
          ],
        ),
        // Tool routes — auto-generated from allTools registry
        ...allTools.map(
          (tool) => GoRoute(
            path: tool.routePath,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: tool.pageBuilder(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProService>.value(value: widget.proService),
        Provider<InAppPurchaseService>.value(value: widget.iapService),
      ],
      child: ListenableBuilder(
        listenable: widget.settings.themeService,
        builder: (context, _) {
          return MaterialApp.router(
            title: '工具箱 Pro',
            theme: AppTheme.light(
              accentColor: widget.settings.themeService.accentColorValue,
            ),
            darkTheme: AppTheme.dark(
              accentColor: widget.settings.themeService.accentColorValue,
            ),
            themeMode: widget.settings.themeMode,
            locale: widget.settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
