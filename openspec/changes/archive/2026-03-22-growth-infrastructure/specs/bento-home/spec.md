## ADDED Requirements

### Requirement: App display name for ASO

The app display name SHALL be set to "Spectra 工具箱" on both iOS (`CFBundleDisplayName`) and Android (`android:label`). The bundle identifier SHALL be `com.spectra.toolbox` on both platforms.

#### Scenario: App name displays correctly on home screen

- **WHEN** the app is installed on a device
- **THEN** the home screen icon label SHALL show "Spectra 工具箱"

#### Scenario: Bundle ID is set correctly

- **WHEN** the app is built for release
- **THEN** the bundle identifier SHALL be `com.spectra.toolbox`

### Requirement: Marketing subtitle on home page

The home page subtitle SHALL display "15+ 實用工具，一個 App 搞定" as a marketing-oriented tagline for ASO purposes. This replaces the previous dynamic "N 個工具，隨手可用" subtitle.

#### Scenario: Home page shows marketing subtitle

- **WHEN** user views the home page
- **THEN** the subtitle text SHALL display "15+ 實用工具，一個 App 搞定"

### Requirement: Deep link routing configuration

The app SHALL support deep links in the format `https://spectra.app/tools/{tool-id}` that open the corresponding tool page directly. GoRouter SHALL handle deep link URLs and match them to existing `/tools/{tool-id}` routes. On iOS, Universal Links SHALL be configured via Associated Domains entitlement with `applinks:spectra.app`. On Android, App Links SHALL be configured via intent-filter in AndroidManifest.xml for `https://spectra.app/tools/*`.

#### Scenario: Deep link opens correct tool

- **WHEN** user taps a deep link `https://spectra.app/tools/bmi-calculator`
- **THEN** the app SHALL open and navigate directly to the BMI calculator tool page

#### Scenario: iOS Universal Links configured

- **WHEN** the app is built for iOS
- **THEN** the Associated Domains entitlement SHALL include `applinks:spectra.app`

#### Scenario: Android App Links configured

- **WHEN** the app is built for Android
- **THEN** the AndroidManifest.xml SHALL include an intent-filter for `https://spectra.app/tools/*`
