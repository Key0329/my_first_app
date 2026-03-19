# tool-split-bill Specification

## Purpose

TBD - created by archiving change 'add-tools-batch-2'. Update Purpose after archive.

## Requirements

### Requirement: Total amount and participant count input

The split bill calculator SHALL accept a total amount via a text field with numeric keyboard and a participant count adjustable via increment/decrement buttons. The minimum participant count SHALL be 2 and the maximum SHALL be 30.

#### Scenario: User enters total amount and adjusts participant count

- **WHEN** user enters a total amount and sets participant count to N
- **THEN** the system SHALL display the per-person amount calculated as total / N

#### Scenario: User attempts to decrease below minimum

- **WHEN** user taps the decrement button when participant count is 2
- **THEN** the decrement button SHALL be disabled and the count SHALL remain at 2


<!-- @trace
source: add-tools-batch-2
updated: 2026-03-19
code:
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/tools/screen_ruler/ruler_painter.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - lib/tools/level/level_page.dart
  - patches/audio_streamer/android/gradle.properties
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - pubspec.yaml
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/favorites_page.dart
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - lib/l10n/app_zh.arb
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/README.md
  - lib/app.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - ios/Runner/Info.plist
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/widgets/bento_grid.dart
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - pubspec.lock
  - lib/tools/split_bill/split_bill_page.dart
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - lib/widgets/bouncing_button.dart
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - lib/models/tool_item.dart
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - lib/pages/home_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/l10n/app_en.arb
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/README.md
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - patches/audio_streamer/example/android/gradle.properties
  - lib/l10n/app_localizations_en.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/android/settings.gradle
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/tools/password_generator_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/qr_generator_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/models/tool_item_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/theme/app_theme_test.dart
  - test/pages/home_page_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
-->

---
### Requirement: Equal split calculation with remainder handling

The system SHALL calculate equal split amounts. When the total amount does not divide evenly, the first participant SHALL pay the remainder. All amounts SHALL be rounded to integer (whole dollar).

#### Scenario: Amount divides evenly

- **WHEN** total is 900 and participants is 3
- **THEN** each person SHALL pay 300

#### Scenario: Amount does not divide evenly

- **WHEN** total is 100 and participants is 3
- **THEN** the first person SHALL pay 34 and the remaining 2 people SHALL each pay 33

#### Scenario: Total is zero or empty

- **WHEN** total amount field is empty or zero
- **THEN** the per-person amount SHALL display 0


<!-- @trace
source: add-tools-batch-2
updated: 2026-03-19
code:
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/tools/screen_ruler/ruler_painter.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - lib/tools/level/level_page.dart
  - patches/audio_streamer/android/gradle.properties
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - pubspec.yaml
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/favorites_page.dart
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - lib/l10n/app_zh.arb
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/README.md
  - lib/app.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - ios/Runner/Info.plist
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/widgets/bento_grid.dart
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - pubspec.lock
  - lib/tools/split_bill/split_bill_page.dart
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - lib/widgets/bouncing_button.dart
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - lib/models/tool_item.dart
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - lib/pages/home_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/l10n/app_en.arb
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/README.md
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - patches/audio_streamer/example/android/gradle.properties
  - lib/l10n/app_localizations_en.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/android/settings.gradle
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/tools/password_generator_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/qr_generator_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/models/tool_item_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/theme/app_theme_test.dart
  - test/pages/home_page_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
-->

---
### Requirement: Summary display in header

The header area SHALL display a summary showing the total amount and participant count in the format "$ {total} ÷ {count}".

#### Scenario: User views split summary

- **WHEN** user has entered 1500 as total and 3 as participant count
- **THEN** the header SHALL display "$1,500 ÷ 3 人"


<!-- @trace
source: add-tools-batch-2
updated: 2026-03-19
code:
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/tools/screen_ruler/ruler_painter.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - lib/tools/level/level_page.dart
  - patches/audio_streamer/android/gradle.properties
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - pubspec.yaml
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/favorites_page.dart
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - lib/l10n/app_zh.arb
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/README.md
  - lib/app.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - ios/Runner/Info.plist
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/widgets/bento_grid.dart
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - pubspec.lock
  - lib/tools/split_bill/split_bill_page.dart
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - lib/widgets/bouncing_button.dart
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - lib/models/tool_item.dart
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - lib/pages/home_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/l10n/app_en.arb
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/README.md
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - patches/audio_streamer/example/android/gradle.properties
  - lib/l10n/app_localizations_en.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/android/settings.gradle
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/tools/password_generator_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/qr_generator_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/models/tool_item_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/theme/app_theme_test.dart
  - test/pages/home_page_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
-->

---
### Requirement: ImmersiveToolScaffold integration

The split bill page SHALL use ImmersiveToolScaffold with tool color `Color(0xFF26A69A)`, icon `Icons.groups`, and Hero animation tag `tool_hero_split_bill`.

#### Scenario: User opens split bill from home page

- **WHEN** user taps the split bill card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout

<!-- @trace
source: add-tools-batch-2
updated: 2026-03-19
code:
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/tools/screen_ruler/ruler_painter.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - lib/tools/level/level_page.dart
  - patches/audio_streamer/android/gradle.properties
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - pubspec.yaml
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/favorites_page.dart
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - lib/l10n/app_zh.arb
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/README.md
  - lib/app.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - ios/Runner/Info.plist
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/widgets/bento_grid.dart
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - pubspec.lock
  - lib/tools/split_bill/split_bill_page.dart
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - lib/widgets/bouncing_button.dart
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - lib/models/tool_item.dart
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - lib/pages/home_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/l10n/app_en.arb
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/README.md
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - patches/audio_streamer/example/android/gradle.properties
  - lib/l10n/app_localizations_en.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/android/settings.gradle
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/tools/password_generator_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/qr_generator_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/models/tool_item_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/theme/app_theme_test.dart
  - test/pages/home_page_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
-->