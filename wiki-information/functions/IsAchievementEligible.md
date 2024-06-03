## Title: IsAchievementEligible

**Content:**
Indicates whether the specified achievement is eligible to be completed.
`eligible = IsAchievementEligible(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - ID of the achievement to query.

**Returns:**
- `eligible`
  - *boolean*

**Description:**
This function is used in the watch frame to determine whether a tracked achievement should be shown in red text (not eligible) or normal colors (eligible).