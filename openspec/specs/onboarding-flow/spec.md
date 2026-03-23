# onboarding-flow Specification

## Purpose

TBD - created by archiving change 'ux-polish'. Update Purpose after archive.

## Requirements

### Requirement: Three-page onboarding flow

The app SHALL display a 3-page onboarding flow on first launch. The onboarding flow SHALL use a PageView with page indicator dots. Page 1 SHALL display the app logo, a welcome title, and a brief app description. Page 2 SHALL showcase core features (toolbox, favorites, settings) with icons and descriptions. Page 3 SHALL display a "Get Started" button that navigates the user to the home page. The user SHALL be able to swipe between pages. A "Skip" button SHALL be available on all pages. Each page SHALL animate its content when it becomes visible for the first time (controlled by onPageChanged). The animations SHALL use DT design tokens for duration and curves.

#### Scenario: User completes onboarding via get started button

- **WHEN** user swipes to page 3 and taps the "Get Started" button
- **THEN** the onboarding flow SHALL complete and the home page SHALL be displayed

#### Scenario: User skips onboarding

- **WHEN** user taps the "Skip" button on any page
- **THEN** the onboarding flow SHALL complete immediately

#### Scenario: Page animations play once per session

- **WHEN** user swipes to a page, then swipes away and returns
- **THEN** the page entrance animation SHALL NOT replay (it only plays on first visit)


<!-- @trace
source: brand-visual-upgrade
updated: 2026-03-23
code:
  - android/app/src/main/res/drawable/background.png
  - ios/Runner/Info.plist
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@2x.png
  - pubspec.yaml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@2x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Base.lproj/LaunchScreen.storyboard
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - ios/Runner/Assets.xcassets/LaunchBackground.imageset/Contents.json
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - android/app/src/main/res/drawable-mdpi/splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - android/app/src/main/res/drawable-night-xxhdpi/android12splash.png
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - android/app/src/main/res/values-night-v31/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - android/app/src/main/res/drawable-hdpi/android12splash.png
  - android/app/src/main/res/drawable-mdpi/android12splash.png
  - ios/Runner/Assets.xcassets/LaunchBackground.imageset/background.png
  - android/app/src/main/res/drawable/launch_background.xml
  - android/app/src/main/res/drawable-xhdpi/android12splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - android/app/src/main/res/values-night/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@2x.png
  - android/app/src/main/res/drawable-xxxhdpi/android12splash.png
  - android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/res/drawable-night-hdpi/android12splash.png
  - assets/icon/app_icon.png
  - android/app/src/main/res/drawable-v21/background.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - android/app/src/main/res/drawable-night-mdpi/android12splash.png
  - pubspec.lock
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - android/app/src/main/res/drawable-v21/launch_background.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - android/app/src/main/res/values-v31/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - android/app/src/main/res/drawable-xhdpi/splash.png
  - android/app/src/main/res/drawable-xxhdpi/android12splash.png
  - android/app/src/main/res/values/styles.xml
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - android/app/src/main/res/drawable-night-xhdpi/android12splash.png
  - android/app/src/main/res/drawable-xxhdpi/splash.png
  - android/app/src/main/res/drawable-xxxhdpi/splash.png
  - android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - android/app/src/main/res/drawable-night-xxxhdpi/android12splash.png
  - lib/pages/onboarding_page.dart
  - android/app/src/main/res/drawable-hdpi/splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - ios/Runner.xcodeproj/project.pbxproj
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
-->

---
### Requirement: Onboarding completion persistence

The onboarding completion status SHALL be persisted using shared_preferences with the key `hasCompletedOnboarding`. Once completed, the onboarding flow SHALL NOT be shown on subsequent app launches. The app SHALL check this value on startup to determine whether to show onboarding or the home page.

#### Scenario: Onboarding not shown after completion

- **WHEN** the app launches and `hasCompletedOnboarding` is true
- **THEN** the app SHALL navigate directly to the home page without showing onboarding

#### Scenario: Onboarding shown after fresh install

- **WHEN** the app launches and `hasCompletedOnboarding` is false or not set
- **THEN** the app SHALL display the onboarding flow


<!-- @trace
source: ux-polish
updated: 2026-03-22
code:
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/models/tool_item.dart
  - lib/widgets/error_state.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/services/haptic_service.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/compass/compass_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/tool_search_delegate.dart
  - lib/pages/settings_page.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - .mcp.json
  - lib/tools/flashlight/flashlight_logic.dart
  - CLAUDE.md
  - lib/tools/compass/compass_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/app.dart
  - lib/tools/level/level_page.dart
  - lib/pages/favorites_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/settings_service.dart
  - lib/theme/design_tokens.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/tools/screen_ruler_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/services/settings_service_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/widget_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
-->

---
### Requirement: Onboarding page indicator

The onboarding flow SHALL display animated dot indicators at the bottom of each page. The current page dot SHALL be visually distinct (larger and using the brand color). The dots SHALL animate smoothly when the user swipes between pages using AnimatedContainer.

#### Scenario: Page indicator reflects current page

- **WHEN** the user is viewing onboarding page 2
- **THEN** the second dot indicator SHALL be highlighted and enlarged while other dots remain in default state

<!-- @trace
source: ux-polish
updated: 2026-03-22
code:
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/models/tool_item.dart
  - lib/widgets/error_state.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/services/haptic_service.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/compass/compass_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/tool_search_delegate.dart
  - lib/pages/settings_page.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - .mcp.json
  - lib/tools/flashlight/flashlight_logic.dart
  - CLAUDE.md
  - lib/tools/compass/compass_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/app.dart
  - lib/tools/level/level_page.dart
  - lib/pages/favorites_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/settings_service.dart
  - lib/theme/design_tokens.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/tools/screen_ruler_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/services/settings_service_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/widget_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
-->