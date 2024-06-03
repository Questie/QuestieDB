## Title: SetOptOutOfLoot

**Content:**
Sets whether to automatically pass on all loot.
`SetOptOutOfLoot(optOut)`

**Parameters:**
- `optOut`
  - *boolean* - 1 to make the player pass on all loot, nil otherwise.

**Reference:**
- `GetOptOutOfLoot`

**Example Usage:**
This function can be used in a scenario where a player wants to ensure they do not receive any loot, perhaps during a raid where they are not interested in the drops or to avoid conflicts over loot distribution.

**Addon Usage:**
Large addons like "ElvUI" or "DBM" might use this function to provide users with an option to automatically pass on loot, streamlining the looting process during raids or dungeons.