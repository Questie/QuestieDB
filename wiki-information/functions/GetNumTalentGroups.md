## Title: GetNumTalentGroups

**Content:**
Returns the total number of talent groups for the player.
`num = GetNumTalentGroups()`

**Parameters:**
- `isInspect`
  - *boolean?* = false

**Returns:**
- `num`
  - *number* - The number of talent groups. 1 by default, 2 if Dual Talent Specialization is purchased.

**Description:**
Using `isInspect` requires calling `NotifyInspect()` and awaiting `INSPECT_READY`. If not done, it returns information for the player instead.

**Related API:**
- `GetNumTalentTabs`