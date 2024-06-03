## Title: GetCraftDisplaySkillLine

**Content:**
This command retrieves displayable information for the current craft.
`name, rank, maxRank = GetCraftDisplaySkillLine()`

**Returns:**
- `name`
  - *string* - The name of the active craft, or nil if the current craft has no displayable name. Also nil if there are no active crafting windows.
- `rank`
  - *number* - The player's current rank for the named craft, if applicable.
- `maxRank`
  - *number* - The maximum rank for the named craft, if applicable.

**Description:**
The two crafts, Beast Training and Enchanting, have a slightly different UI: the latter has a blue progress bar at the top of the window indicating the player's rank while the former does not. Accordingly, this function returns nil when the Beast Training window is open, while all return values should be valid when the Enchanting window is open.

**Reference:**
`GetCraftSkillLine()` returns the name of the currently active crafting window regardless of whether the name should be displayed.