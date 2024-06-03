## Title: GetTradeSkillLine

**Content:**
Returns information about the current tradeskill.
`tradeskillName, currentLevel, maxLevel, skillLineModifier = GetTradeSkillLine()`

**Returns:**
- `tradeskillName`
  - *string* - Name of the current tradeskill
- `currentLevel`
  - *number* - Current skill level in the current tradeskill
- `maxLevel`
  - *number* - Current maximum skill level for the current tradeskill (based on Journeyman, Expert etc.)
- `skillLineModifier`
  - *number* - Skill modifier from racial abilities etc.

**Description:**
This function returns information about the current tradeskill, which is the one currently visible in the Trade Skill frame. If the Trade Skill frame isn't open then 'UNKNOWN' is returned for 'tradeSkillName' and zero for all other values.
Based on use of the function in Blizzard's code, 'tradeSkillName' appears to be a localized name for the tradeskill.