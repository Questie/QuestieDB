## Title: GetAchievementCategory

**Content:**
Returns the category number the requested achievement belongs to.
`categoryID = GetAchievementCategory(achievementID)`

**Parameters:**
- `achievementID`
  - *number* - ID of the achievement to retrieve information for.

**Returns:**
- `categoryID`
  - *number* - ID of the achievement's category.

**Reference:**
- `GetAchievementComparisonInfo`
- `SetAchievementComparisonUnit`
- `GetNumComparisonCompletedAchievements`

**Example Usage:**
This function can be used to categorize achievements in an addon that tracks player progress. For instance, an addon like "Overachiever" might use this function to organize achievements into their respective categories for easier navigation and display.

**Addons Using This Function:**
- **Overachiever**: This popular achievement tracking addon uses `GetAchievementCategory` to sort and display achievements by their categories, helping players to focus on specific types of achievements they want to complete.