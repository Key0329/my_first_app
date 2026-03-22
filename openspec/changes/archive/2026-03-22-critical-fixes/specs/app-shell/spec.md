## ADDED Requirements

### Requirement: Platform capability guard for hardware-dependent tools

Tool pages that depend on hardware sensors (accelerometer, magnetometer, microphone, camera, flashlight) SHALL check platform capability before attempting to use the hardware. On unsupported platforms (Web, macOS, Linux, Windows), the tool page SHALL display a fallback UI instead of attempting to access hardware APIs. The fallback UI SHALL show an informative icon, a message stating "此功能需要行動裝置" (or locale equivalent), and a back navigation option. The platform check SHALL use `kIsWeb` and `Platform.isAndroid || Platform.isIOS` to determine support. The following tools SHALL implement this guard: level (accelerometer), compass (magnetometer), flashlight (torch), noise meter (microphone), color picker (camera), screen ruler (touch calibration).

#### Scenario: Opening level tool on web platform

- **WHEN** user opens the level tool on a web browser
- **THEN** the page SHALL display a fallback UI with "此功能需要行動裝置" message instead of attempting to access accelerometer

#### Scenario: Opening flashlight tool on macOS

- **WHEN** user opens the flashlight tool on macOS desktop
- **THEN** the page SHALL display a fallback UI instead of calling TorchLight APIs

#### Scenario: Opening level tool on Android

- **WHEN** user opens the level tool on an Android device
- **THEN** the page SHALL function normally with accelerometer access

### Requirement: Calculator button single event firing

Calculator buttons wrapped in BouncingButton SHALL fire their action callback exactly once per tap. The BouncingButton wrapper SHALL only provide the scale animation effect (via onTapDown/onTapUp) without setting its own onTap callback when wrapping a widget that already handles tap events (such as FilledButton). The FilledButton's onPressed SHALL be the sole event handler.

#### Scenario: Calculator digit button fires once

- **WHEN** user taps the "5" button on the calculator
- **THEN** the digit "5" SHALL be appended to the expression exactly once

#### Scenario: Calculator equals button fires once

- **WHEN** user taps the "=" button after entering "2+3"
- **THEN** the expression SHALL be evaluated exactly once producing result "5"
