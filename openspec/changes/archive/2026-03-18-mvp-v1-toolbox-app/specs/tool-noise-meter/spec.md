## ADDED Requirements

### Requirement: Decibel measurement

The noise meter SHALL use the device microphone to measure ambient noise levels in decibels (dB). The current dB value SHALL be displayed prominently in real-time.

#### Scenario: User measures ambient noise

- **WHEN** user opens the noise meter and grants microphone permission
- **THEN** the current noise level in dB SHALL be displayed and update in real-time

### Requirement: Real-time chart

The noise meter SHALL display a real-time line chart showing noise level fluctuations over time.

#### Scenario: Noise levels change

- **WHEN** ambient noise levels fluctuate
- **THEN** the chart SHALL update to reflect the changes in real-time

### Requirement: Reference value comparison

The noise meter SHALL display reference values for common noise levels (e.g., whisper ~30dB, conversation ~60dB, traffic ~80dB) to help users understand the measurement context.

#### Scenario: User views reference values

- **WHEN** the noise meter is active
- **THEN** reference noise levels SHALL be displayed alongside the current measurement

### Requirement: Microphone permission handling

The noise meter SHALL request microphone permission before accessing the microphone. If permission is denied, a message SHALL explain why the permission is needed.

#### Scenario: Microphone permission denied

- **WHEN** user denies microphone permission
- **THEN** the noise meter SHALL display a message explaining microphone access is required and provide a button to open system settings
