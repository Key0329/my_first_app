# ci-cd-pipeline Specification

## Purpose

TBD - created by archiving change 'ci-cd-pipeline'. Update Purpose after archive.

## Requirements

### Requirement: CI workflow triggers on push and pull request

The CI workflow SHALL trigger on every push to any branch and on every pull request targeting the main branch.

#### Scenario: Push to any branch

- **WHEN** a developer pushes commits to any branch
- **THEN** the CI workflow SHALL run all checks (analyze, format, test)

#### Scenario: Pull request to main

- **WHEN** a pull request is opened or updated targeting the main branch
- **THEN** the CI workflow SHALL run all checks


<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->

---
### Requirement: Static analysis check

The CI workflow SHALL run `flutter analyze` and SHALL fail the workflow if any analysis issue is found.

#### Scenario: Clean analysis

- **WHEN** `flutter analyze` reports no issues
- **THEN** the analyze job SHALL pass

#### Scenario: Analysis issues found

- **WHEN** `flutter analyze` reports one or more issues
- **THEN** the analyze job SHALL fail


<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->

---
### Requirement: Format check

The CI workflow SHALL run `dart format --set-exit-if-changed .` and SHALL fail the workflow if any file is not properly formatted.

#### Scenario: All files formatted

- **WHEN** all Dart files match the formatter output
- **THEN** the format job SHALL pass

#### Scenario: Unformatted files found

- **WHEN** one or more Dart files differ from the formatter output
- **THEN** the format job SHALL fail


<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->

---
### Requirement: Test execution with coverage

The CI workflow SHALL run `flutter test --coverage` to execute all tests and produce an lcov coverage report. The job SHALL fail if any test fails.

#### Scenario: All tests pass

- **WHEN** all tests pass
- **THEN** the test job SHALL pass and an lcov.info file SHALL be produced

#### Scenario: Test failure

- **WHEN** one or more tests fail
- **THEN** the test job SHALL fail


<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->

---
### Requirement: Coverage threshold enforcement

The CI workflow SHALL enforce a minimum line coverage percentage. If the measured coverage is below the threshold, the test job SHALL fail. The initial threshold SHALL be 30%.

#### Scenario: Coverage above threshold

- **WHEN** line coverage is 30% or above
- **THEN** the test job SHALL pass

#### Scenario: Coverage below threshold

- **WHEN** line coverage is below 30%
- **THEN** the test job SHALL fail with a message indicating the actual coverage and the required threshold


<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->

---
### Requirement: Coverage report artifact upload

The CI workflow SHALL upload the coverage report (lcov.info) as a GitHub Actions artifact for later download.

#### Scenario: Coverage artifact uploaded

- **WHEN** the test job completes (pass or fail)
- **THEN** the lcov.info file SHALL be available as a downloadable artifact named "coverage-report"

<!-- @trace
source: ci-cd-pipeline
updated: 2026-03-22
code:
  - .github/workflows/ci.yml
-->