## Title: AddTrackedAchievement

**Content:**
Tracks an achievement.
`AddTrackedAchievement(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - ID of the achievement to add to tracking.

**Reference:**
- `TRACKED_ACHIEVEMENT_UPDATE`
- See also:
  - `RemoveTrackedAchievement`
  - `GetTrackedAchievements`
  - `GetNumTrackedAchievements`

**Description:**
A maximum of `WATCHFRAME_MAXACHIEVEMENTS` (10 as of 5.4.8) tracked achievements can be displayed by the WatchFrame at a time.
You may need to manually update the AchievementUI and WatchFrame after calling this function.