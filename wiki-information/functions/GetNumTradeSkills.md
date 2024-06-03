## Title: GetNumTradeSkills

**Content:**
Get the number of trade skill entries (including headers)
`numSkills = GetNumTradeSkills()`

**Returns:**
- `numSkills`
  - *number* - The number of trade skills which are available (including headers)

**Example Usage:**
This function can be used to determine the total number of trade skills a player has, including headers which are used to categorize the skills. This is useful for addons that need to display or manage the player's trade skills.

**Addon Usage:**
Large addons like TradeSkillMaster (TSM) use this function to gather information about the player's trade skills. TSM uses this data to provide detailed management and automation of crafting, auctioning, and other trade skill-related activities.