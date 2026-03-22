## MODIFIED Requirements

### Requirement: Theme mode selection

The settings page SHALL provide a theme mode selector using a SegmentedButton with three options: Light, Dark, and System Default. The selector SHALL be displayed inside a Bento-style ToolSectionCard in the "Appearance" section. The selected mode SHALL take effect immediately and persist across app restarts. Theme and locale state SHALL be managed by a dedicated ThemeService. Changes to ThemeService SHALL trigger MaterialApp rebuild. Changes to other services (favorites, recent tools) SHALL NOT trigger MaterialApp rebuild.

#### Scenario: User changes theme mode

- **WHEN** user selects a different theme mode via the SegmentedButton
- **THEN** the app theme SHALL change immediately
- **AND** only the MaterialApp SHALL rebuild, not other unrelated widgets

#### Scenario: User toggles a favorite

- **WHEN** user toggles a favorite tool
- **THEN** the MaterialApp SHALL NOT rebuild
- **AND** only the favorite-related UI SHALL update

## ADDED Requirements

### Requirement: SharedPreferences cached instance

The AppSettings service SHALL obtain a SharedPreferences instance once during initialization and reuse it for all subsequent read and write operations. Individual setter methods SHALL NOT call SharedPreferences.getInstance() separately.

#### Scenario: Multiple settings changes in sequence

- **WHEN** a user changes theme mode and then toggles a favorite
- **THEN** both operations SHALL use the same SharedPreferences instance obtained during init()

### Requirement: Service separation

The AppSettings class SHALL delegate to three specialized sub-services: ThemeService (theme mode, locale), FavoritesService (favorites set), and UserPreferencesService (onboarding status, recent tools). Each sub-service SHALL extend ChangeNotifier and notify listeners independently. The AppSettings class SHALL remain as a facade with the same public API.

#### Scenario: AppSettings API backward compatibility

- **WHEN** existing code calls AppSettings.setThemeMode(), AppSettings.toggleFavorite(), or AppSettings.addRecentTool()
- **THEN** the calls SHALL succeed without any modification to the calling code
