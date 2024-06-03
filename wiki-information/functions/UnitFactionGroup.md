## Title: UnitFactionGroup

**Content:**
Returns the faction (Horde/Alliance) a unit belongs to.
`englishFaction, localizedFaction = UnitFactionGroup(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `englishFaction`
  - *string* - Unit's faction name in English, i.e. "Alliance", "Horde", "Neutral" or nil.
- `localizedFaction`
  - *string* - Unit's faction name in the client's locale or nil.

**Description:**
The function may not return correct results until after the `PLAYER_ENTERING_WORLD` event for units other than "player".
Note that for NPCs, the function will only return Alliance/Horde for factions closely allied with either side. Goblins, for instance, return nil,nil.
Pandaren player characters on the Wandering Isle return "Neutral", "".

**Example Usage:**
```lua
local englishFaction, localizedFaction = UnitFactionGroup("player")
print("Faction in English: ", englishFaction)
print("Faction in Localized: ", localizedFaction)
```

**Addons Using This Function:**
- **Recount**: Uses `UnitFactionGroup` to differentiate between factions when displaying damage and healing statistics.
- **Details! Damage Meter**: Utilizes this function to provide faction-specific data breakdowns in battlegrounds and world PvP scenarios.