## ADDED Requirements

### Requirement: ShareButton widget in tool actions

The app SHALL provide a reusable `ShareButton` widget that displays a share icon button. The `ShareButton` SHALL be placed in the `ImmersiveToolScaffold` actions area of each shareable tool page. The button SHALL use the `Icons.share` icon and match the existing AppBar action button style.

#### Scenario: ShareButton is visible on shareable tool page

- **WHEN** user opens a shareable tool (split bill, random wheel, BMI calculator, or QR generator)
- **THEN** a share icon button SHALL be displayed in the AppBar actions area

### Requirement: Split bill share text template

When the user taps the share button on the split bill tool, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the total amount, per-person amount, number of people, and a deep link URL `https://spectra.app/tools/split-bill`.

#### Scenario: User shares split bill result

- **WHEN** user taps the share button after calculating a split bill
- **THEN** the system share sheet SHALL open with text including the total amount, per-person amount, number of people, and the deep link URL

### Requirement: Random wheel share text template

When the user taps the share button on the random wheel tool after spinning, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the selected result item and a deep link URL `https://spectra.app/tools/random-wheel`.

#### Scenario: User shares random wheel result

- **WHEN** user taps the share button after the wheel has selected a result
- **THEN** the system share sheet SHALL open with text including the selected item and the deep link URL

### Requirement: BMI calculator share text template

When the user taps the share button on the BMI calculator tool after calculating, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the BMI value, the BMI classification, height, weight, and a deep link URL `https://spectra.app/tools/bmi-calculator`.

#### Scenario: User shares BMI result

- **WHEN** user taps the share button after calculating BMI
- **THEN** the system share sheet SHALL open with text including the BMI value, classification, height, weight, and the deep link URL

### Requirement: QR generator share image and text

When the user taps the share button on the QR generator tool after generating a QR code, the app SHALL invoke the system share sheet via `share_plus` with the QR code image and a text message containing a deep link URL `https://spectra.app/tools/qr-generator`.

#### Scenario: User shares QR code result

- **WHEN** user taps the share button after generating a QR code
- **THEN** the system share sheet SHALL open with the QR code image and a text message including the deep link URL

### Requirement: Share button disabled state before result

The `ShareButton` SHALL be disabled (grayed out, non-tappable) when the tool has not yet produced a result. It SHALL become enabled only after the user completes an action that produces a shareable result.

#### Scenario: Share button is disabled before calculation

- **WHEN** user opens BMI calculator but has not yet calculated a result
- **THEN** the share button SHALL be visually disabled and non-tappable

#### Scenario: Share button becomes enabled after result

- **WHEN** user completes a BMI calculation
- **THEN** the share button SHALL become enabled and tappable
