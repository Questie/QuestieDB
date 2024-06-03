## Title: GetNumTrackedAchievements

**Content:**
Returns the number of tracked achievements.
`numTracked = GetNumTrackedAchievements()`

**Returns:**
- `numTracked`
  - *number* - number of achievements you are currently tracking, up to 10.

**Reference:**
- `AddTrackedAchievement`
- `GetTrackedAchievements`
- `RemoveTrackedAchievement`

**Example Usage:**
This function can be used to determine how many achievements a player is currently tracking. For instance, an addon could use this to display a list of tracked achievements or to ensure that the player does not exceed the tracking limit.

**Addon Usage:**
Large addons like "Overachiever" use this function to manage and display tracked achievements, providing players with enhanced achievement tracking and management features.