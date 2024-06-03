## Title: GetNumComparisonCompletedAchievements

**Content:**
Returns the number of completed achievements for the comparison player.
`total, completed = GetNumComparisonCompletedAchievements(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - ID of the achievement to retrieve information for.

**Returns:**
- `total`
  - *number* - Total number of achievements currently in the game.
- `completed`
  - *number* - Number of achievements completed by the comparison unit.

**Description:**
- Does not include Feats of Strength.
- Only accurate after the `SetAchievementComparisonUnit` is called and the `INSPECT_ACHIEVEMENT_READY` event has fired.
- Inaccurate after `ClearAchievementComparisonUnit` has been called.

**Reference:**
- `SetAchievementComparisonUnit` - to select a target before using this function.
- `ClearAchievementComparisonUnit` - to clear the selection after using this function.
- `GetNumCompletedAchievements` - for details about the player's own progress.