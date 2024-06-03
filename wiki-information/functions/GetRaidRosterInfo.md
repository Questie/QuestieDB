## Title: GetRaidRosterInfo

**Content:**
Returns info for a member of your raid.
`name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(raidIndex)`

**Parameters:**
- `raidIndex`
  - *number* - The index of a raid member between 1 and MAX_RAID_MEMBERS (40). It's discouraged to use GetNumGroupMembers() since there can be "holes" between raid1 to raid40.

**Returns:**
- `name`
  - *string* - raid member's name. Returns "Name-Server" for cross-realm players.
- `rank`
  - *number* - Returns 2 if the raid member is the leader of the raid, 1 if the raid member is promoted to assistant, and 0 otherwise.
- `subgroup`
  - *number* - The raid party this character is currently a member of. Raid subgroups are numbered as on the standard raid window.
- `level`
  - *number* - The level of the character. If this character is offline, the level will show as 0 (not nil).
- `class`
  - *string* - The character's class (localized), with the first letter capitalized (e.g. "Priest"). This function works as normal for offline characters.
- `fileName`
  - *string* - The system representation of the character's class; always in English, always fully capitalized.
- `zone`
  - *string?* - The name of the zone this character is currently in. This is the value returned by GetRealZoneText. It is the same value you see if you mouseover their portrait (if in group). If the character is offline, this value will be the string "Offline".
- `online`
  - *boolean* - Returns 1 if raid member is online, nil otherwise.
- `isDead`
  - *boolean* - Returns 1 if raid member is dead (hunters Feigning Death are considered alive), nil otherwise.
- `role`
  - *string* - The player's role within the raid ("maintank" or "mainassist").
- `isML`
  - *boolean* - Returns 1 if the raid member is master looter, nil otherwise.
- `combatRole`
  - *string* - Returns the combat role of the player if one is selected, i.e. "DAMAGER", "TANK" or "HEALER". Returns "NONE" otherwise.

**Description:**
Do not make any assumptions about raidid (raid1, raid2, etc) to name mappings remaining the same or not. When the raid changes, people MAY retain it or not, depending on raid size and WoW patch. Yes, this behavior has changed with patches in the past and may do it again.
`zone` can return nil for oneself (unitId == "player") if one has not changed locations since last reloading the UI. After changing locations, this returns. Use `PlayerLocation:CreateFromUnit("player")` as a workaround.
When an out of bounds index is used (more than the players in a raid, or beyond MAX_RAID_MEMBERS), some non-nil return values are possible: =0, =1, =1, =false, ="NONE".