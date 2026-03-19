## REMOVED Requirements

### Requirement: Bento Grid layout with variable card sizes
**Reason**: Replaced by uniform 2-column grid layout in homepage-grid capability
**Migration**: Home page now uses standard GridView with equal-sized cards instead of BentoGrid with variable sizes

### Requirement: Tool cards with gradient backgrounds
**Reason**: Replaced by new card style with white/dark surface background and colored rounded-square icon
**Migration**: ToolCard widget redesigned to use solid backgrounds with centered icon containers

### Requirement: Search bar filters Bento Grid
**Reason**: Search bar replaced by category filter chips (全部/計算/測量/生活)
**Migration**: Filtering now uses ToolCategory enum instead of text search

### Requirement: Mini preview on large cards
**Reason**: Large cards no longer exist in uniform grid layout
**Migration**: Feature removed; all cards are equal size
