# tool-registry Specification

## Purpose

TBD - created by archiving change 'tool-registry'. Update Purpose after archive.

## Requirements

### Requirement: ToolItem carries pageBuilder

Each ToolItem in the allTools list SHALL include a `pageBuilder` field of type `Widget Function()` that returns the tool's page widget. The pageBuilder SHALL be invoked lazily — only when the route is navigated to, not at list initialization time.

#### Scenario: ToolItem declares its page constructor

- **WHEN** a ToolItem is defined in allTools
- **THEN** it SHALL have a pageBuilder that returns the corresponding tool page widget (e.g., `() => const CalculatorPage()`)

#### Scenario: pageBuilder is lazy

- **WHEN** the app initializes and allTools is created
- **THEN** no tool page widgets SHALL be constructed until a user navigates to that tool's route


<!-- @trace
source: tool-registry
updated: 2026-03-22
code:
  - lib/app.dart
  - lib/models/tool_item.dart
tests:
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
-->

---
### Requirement: Tool routes auto-generated from allTools

The app router SHALL generate one GoRoute per ToolItem in allTools, using `tool.routePath` as the path and `tool.pageBuilder()` as the child widget. Each auto-generated route SHALL use CustomTransitionPage with FadeTransition, matching the existing transition behavior.

#### Scenario: Route matches ToolItem routePath

- **WHEN** the router is built
- **THEN** for each ToolItem in allTools, a GoRoute SHALL exist with path equal to `tool.routePath`

#### Scenario: Navigation to auto-generated route

- **WHEN** a user navigates to a tool's routePath (e.g., `/tools/calculator`)
- **THEN** the corresponding tool page SHALL be displayed with a FadeTransition


<!-- @trace
source: tool-registry
updated: 2026-03-22
code:
  - lib/app.dart
  - lib/models/tool_item.dart
tests:
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
-->

---
### Requirement: Single-point tool registration

Adding a new tool to the app SHALL require modifying only the allTools list in `tool_item.dart`. No changes to `app.dart` route definitions SHALL be necessary.

#### Scenario: Adding a new tool

- **WHEN** a developer adds a new ToolItem entry to allTools with id, nameKey, fallbackName, icon, routePath, category, and pageBuilder
- **THEN** the tool SHALL appear on the homepage AND have a working route without any other file modifications

<!-- @trace
source: tool-registry
updated: 2026-03-22
code:
  - lib/app.dart
  - lib/models/tool_item.dart
tests:
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
-->