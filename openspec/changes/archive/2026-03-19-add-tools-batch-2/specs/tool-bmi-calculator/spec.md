## ADDED Requirements

### Requirement: BMI calculation from height and weight

The BMI calculator SHALL accept height input in centimeters (range 140–220) and weight input in kilograms (range 30–200) via interactive sliders. The system SHALL calculate BMI using the formula: BMI = weight(kg) / height(m)². The result SHALL update in real-time as the user adjusts either slider.

#### Scenario: User adjusts height and weight sliders

- **WHEN** user moves the height or weight slider
- **THEN** the BMI value SHALL recalculate and display immediately without requiring a submit action

#### Scenario: Default values on first open

- **WHEN** user opens the BMI calculator for the first time
- **THEN** the height slider SHALL default to 170 cm and the weight slider SHALL default to 65 kg

### Requirement: BMI category classification display

The system SHALL classify the calculated BMI into four categories based on WHO standards and display the category with a corresponding color indicator:
- Underweight (< 18.5): blue
- Normal (18.5–24.9): green
- Overweight (25.0–29.9): orange
- Obese (≥ 30.0): red

The header area SHALL display a circular gauge visualization showing the BMI value with a color band representing the category ranges.

#### Scenario: BMI falls in normal range

- **WHEN** the calculated BMI is between 18.5 and 24.9
- **THEN** the system SHALL display "Normal" category label with green color indicator and the gauge pointer SHALL point to the normal range zone

#### Scenario: BMI falls in obese range

- **WHEN** the calculated BMI is 30.0 or above
- **THEN** the system SHALL display "Obese" category label with red color indicator and the gauge pointer SHALL point to the obese range zone

### Requirement: Healthy weight range suggestion

The system SHALL calculate and display the healthy weight range (BMI 18.5–24.9) for the currently selected height.

#### Scenario: User views healthy weight range

- **WHEN** user has set a height value
- **THEN** the system SHALL display the minimum and maximum weight values that correspond to a normal BMI for that height

### Requirement: ImmersiveToolScaffold integration

The BMI calculator page SHALL use ImmersiveToolScaffold with tool color `Color(0xFFE91E63)`, icon `Icons.monitor_heart`, and Hero animation tag `tool_hero_bmi_calculator`.

#### Scenario: User opens BMI calculator from home page

- **WHEN** user taps the BMI calculator card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout
