## ADDED Requirements

### Requirement: In-app review prompt after tool usage threshold

The app SHALL track the cumulative number of tool usages. When the cumulative count reaches 3, the app SHALL request the native in-app review dialog via the `in_app_review` package. The app SHALL persist a flag indicating that a review prompt has been attempted, and SHALL NOT attempt to trigger the review prompt more than once per installation.

#### Scenario: Review prompt triggered after 3rd tool usage

- **WHEN** the user opens a tool for the 3rd cumulative time
- **THEN** the app SHALL call `InAppReview.instance.requestReview()` to trigger the native review dialog

#### Scenario: Review prompt not triggered before threshold

- **WHEN** the user has opened tools fewer than 3 cumulative times
- **THEN** the app SHALL NOT attempt to trigger the review dialog

#### Scenario: Review prompt not re-triggered after first attempt

- **WHEN** the review prompt has already been attempted once
- **THEN** the app SHALL NOT attempt to trigger the review dialog again, regardless of further tool usage

#### Scenario: Tool usage count persists across app restarts

- **WHEN** the user opens 2 tools, closes the app, then opens 1 more tool
- **THEN** the cumulative count SHALL be 3 and the review prompt SHALL be triggered
