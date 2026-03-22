import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/services/analytics_route_observer.dart';
import 'package:my_first_app/l10n/l10n.dart';
import 'package:my_first_app/pages/favorites_page.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/pages/settings_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/app_theme.dart';
import 'package:my_first_app/tools/calculator/calculator_page.dart';
import 'package:my_first_app/tools/password_generator/password_generator_page.dart';
import 'package:my_first_app/tools/stopwatch_timer/stopwatch_timer_page.dart';
import 'package:my_first_app/tools/qr_generator/qr_generator_page.dart';
import 'package:my_first_app/tools/color_picker/color_picker_page.dart';
import 'package:my_first_app/tools/compass/compass_page.dart';
import 'package:my_first_app/tools/flashlight/flashlight_page.dart';
import 'package:my_first_app/tools/level/level_page.dart';
import 'package:my_first_app/tools/noise_meter/noise_meter_page.dart';
import 'package:my_first_app/tools/protractor/protractor_page.dart';
import 'package:my_first_app/tools/unit_converter/unit_converter_page.dart';
import 'package:my_first_app/tools/bmi_calculator/bmi_calculator_page.dart';
import 'package:my_first_app/tools/split_bill/split_bill_page.dart';
import 'package:my_first_app/tools/random_wheel/random_wheel_page.dart';
import 'package:my_first_app/tools/screen_ruler/screen_ruler_page.dart';
import 'package:my_first_app/tools/date_calculator/date_calculator_page.dart';
import 'package:my_first_app/tools/qr_scanner_live/qr_scanner_live_page.dart';
import 'package:my_first_app/tools/currency_converter/currency_converter_page.dart';
import 'package:my_first_app/pages/onboarding_page.dart';
import 'package:my_first_app/widgets/app_scaffold.dart';

class ToolboxApp extends StatefulWidget {
  final AppSettings settings;

  const ToolboxApp({super.key, required this.settings});

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
              builder: (context, state) =>
                  HomePage(settings: widget.settings),
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
        // Tool routes (full screen, no bottom nav)
        // 使用 pageBuilder + CustomTransitionPage 讓 Hero 動畫可以跨頁面運作；
        // FadeTransition 作為頁面過渡，不干擾共享元素的位移軌跡。
        GoRoute(
          path: '/tools/calculator',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CalculatorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/unit-converter',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const UnitConverterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/qr-generator',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const QrGeneratorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/flashlight',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const FlashlightPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/level',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const LevelPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/compass',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CompassPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/stopwatch-timer',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const StopwatchTimerPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/noise-meter',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const NoiseMeterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/password-generator',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PasswordGeneratorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/color-picker',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ColorPickerPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/protractor',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ProtractorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/bmi-calculator',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const BmiCalculatorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/split-bill',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SplitBillPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/random-wheel',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const RandomWheelPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/screen-ruler',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ScreenRulerPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/date-calculator',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const DateCalculatorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/qr-scanner-live',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const QrScannerLivePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tools/currency-converter',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CurrencyConverterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settings,
      builder: (context, _) {
        return MaterialApp.router(
          title: '工具箱 Pro',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: widget.settings.themeMode,
          locale: widget.settings.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
