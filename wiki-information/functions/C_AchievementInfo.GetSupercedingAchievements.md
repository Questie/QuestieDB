## Title: C_AchievementInfo.GetSupercedingAchievements

**Content:**
Returns the next achievement in a series.
`supercedingAchievements = C_AchievementInfo.GetSupercedingAchievements(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - AchievementID

**Returns:**
- `supercedingAchievements`
  - *number* - Only returns the next ID in a series even though it's in a table.

**Usage:**
After Level 90 (6193) comes Level 100 (9060)
```lua
/dump C_AchievementInfo.GetSupercedingAchievements(6193)
> {9060}
```