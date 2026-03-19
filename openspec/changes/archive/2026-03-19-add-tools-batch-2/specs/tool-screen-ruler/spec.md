## ADDED Requirements

### Requirement: Credit card PPI calibration

On first use (or when no calibration data exists), the screen ruler SHALL display a calibration screen with a credit card outline (standard ISO/IEC 7810 ID-1: 85.6mm × 53.98mm). The user SHALL adjust the outline size using a slider until it matches a physical credit card placed on the screen. The system SHALL calculate screen PPI from the known physical dimension and the calibrated pixel dimension. The calibrated PPI value SHALL be persisted to SharedPreferences.

#### Scenario: First-time calibration

- **WHEN** user opens the screen ruler with no saved PPI value
- **THEN** the system SHALL display the calibration screen with a credit card outline and a size adjustment slider

#### Scenario: User completes calibration

- **WHEN** user adjusts the slider to match the credit card and taps "Complete Calibration"
- **THEN** the system SHALL calculate PPI as (card pixel width / 85.6mm × 25.4), save it to SharedPreferences, and transition to the ruler display

#### Scenario: Calibration data already exists

- **WHEN** user opens the screen ruler with a saved PPI value
- **THEN** the system SHALL skip calibration and display the ruler directly

### Requirement: Dual-scale ruler display

After calibration, the screen ruler SHALL display a ruler along the left edge of the screen using CustomPainter. The ruler SHALL show dual scales: centimeters on the left side and inches on the right side.

Centimeter markings:
- Every millimeter: short tick mark
- Every 5 millimeters: medium tick mark
- Every centimeter: long tick mark with number label

Inch markings:
- Every 1/16 inch: short tick mark
- Every 1/4 inch: medium tick mark
- Every inch: long tick mark with number label

#### Scenario: User views the ruler

- **WHEN** the ruler is displayed after calibration
- **THEN** the ruler SHALL show accurate centimeter and inch markings based on the calibrated PPI value

#### Scenario: User scrolls the ruler

- **WHEN** user scrolls vertically on the ruler
- **THEN** the ruler markings SHALL scroll to allow measuring lengths beyond the visible screen area

### Requirement: Recalibration option

The header area SHALL display the current PPI value and a "Recalibrate" button. Tapping the button SHALL return to the calibration screen.

#### Scenario: User initiates recalibration

- **WHEN** user taps the "Recalibrate" button
- **THEN** the system SHALL display the calibration screen with the slider preset to the current PPI value

### Requirement: ImmersiveToolScaffold integration

The screen ruler page SHALL use ImmersiveToolScaffold with tool color `Color(0xFF5C6BC0)`, icon `Icons.square_foot`, and Hero animation tag `tool_hero_screen_ruler`.

#### Scenario: User opens screen ruler from home page

- **WHEN** user taps the screen ruler card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout
