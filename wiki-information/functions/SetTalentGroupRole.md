## Title: SetTalentGroupRole

**Content:**
Sets the role for a player talent group (primary or secondary).
`SetTalentGroupRole(groupIndex, role)`

**Parameters:**
- `groupIndex`
  - *number* - Ranging from 1 to 2 (primary/secondary talent group). To get the current one use `GetActiveTalentGroup()`
- `role`
  - *string* - Can be `DAMAGER`, `TANK`, or `HEALER`. If an invalid role is given, it defaults to `DAMAGER`.

**Example Usage:**
```lua
-- Set the primary talent group to the role of TANK
SetTalentGroupRole(1, "TANK")

-- Set the secondary talent group to the role of HEALER
SetTalentGroupRole(2, "HEALER")
```

**Additional Information:**
This function is particularly useful in addons that manage talent builds and roles, such as `Talent Set Manager` or `Action Bar Saver`. These addons often allow players to quickly switch between different talent setups and corresponding roles, optimizing their performance for different types of content (e.g., dungeons, raids, PvP).