## Title: GetTalentTabInfo

**Content:**
Returns information for a talent tab (tree).
`name, texture, pointsSpent, fileName = GetTalentTabInfo(index)`

**Parameters:**
- `index`
  - *number* - Ranging from 1 to `GetNumTalentTabs()`
- `isInspect`
  - *boolean?* - Optional, will return talent tab info for the current inspect target if true (see `NotifyInspect`).
- `isPet`
  - *boolean?* - Optional, will return talent tab info for the players' pet if true.
- `talentGroup`
  - *number?* - Optional talent group to query for Dual Talent Specialization. Defaults to 1 for the primary specialization.

**Returns:**
- `name`
  - *string*
- `texture`
  - *string* - This is always nil on Classic.
- `pointsSpent`
  - *number* - Number of points put into the tab.
- `fileName`
  - *string* - File name of the background image.

**Usage:**
An example of how to use the `fileName` return value would be:
```lua
string.format("Interface\\TalentFrame\\%s-TopLeft", fileName)
```