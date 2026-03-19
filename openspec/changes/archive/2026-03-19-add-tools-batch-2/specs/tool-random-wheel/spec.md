## ADDED Requirements

### Requirement: Spinning wheel with custom options

The random wheel SHALL display a circular wheel divided into equal-sized colored segments, one per option. The wheel SHALL be rendered using CustomPainter. A fixed triangular pointer at the top of the wheel SHALL indicate the selected segment. The system SHALL support a minimum of 2 and a maximum of 20 options.

#### Scenario: Wheel displays with default options

- **WHEN** user opens the random wheel for the first time
- **THEN** the wheel SHALL display with two default options: "Option 1" and "Option 2" (localized)

#### Scenario: User adds a new option

- **WHEN** user types an option name in the input field and taps the add button
- **THEN** the wheel SHALL add a new segment and redistribute all segments equally

#### Scenario: User removes an option

- **WHEN** user swipes left on an option in the list
- **THEN** the option SHALL be removed from the wheel and segments SHALL redistribute equally

#### Scenario: User attempts to remove below minimum

- **WHEN** only 2 options remain and user attempts to delete one
- **THEN** the deletion SHALL be prevented and the system SHALL display a message that at least 2 options are required

### Requirement: Spin animation with deceleration

The wheel SHALL spin when the user taps the spin button. The spin animation SHALL use AnimationController with CurvedAnimation and Curves.decelerate to create a natural deceleration effect. The spin duration SHALL be randomized between 2 and 4 seconds. The final resting angle SHALL determine the selected option.

#### Scenario: User spins the wheel

- **WHEN** user taps the spin button
- **THEN** the wheel SHALL rotate with a decelerating animation and stop at a random position after 2–4 seconds

#### Scenario: Spin completes

- **WHEN** the wheel stops spinning
- **THEN** the system SHALL display a dialog showing the selected option name

#### Scenario: User taps spin while already spinning

- **WHEN** user taps the spin button while the wheel is animating
- **THEN** the button SHALL be disabled and the tap SHALL be ignored

### Requirement: Option list management

The body area SHALL display a scrollable list of all current options. Each option SHALL show a color indicator matching its wheel segment color. New options SHALL be added via a text input field with an add button at the bottom of the list.

#### Scenario: User views option list

- **WHEN** the wheel has N options
- **THEN** the list SHALL show N items, each with a color dot matching the wheel segment

### Requirement: ImmersiveToolScaffold integration

The random wheel page SHALL use ImmersiveToolScaffold with tool color `Color(0xFFFF7043)`, icon `Icons.casino`, and Hero animation tag `tool_hero_random_wheel`.

#### Scenario: User opens random wheel from home page

- **WHEN** user taps the random wheel card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout
