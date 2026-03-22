## ADDED Requirements

### Requirement: Pure logic unit tests for compass tool

The compass tool SHALL have unit tests covering the degree-to-direction conversion function. Tests SHALL verify that 0 degrees maps to North, 90 degrees maps to East, 180 degrees maps to South, 270 degrees maps to West, and intermediate angles map to the correct intercardinal directions (NE, SE, SW, NW). The test file SHALL be located at `test/tools/compass_logic_test.dart`.

#### Scenario: Cardinal direction mapping is correct

- **WHEN** the degreeToDirection function receives 0, 90, 180, or 270 degrees
- **THEN** it SHALL return "N", "E", "S", or "W" respectively

#### Scenario: Intercardinal direction mapping is correct

- **WHEN** the degreeToDirection function receives 45, 135, 225, or 315 degrees
- **THEN** it SHALL return "NE", "SE", "SW", or "NW" respectively

### Requirement: Pure logic unit tests for color picker tool

The color picker tool SHALL have unit tests covering RGB-to-HSL conversion, HSL-to-RGB conversion, and hex string parsing functions. Tests SHALL verify round-trip consistency (RGB -> HSL -> RGB produces the same values within floating-point tolerance). The test file SHALL be located at `test/tools/color_picker_logic_test.dart`.

#### Scenario: RGB to HSL round-trip consistency

- **WHEN** an RGB color value is converted to HSL and back to RGB
- **THEN** the resulting RGB values SHALL match the original values within a tolerance of 1

#### Scenario: Hex string parsing handles valid and invalid input

- **WHEN** a valid 6-character hex string (e.g., "FF5733") is parsed
- **THEN** the function SHALL return the correct Color object
- **WHEN** an invalid hex string is parsed
- **THEN** the function SHALL return null or a default color

### Requirement: Pure logic unit tests for flashlight tool

The flashlight tool SHALL have unit tests covering the SOS frequency timing calculation. Tests SHALL verify that the SOS pattern produces correct on/off durations for dots (short), dashes (long), and inter-character pauses. The test file SHALL be located at `test/tools/flashlight_logic_test.dart`.

#### Scenario: SOS pattern timing is correct

- **WHEN** the SOS pattern generator produces timing intervals
- **THEN** dot duration SHALL be shorter than dash duration and pause durations SHALL follow standard Morse code ratios

### Requirement: Pure logic unit tests for level tool

The level tool SHALL have unit tests covering accelerometer-to-tilt-angle conversion and the horizontal threshold check function. Tests SHALL verify that zero acceleration produces 0 degrees tilt and that the isLevel function returns true only when the angle is within the defined threshold. The test file SHALL be located at `test/tools/level_logic_test.dart`.

#### Scenario: Zero acceleration produces zero tilt

- **WHEN** accelerometer x and y values are both 0
- **THEN** the calculated tilt angle SHALL be 0 degrees

#### Scenario: Level threshold detection is accurate

- **WHEN** the tilt angle is within the defined threshold (e.g., 2 degrees)
- **THEN** the isLevel function SHALL return true
- **WHEN** the tilt angle exceeds the threshold
- **THEN** the isLevel function SHALL return false

### Requirement: Pure logic unit tests for noise meter tool

The noise meter tool SHALL have unit tests covering the dB-to-color mapping function and the dB level classification function. Tests SHALL verify that low dB values map to green, medium values map to yellow/orange, and high values map to red. The test file SHALL be located at `test/tools/noise_meter_logic_test.dart`.

#### Scenario: Low dB maps to safe color

- **WHEN** the dB value is below 60
- **THEN** the color mapping function SHALL return a green-family color

#### Scenario: High dB maps to danger color

- **WHEN** the dB value is above 85
- **THEN** the color mapping function SHALL return a red-family color

#### Scenario: dB level classification is correct

- **WHEN** a dB value is classified
- **THEN** the classification SHALL return the correct category label (e.g., quiet, moderate, loud, dangerous)

### Requirement: Pure logic unit tests for protractor tool

The protractor tool SHALL have unit tests covering the two-point angle calculation function and the angle normalization function. Tests SHALL verify that the angle between two points is calculated correctly and that angles are normalized to the 0-360 range. The test file SHALL be located at `test/tools/protractor_logic_test.dart`.

#### Scenario: Angle between two points is calculated correctly

- **WHEN** two points form a known angle (e.g., horizontal line produces 0 degrees)
- **THEN** the calculated angle SHALL match the expected value within 0.1 degree tolerance

#### Scenario: Angle normalization wraps negative values

- **WHEN** a negative angle (e.g., -45 degrees) is normalized
- **THEN** the result SHALL be the equivalent positive angle (315 degrees)

### Requirement: Pure logic unit tests for screen ruler tool

The screen ruler tool SHALL have unit tests covering the PPI calculation function and the pixel-to-physical-unit conversion functions (pixels to centimeters, pixels to inches). Tests SHALL verify correct conversion with known device PPI values. The test file SHALL be located at `test/tools/screen_ruler_logic_test.dart`.

#### Scenario: PPI calculation from screen dimensions is correct

- **WHEN** screen width, height in pixels, and diagonal size in inches are provided
- **THEN** the calculated PPI SHALL match the expected value within 0.1 tolerance

#### Scenario: Pixel to centimeter conversion is accurate

- **WHEN** a pixel count and PPI value are provided
- **THEN** the conversion to centimeters SHALL be accurate within 0.01 cm tolerance
