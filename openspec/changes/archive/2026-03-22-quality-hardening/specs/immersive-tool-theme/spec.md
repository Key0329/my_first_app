## ADDED Requirements

### Requirement: Unified error state display

Tool pages that encounter errors (sensor initialization failure, network errors, permission denied) SHALL display a standardized error state within a ToolSectionCard. The error state SHALL use `colorScheme.error` for text and icon color, SHALL display `Icons.error_outline` as the error icon, and SHALL center the error message within the card. An optional retry button SHALL be provided when the error is recoverable. The error state pattern SHALL be consistent across all tool pages.

#### Scenario: Sensor initialization failure shows error state

- **WHEN** a sensor-dependent tool (noise meter, compass, level) fails to initialize its sensor
- **THEN** the tool page SHALL display the standardized error state with the error icon, an error message in colorScheme.error color, and a retry button

#### Scenario: Error state uses consistent styling

- **WHEN** any tool page displays an error state
- **THEN** the error icon SHALL be Icons.error_outline, the text color SHALL be colorScheme.error, and the layout SHALL be centered within a ToolSectionCard

#### Scenario: Retry button triggers re-initialization

- **WHEN** user taps the retry button on an error state display
- **THEN** the tool SHALL attempt to re-initialize the failed resource and show a loading indicator during the attempt

### Requirement: Confirmation dialog for destructive actions

Tool pages with destructive actions SHALL display a confirmation dialog before executing the action. The confirmation dialog SHALL use `showAdaptiveDialog` with `AlertDialog.adaptive` for platform-appropriate styling. The destructive action button SHALL use `colorScheme.error` color. The following actions SHALL require confirmation: calculator clear history, stopwatch reset, and random wheel delete option.

#### Scenario: Calculator clear history shows confirmation

- **WHEN** user taps the clear history button in the calculator
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the action before clearing the history

#### Scenario: Stopwatch reset shows confirmation

- **WHEN** user taps the reset button on the stopwatch while it has recorded time or laps
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the reset action

#### Scenario: Random wheel delete option shows confirmation

- **WHEN** user attempts to delete an option from the random wheel
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the deletion

#### Scenario: Destructive button uses error color

- **WHEN** a confirmation dialog is displayed for any destructive action
- **THEN** the confirm/delete button SHALL use colorScheme.error as its text or background color

### Requirement: NumberPicker controller lifecycle fix

All widget pages that create controllers (TextEditingController, ScrollController, or similar) for NumberPicker or other input widgets SHALL create the controller in `initState` and call `controller.dispose()` in the `dispose` method. Controllers SHALL NOT be created inside the `build` method. The random wheel page SHALL be the primary target for this fix.

#### Scenario: Random wheel page disposes controllers properly

- **WHEN** the random wheel page is removed from the widget tree
- **THEN** all controllers created by the page SHALL be disposed via the dispose method

#### Scenario: Controllers are not recreated on rebuild

- **WHEN** the random wheel page widget rebuilds due to state changes
- **THEN** existing controllers SHALL be reused and SHALL NOT be recreated in the build method
