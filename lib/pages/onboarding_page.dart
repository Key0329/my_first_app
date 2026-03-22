import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// 三頁式 Onboarding 引導頁面。
///
/// 使用 [PageView] 實作左右滑動，包含：
/// - 第 1 頁：歡迎頁（App Logo、歡迎標題、簡介）
/// - 第 2 頁：功能介紹頁（工具箱、收藏、設定三大功能）
/// - 第 3 頁：開始使用頁（含「開始使用」按鈕）
///
/// 所有頁面皆顯示「跳過」按鈕，點擊後呼叫 [onComplete]。
class OnboardingPage extends StatefulWidget {
  /// 當使用者完成 onboarding（點擊「跳過」或「開始使用」）時呼叫。
  final VoidCallback onComplete;

  const OnboardingPage({super.key, required this.onComplete});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    '跳過',
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
                  _buildWelcomePage(theme),
                  _buildFeaturesPage(theme),
                  _buildGetStartedPage(theme),
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: DT.spaceXs,
                    ),
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

  // ── 第 1 頁：歡迎頁 ──
  Widget _buildWelcomePage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo
          Container(
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
          const SizedBox(height: DT.space3xl),

          // 歡迎標題
          Text(
            '歡迎使用工具箱 Pro',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: DT.fontTitle,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DT.spaceLg),

          // App 描述
          Text(
            '您的隨身工具箱，集合多種實用工具，讓日常生活更便利。',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: DT.fontSubtitle,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── 第 2 頁：功能介紹頁 ──
  Widget _buildFeaturesPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '強大功能',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: DT.fontTitle,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DT.space3xl),

          // 工具箱
          _FeatureRow(
            icon: Icons.handyman_rounded,
            title: '豐富工具',
            description: '計算機、單位轉換、密碼產生器等多種實用工具。',
            theme: theme,
          ),
          const SizedBox(height: DT.space2xl),

          // 收藏
          _FeatureRow(
            icon: Icons.favorite_rounded,
            title: '收藏功能',
            description: '將常用工具加入收藏，快速存取。',
            theme: theme,
          ),
          const SizedBox(height: DT.space2xl),

          // 設定
          _FeatureRow(
            icon: Icons.settings_rounded,
            title: '個人化設定',
            description: '自訂主題、語言等偏好設定。',
            theme: theme,
          ),
        ],
      ),
    );
  }

  // ── 第 3 頁：開始使用頁 ──
  Widget _buildGetStartedPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DT.space3xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rocket_launch_rounded,
            size: 80,
            color: DT.brandPrimary,
          ),
          const SizedBox(height: DT.space3xl),

          Text(
            '準備好了嗎？',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: DT.fontTitle,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DT.spaceLg),

          Text(
            '立即開始探索所有功能吧！',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: DT.fontSubtitle,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DT.space3xl),

          // 「開始使用」按鈕
          SizedBox(
            width: double.infinity,
            height: DT.toolButtonHeight,
            child: FilledButton(
              onPressed: widget.onComplete,
              style: FilledButton.styleFrom(
                backgroundColor: DT.brandPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DT.toolButtonRadius),
                ),
              ),
              child: const Text(
                '開始使用',
                style: TextStyle(
                  fontSize: DT.fontToolButton,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
          child: Icon(
            icon,
            color: DT.brandPrimary,
            size: DT.iconSize,
          ),
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
