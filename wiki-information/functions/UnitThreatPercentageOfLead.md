## Title: UnitThreatPercentageOfLead

**Content:**
Needs summary.
`percentage = UnitThreatPercentageOfLead(unit, mobGUID)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The player or pet whose threat to request.
- `mobGUID`
  - *string* : UnitToken - The NPC whose threat table to query.

**Returns:**
- `percentage`
  - *number*

**Reference:**
- `UnitDetailedThreatSituation()`
- `threatShowNumeric`

**Example Usage:**
This function can be used to determine the threat percentage of a player or pet relative to the lead threat holder on a specific NPC. This is particularly useful in raid and dungeon scenarios to manage aggro and ensure that tanks maintain threat over DPS players.

**Addon Usage:**
Large addons like **ThreatClassic2** use this function to provide detailed threat meters for players, helping them manage their threat levels during encounters. This is crucial for maintaining proper aggro distribution and preventing DPS players from pulling threat off the tank.