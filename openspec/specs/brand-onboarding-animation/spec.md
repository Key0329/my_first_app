# brand-onboarding-animation Specification

## Purpose

TBD - created by archiving change 'brand-visual-upgrade'. Update Purpose after archive.

## Requirements

### Requirement: Welcome page entrance animation

The onboarding welcome page (page 1) SHALL animate its content when the page becomes visible. The app logo container SHALL scale from 0 to 1 with an elastic overshoot curve. The title and description text SHALL slide up from 30dp below while fading in, starting 200ms after the logo animation begins.

#### Scenario: Welcome page animates on first view

- **WHEN** the onboarding welcome page becomes visible for the first time
- **THEN** the logo SHALL scale in with elastic overshoot and the text SHALL slide up with a 200ms delay


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
### Requirement: Features page staggered entrance

The onboarding features page (page 2) SHALL animate its three feature rows with staggered timing when the page becomes visible. Each feature row SHALL slide in from the right while fading in. The first row SHALL start immediately, the second after 200ms, and the third after 400ms.

#### Scenario: Features page rows animate in sequence

- **WHEN** the user swipes to the features page
- **THEN** the three feature rows SHALL animate in with 200ms stagger between each


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
### Requirement: Get started page entrance animation

The onboarding get started page (page 3) SHALL animate its content when the page becomes visible. The rocket icon SHALL slide up from 50dp below while scaling from 0.8 to 1.0. The action button SHALL fade in and scale from 0.8 to 1.0 with a 300ms delay after the rocket animation begins.

#### Scenario: Get started page animates on view

- **WHEN** the user swipes to the get started page
- **THEN** the rocket icon SHALL slide up and the button SHALL fade in with a 300ms delay

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