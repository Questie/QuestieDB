## Title: GetLootMethod

**Content:**
Returns the current loot method.
`lootmethod, masterlooterPartyID, masterlooterRaidID = GetLootMethod()`

**Returns:**
- `lootmethod`
  - *string (LootMethod)* - One of 'freeforall', 'roundrobin', 'master', 'group', 'needbeforegreed', 'personalloot'. Appears to be 'freeforall' if you are not grouped.
- `masterlooterPartyID`
  - *number* - Returns 0 if player is the master looter, 1-4 if party member is master looter (corresponding to party1-4) and nil if the master looter isn't in the player's party or master looting is not used.
- `masterlooterRaidID`
  - *number* - Returns index of the master looter in the raid (corresponding to a raidX unit), or nil if the player is not in a raid or master looting is not used.