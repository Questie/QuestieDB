## Title: GetAchievementComparisonInfo

**Content:**
Returns information about the comparison unit's achievements.
`completed, month, day, year = GetAchievementComparisonInfo(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - ID of the achievement to retrieve information for.

**Returns:**
- `completed`
  - *boolean* - Returns true/false depending on whether the unit has completed the achievement or not.
- `month`
  - *number* - Month in which the unit has completed the achievement. Returns nil if completed is false.
- `day`
  - *number* - Day of the month in which the unit has completed the achievement. Returns nil if completed is false.
- `year`
  - *number* - Year (two digits, 21st century is assumed) in which the unit has completed the achievement. Returns nil if completed is false.

**Description:**
Only accurate after the `SetAchievementComparisonUnit` is called and the `INSPECT_ACHIEVEMENT_READY` event has fired.
Inaccurate after `ClearAchievementComparisonUnit` has been called.

**Reference:**
- `ClearAchievementComparisonUnit`
- `SetAchievementComparisonUnit`
- `GetNumComparisonCompletedAchievements`