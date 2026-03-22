# app-animations Specification

## Purpose

TBD - created by archiving change 'design-overhaul-bento'. Update Purpose after archive.

## Requirements

### Requirement: Staggered fade-in animation on home page

When the home page first loads, tool cards SHALL animate in with a staggered fade-in effect. Each card SHALL slide up from 20 pixels below its final position while fading from 0 to full opacity. Each successive card SHALL start its animation 50ms after the previous card. The animation SHALL only play on the initial page load, not on subsequent tab switches. The animation SHALL work with the uniform 2-column GridView layout.

#### Scenario: Cards animate in on first load

- **WHEN** the home page loads for the first time in a session
- **THEN** each tool card SHALL animate in with a staggered slide-up and fade-in effect

#### Scenario: Animation does not replay on tab switch

- **WHEN** user switches away from and back to the Tools tab
- **THEN** tool cards SHALL appear immediately without replay of the staggered animation


<!-- @trace
source: homepage-redesign-indigo
updated: 2026-03-21
code:
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_card.dart
  - pubspec.yaml
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_en.arb
  - lib/widgets/bento_grid.dart
  - android/app/src/main/AndroidManifest.xml
  - pubspec.lock
  - lib/widgets/app_scaffold.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/l10n/app_zh.arb
  - lib/app.dart
  - lib/pages/home_page.dart
  - lib/models/tool_item.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/theme/design_tokens.dart
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/theme/app_theme.dart
  - lib/tools/screen_ruler/ruler_painter.dart
  - lib/tools/invoice_checker/invoice_api.dart
tests:
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/widget_test.dart
  - test/pages/favorites_page_test.dart
-->

---
### Requirement: Hero transition between home card and tool page

When a user taps a tool card, a Hero animation SHALL connect the card to the tool page. The card's gradient background SHALL expand into the tool page's gradient header. The Hero tag SHALL use the format `tool_hero_{toolId}`. The transition SHALL use GoRouter's CustomTransitionPage.

#### Scenario: Tapping card triggers Hero expand animation

- **WHEN** user taps a tool card on the home page
- **THEN** the card SHALL expand via Hero animation into the full tool page with the gradient background morphing into the tool page header

#### Scenario: Returning from tool triggers Hero collapse animation

- **WHEN** user taps the back button on a tool page
- **THEN** the tool page header SHALL collapse back into the home page card via reverse Hero animation


<!-- @trace
source: design-overhaul-bento
updated: 2026-03-19
code:
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - lib/widgets/bento_grid.dart
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/README.md
  - lib/l10n/app_localizations.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.lock
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/widgets/bouncing_button.dart
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Info.plist
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - lib/models/tool_item.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - patches/audio_streamer/example/README.md
  - pubspec.yaml
  - lib/tools/qr_generator/qr_generator_page.dart
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - lib/tools/password_generator/password_generator_page.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - lib/pages/favorites_page.dart
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/home_page.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_en.dart
  - patches/audio_streamer/android/gradle.properties
  - lib/tools/calculator/calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/android/gradle.properties
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/level/level_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/app.dart
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - lib/tools/unit_converter/unit_converter_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - patches/audio_streamer/android/settings.gradle
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
tests:
  - test/theme/app_theme_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
  - test/widgets/bento_grid_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/pages/home_page_test.dart
  - test/tools/password_generator_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Interactive micro-animations

Tool pages SHALL include subtle micro-animations for interactive elements. All interactive buttons across all 15 tool pages SHALL be wrapped in BouncingButton with a scale bounce effect (scale to 0.95 on press, back to 1.0 on release with a spring curve). Numeric displays that change value SHALL animate the transition with a brief vertical slide using AnimatedSwitcher with 200ms duration. The BouncingButton wrapper SHALL apply to FilledButton, OutlinedButton, IconButton, and custom GestureDetector-based interactive elements.

#### Scenario: Button press shows scale bounce

- **WHEN** user presses any interactive button in any tool page
- **THEN** the button SHALL briefly scale down to 0.95 and spring back to 1.0

#### Scenario: Calculator result animates on change

- **WHEN** the calculator result value changes
- **THEN** the new value SHALL slide in from below while the old value slides out above


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Tool page body staggered fade-in animation

When a tool page opens, the body section cards SHALL animate in with a staggered fade-in effect, reusing the same pattern as the home page. Each section card SHALL slide up from 20 pixels below and fade from 0 to full opacity. Each successive card SHALL start 50ms after the previous one. The animation SHALL play once on page open and SHALL NOT replay on widget rebuilds.

#### Scenario: Body sections animate in on tool page open

- **WHEN** user navigates to any tool page
- **THEN** each ToolSectionCard in the body area SHALL animate in with staggered slide-up and fade-in effect

#### Scenario: Animation does not replay on state changes

- **WHEN** user interacts with controls on a tool page causing widget rebuilds
- **THEN** the body section cards SHALL NOT replay the entrance animation


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Value change animation with AnimatedSwitcher

Numeric result displays in tool pages SHALL animate value transitions using AnimatedSwitcher. When a result value changes, the old value SHALL slide out upward while fading out, and the new value SHALL slide in from below while fading in. The transition duration SHALL be 200ms. High-frequency update displays (stopwatch centiseconds) SHALL NOT use this animation to avoid performance impact.

#### Scenario: Calculator result animates on evaluation

- **WHEN** user presses equals on the calculator and a new result appears
- **THEN** the result text SHALL transition with a slide-up fade animation over 200ms

#### Scenario: BMI value animates on slider change

- **WHEN** user adjusts the height or weight slider on the BMI calculator
- **THEN** the BMI result number SHALL animate with a slide-up fade transition

#### Scenario: Stopwatch centiseconds do not animate

- **WHEN** the stopwatch is running and centiseconds are updating
- **THEN** the time display SHALL update immediately without AnimatedSwitcher animation

<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Motion Token constants in Design Tokens

The DT class SHALL define Motion Token constants for animation durations. The following constants SHALL be defined: `durationFast` as Duration(milliseconds: 150) for button feedback and micro-interactions, `durationMedium` as Duration(milliseconds: 300) for page transitions and expand/collapse animations, and `durationSlow` as Duration(milliseconds: 500) for complex animations and initial page load effects. All animation durations throughout the app SHALL reference these Motion Token constants instead of using inline magic numbers.

#### Scenario: Motion Token durationFast is defined

- **WHEN** code references DT.durationFast
- **THEN** it SHALL resolve to Duration(milliseconds: 150)

#### Scenario: Motion Token durationMedium is defined

- **WHEN** code references DT.durationMedium
- **THEN** it SHALL resolve to Duration(milliseconds: 300)

#### Scenario: Motion Token durationSlow is defined

- **WHEN** code references DT.durationSlow
- **THEN** it SHALL resolve to Duration(milliseconds: 500)


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Opacity Token constants in Design Tokens

The DT class SHALL define Opacity Token constants. The following constants SHALL be defined: `opacityDisabled` as 0.38 for disabled state elements, `opacityOverlay` as 0.08 for press overlay effects, and `opacityHover` as 0.04 for hover overlay effects. All opacity values throughout the app SHALL reference these Opacity Token constants instead of using inline magic numbers.

#### Scenario: Opacity Token opacityDisabled is defined

- **WHEN** code references DT.opacityDisabled
- **THEN** it SHALL resolve to 0.38

#### Scenario: Opacity Token opacityOverlay is defined

- **WHEN** code references DT.opacityOverlay
- **THEN** it SHALL resolve to 0.08

#### Scenario: Opacity Token opacityHover is defined

- **WHEN** code references DT.opacityHover
- **THEN** it SHALL resolve to 0.04

<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Global haptic feedback

The app SHALL provide haptic feedback for interactive actions using the Flutter HapticFeedback API. Light impact feedback SHALL be triggered on general button taps and tab switches. Medium impact feedback SHALL be triggered on favorite toggles and onboarding page swipes. Heavy impact feedback SHALL be triggered on wheel result reveals and important confirmations. Selection click feedback SHALL be triggered on slider drags and option switches. The BouncingButton widget SHALL integrate light impact haptic feedback so that all wrapped buttons automatically provide tactile feedback.

#### Scenario: Button tap triggers light haptic feedback

- **WHEN** user taps any button wrapped in BouncingButton
- **THEN** a light impact haptic feedback SHALL be triggered

#### Scenario: Favorite toggle triggers medium haptic feedback

- **WHEN** user toggles a tool's favorite status
- **THEN** a medium impact haptic feedback SHALL be triggered

#### Scenario: Wheel result triggers heavy haptic feedback

- **WHEN** the random wheel stops and reveals a result
- **THEN** a heavy impact haptic feedback SHALL be triggered

#### Scenario: Tab switch triggers selection click haptic

- **WHEN** user switches between navigation tabs
- **THEN** a selection click haptic feedback SHALL be triggered


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
### Requirement: Wheel result overlay animation

The random wheel result SHALL be displayed using a custom overlay animation instead of a standard AlertDialog. When the wheel stops, a semi-transparent dark background SHALL fade in, followed by a result card that scales in from center with an elastic bounce effect (Curves.elasticOut). The result card SHALL display the result text in large font on a gradient background matching the tool's color scheme. Tapping the background or a dismiss button SHALL close the overlay with a scale-out fade animation. The overlay SHALL trigger heavy haptic feedback on appearance.

#### Scenario: Wheel result displays with overlay animation

- **WHEN** the random wheel stops spinning
- **THEN** a semi-transparent overlay SHALL fade in and the result card SHALL scale in with an elastic bounce animation

#### Scenario: User dismisses wheel result overlay

- **WHEN** user taps the overlay background or the dismiss button
- **THEN** the result card SHALL scale out and the overlay SHALL fade out


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
### Requirement: Favorite heart button animation

When the user taps the favorite heart icon button, the heart SHALL animate with an AnimatedScale effect. The heart SHALL scale up to 1.2x its normal size and then spring back to 1.0x. The animation duration SHALL be 200ms with a spring curve.

#### Scenario: Heart icon animates on favorite toggle

- **WHEN** user taps the heart icon button on a tool card
- **THEN** the heart icon SHALL scale up to 1.2x and spring back to 1.0x over 200ms

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