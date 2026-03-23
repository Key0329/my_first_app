import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 三頁式 Onboarding 引導頁面。
class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingPage({super.key, required this.onComplete});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 每頁的動畫 controller（只播一次）
  late final List<AnimationController> _pageAnimControllers;
  final _pageAnimated = [false, false, false];

  @override
  void initState() {
    super.initState();
    _pageAnimControllers = List.generate(
      3,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      ),
    );
    // 第一頁立即播放
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerPageAnimation(0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _pageAnimControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _triggerPageAnimation(page);
  }

  void _triggerPageAnimation(int page) {
    if (!_pageAnimated[page]) {
      _pageAnimated[page] = true;
      _pageAnimControllers[page].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── 頂部「跳過」按鈕 ──
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(DT.spaceLg),
                child: TextButton(
                  onPressed: widget.onComplete,
                  child: Text(
                    l10n.onboardingSkip,
                    style: TextStyle(
                      color: DT.brandPrimary,
                      fontSize: DT.fontSubtitle,
                    ),
                  ),
                ),
              ),
            ),

            // ── PageView 主體 ──
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  _WelcomePage(
                    theme: theme,
                    l10n: l10n,
                    controller: _pageAnimControllers[0],
                  ),
                  _FeaturesPage(
                    theme: theme,
                    l10n: l10n,
                    controller: _pageAnimControllers[1],
                  ),
                  _GetStartedPage(
                    theme: theme,
                    l10n: l10n,
                    controller: _pageAnimControllers[2],
                    onComplete: widget.onComplete,
                  ),
                ],
              ),
            ),

            // ── 頁面指示器 Dots ──
            Padding(
              padding: const EdgeInsets.only(bottom: DT.space3xl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    key: Key('dot_$index'),
                    duration: DT.durationMedium,
                    margin: const EdgeInsets.symmetric(horizontal: DT.spaceXs),
                    width: isActive ? 24.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: isActive
                          ? DT.brandPrimary
                          : DT.brandPrimary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 第 1 頁：歡迎頁（Logo 彈入 + 文字滑入）──
class _WelcomePage extends StatelessWidget {
  const _WelcomePage({
    required this.theme,
    required this.l10n,
    required this.controller,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final logoScale = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );
    final textSlide = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
    );
    final textFade = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.65, curve: Curves.easeIn),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo 彈入
          ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(logoScale),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [DT.brandPrimary, DT.brandPrimaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(DT.radiusLg),
              ),
              child: const Icon(
                Icons.build_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: DT.space3xl),

          // 文字滑入
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(textSlide),
            child: FadeTransition(
              opacity: textFade,
              child: Column(
                children: [
                  Text(
                    l10n.onboardingWelcomeTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: DT.fontTitle,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DT.spaceLg),
                  Text(
                    l10n.onboardingWelcomeDesc,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: DT.fontSubtitle,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 第 2 頁：功能介紹頁（交錯淡入）──
class _FeaturesPage extends StatelessWidget {
  const _FeaturesPage({
    required this.theme,
    required this.l10n,
    required this.controller,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    // 標題
    final titleFade = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: titleFade,
            child: Text(
              l10n.onboardingFeaturesTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: DT.fontTitle,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: DT.space3xl),

          // 三行交錯動畫
          _AnimatedFeatureRow(
            controller: controller,
            delay: 0.1,
            icon: Icons.handyman_rounded,
            title: l10n.onboardingFeatureTools,
            description: l10n.onboardingFeatureToolsDesc,
            theme: theme,
          ),
          const SizedBox(height: DT.space2xl),
          _AnimatedFeatureRow(
            controller: controller,
            delay: 0.3,
            icon: Icons.favorite_rounded,
            title: l10n.onboardingFeatureFavorites,
            description: l10n.onboardingFeatureFavoritesDesc,
            theme: theme,
          ),
          const SizedBox(height: DT.space2xl),
          _AnimatedFeatureRow(
            controller: controller,
            delay: 0.5,
            icon: Icons.settings_rounded,
            title: l10n.onboardingFeatureSettings,
            description: l10n.onboardingFeatureSettingsDesc,
            theme: theme,
          ),
        ],
      ),
    );
  }
}

// ── 第 3 頁：開始使用頁（火箭上升 + 按鈕淡入）──
class _GetStartedPage extends StatelessWidget {
  const _GetStartedPage({
    required this.theme,
    required this.l10n,
    required this.controller,
    required this.onComplete,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final AnimationController controller;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final rocketSlide = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    final rocketScale = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
    );
    final textFade = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.2, 0.6, curve: Curves.easeIn),
    );
    final buttonFade = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    );
    final buttonScale = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOutBack),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 火箭上升
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(rocketSlide),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(rocketScale),
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 80,
                color: DT.brandPrimary,
              ),
            ),
          ),
          const SizedBox(height: DT.space3xl),

          // 文字淡入
          FadeTransition(
            opacity: textFade,
            child: Column(
              children: [
                Text(
                  l10n.onboardingReadyTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: DT.fontTitle,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DT.spaceLg),
                Text(
                  l10n.onboardingReadyDesc,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: DT.fontSubtitle,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: DT.space3xl),

          // 按鈕淡入 + 縮放
          FadeTransition(
            opacity: buttonFade,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(buttonScale),
              child: SizedBox(
                width: double.infinity,
                height: DT.toolButtonHeight,
                child: FilledButton(
                  onPressed: onComplete,
                  style: FilledButton.styleFrom(
                    backgroundColor: DT.brandPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DT.toolButtonRadius),
                    ),
                  ),
                  child: Text(
                    l10n.onboardingStart,
                    style: const TextStyle(
                      fontSize: DT.fontToolButton,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 帶交錯動畫的功能列 ──
class _AnimatedFeatureRow extends StatelessWidget {
  const _AnimatedFeatureRow({
    required this.controller,
    required this.delay,
    required this.icon,
    required this.title,
    required this.description,
    required this.theme,
  });

  final AnimationController controller;
  final double delay;
  final IconData icon;
  final String title;
  final String description;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final end = (delay + 0.4).clamp(0.0, 1.0);
    final slide = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, end, curve: Curves.easeOut),
    );
    final fade = CurvedAnimation(
      parent: controller,
      curve: Interval(
        delay,
        (delay + 0.3).clamp(0.0, 1.0),
        curve: Curves.easeIn,
      ),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(slide),
      child: FadeTransition(
        opacity: fade,
        child: _FeatureRow(
          icon: icon,
          title: title,
          description: description,
          theme: theme,
        ),
      ),
    );
  }
}

/// 功能介紹列（第 2 頁使用）。
class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final ThemeData theme;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: DT.iconContainerSize,
          height: DT.iconContainerSize,
          decoration: BoxDecoration(
            color: DT.brandPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DT.radiusSm),
          ),
          child: Icon(icon, color: DT.brandPrimary, size: DT.iconSize),
        ),
        const SizedBox(width: DT.spaceLg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: DT.spaceXs),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
