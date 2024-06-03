## Title: GetTalentGroupRole

**Content:**
Returns the currently selected role for a player talent group (primary or secondary).
`role = GetTalentGroupRole(groupIndex)`

**Parameters:**
- `groupIndex`
  - *number* - Ranging from 1 to 2 (primary/secondary talent group). To get the current one use `GetActiveTalentGroup()`

**Returns:**
- `role`
  - *string* - Can be `DAMAGER`, `TANK`, or `HEALER`

**Example Usage:**
This function can be used to determine the role of a player in a specific talent group, which can be useful for addons that manage group compositions or provide role-specific information.

**Addons:**
Large addons like "ElvUI" and "DBM (Deadly Boss Mods)" use this function to adjust their settings and alerts based on the player's role in a specific talent group. For example, DBM might change its warnings and alerts depending on whether the player is a tank, healer, or damage dealer.