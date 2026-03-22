## ADDED Requirements

### Requirement: AnalyticsService singleton initialization

The app SHALL initialize Firebase Core, Firebase Analytics, and Firebase Crashlytics during app startup in `main()`. An `AnalyticsService` singleton SHALL be created that wraps `FirebaseAnalytics` and provides a unified event-logging interface. The service SHALL be accessible throughout the app via `AnalyticsService.instance`.

#### Scenario: Firebase initializes on app start

- **WHEN** the app starts
- **THEN** Firebase Core, Analytics, and Crashlytics SHALL be initialized before `runApp()` is called

#### Scenario: AnalyticsService is accessible as singleton

- **WHEN** any widget or service needs to log an event
- **THEN** `AnalyticsService.instance` SHALL return the initialized singleton

### Requirement: Tool open event tracking

The app SHALL log a `tool_open` event via `AnalyticsService` whenever a user navigates to a tool page. The event SHALL include parameters `tool_id` (String) and `source` (String, e.g. "home", "favorites", "deep_link").

#### Scenario: User opens a tool from home page

- **WHEN** user taps a tool card on the home page
- **THEN** a `tool_open` event SHALL be logged with `tool_id` matching the tool's ID and `source` set to "home"

#### Scenario: User opens a tool from favorites

- **WHEN** user taps a tool card on the favorites page
- **THEN** a `tool_open` event SHALL be logged with `tool_id` matching the tool's ID and `source` set to "favorites"

### Requirement: Tool complete event tracking

The app SHALL log a `tool_complete` event via `AnalyticsService` when a user completes an action within a tool. The event SHALL include parameters `tool_id` (String) and `result_type` (String). The following tools SHALL trigger `tool_complete`: BMI calculator (result_type: "bmi_calculated"), split bill (result_type: "bill_split"), random wheel (result_type: "wheel_spun"), QR generator (result_type: "qr_generated").

#### Scenario: User completes BMI calculation

- **WHEN** user calculates BMI in the BMI calculator tool
- **THEN** a `tool_complete` event SHALL be logged with `tool_id` "bmi_calculator" and `result_type` "bmi_calculated"

#### Scenario: User completes split bill

- **WHEN** user calculates a split bill result
- **THEN** a `tool_complete` event SHALL be logged with `tool_id` "split_bill" and `result_type` "bill_split"

### Requirement: Tool share event tracking

The app SHALL log a `tool_share` event via `AnalyticsService` when a user shares a tool result. The event SHALL include parameters `tool_id` (String) and `share_method` (String, always "system_share" for now).

#### Scenario: User shares a tool result

- **WHEN** user taps the share button on any shareable tool
- **THEN** a `tool_share` event SHALL be logged with the corresponding `tool_id` and `share_method` "system_share"

### Requirement: Analytics route observer for page tracking

The app SHALL register an `AnalyticsRouteObserver` (extending `NavigatorObserver`) with GoRouter. The observer SHALL automatically log `screen_view` events with the route name whenever navigation occurs.

#### Scenario: User navigates between pages

- **WHEN** user navigates to any page in the app
- **THEN** a `screen_view` event SHALL be automatically logged with the route path

### Requirement: Tab switch event tracking

The app SHALL log a `tab_switch` event via `AnalyticsService` when the user switches between bottom navigation tabs. The event SHALL include a `tab_name` parameter (String: "tools", "favorites", or "settings").

#### Scenario: User switches to favorites tab

- **WHEN** user taps the favorites tab in the bottom navigation
- **THEN** a `tab_switch` event SHALL be logged with `tab_name` "favorites"

### Requirement: Crashlytics error reporting

The app SHALL configure `FlutterError.onError` to forward uncaught Flutter errors to Firebase Crashlytics. The app SHALL also capture uncaught async errors using `PlatformDispatcher.instance.onError` and report them to Crashlytics.

#### Scenario: Uncaught Flutter error occurs

- **WHEN** an uncaught Flutter framework error occurs
- **THEN** the error SHALL be reported to Firebase Crashlytics automatically

#### Scenario: Uncaught async error occurs

- **WHEN** an uncaught asynchronous error occurs
- **THEN** the error SHALL be reported to Firebase Crashlytics automatically
