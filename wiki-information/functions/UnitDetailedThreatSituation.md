## Title: UnitDetailedThreatSituation

**Content:**
Returns detailed info for the threat status of one unit against another.
`isTanking, status, scaledPercentage, rawPercentage, rawThreat = UnitDetailedThreatSituation(unit, mobGUID)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The player or pet whose threat to request.
- `mobGUID`
  - *string* : UnitToken - The NPC whose threat table to query.

**Returns:**
- `isTanking`
  - *boolean* - Returns true if the unit is the primary threat target of the mobUnit, returns false otherwise.
- `status`
  - *number* - Threat status of the unit on the mobUnit.
- `scaledPercentage`
  - *number* - The unit's threat percentage against mobUnit. At 100% the unit will become the primary target. This value is also scaled the closer the unit is to the mobUnit.
- `rawPercentage`
  - *number* - The unit's threat percentage against mobUnit relative to the threat of mobUnit's primary target. Can be greater than 100, up to 255. Stops updating when you become the primary target.
- `threatValue`
  - *number* - The unit's total threat value on the mobUnit.

**Status Values:**
- `status`
  - `Value`
  - `High Threat`
  - `Primary Target`
  - `Description`
  - `nil`
    - Unit is not on (any) mobUnit's threat table.
  - `0`
    - ❌
    - ❌
    - Unit has less than 100% threat for mobUnit. The default UI shows no indicator.
  - `1`
    - ✔️
    - ❌
    - Unit has higher than 100% threat for mobUnit, but isn't the primary target. The default UI shows a yellow indicator.
  - `2`
    - ❌
    - ✔️
    - Unit is the primary target for mobUnit, but another unit has higher than 100% threat. The default UI shows an orange indicator.
  - `3`
    - ✔️
    - ✔️
    - Unit is the primary target for mobUnit and no other unit has higher than 100% threat. The default UI shows a red indicator.

**Description:**
From wowprogramming.com's API reference:
"The different values returned by this function reflect the complexity of NPC threat management:
Raw threat roughly equates to the amount of damage a unit has caused to the NPC plus the amount of healing the unit has performed in the NPC's presence. (Each quantity that goes into this sum may be modified, however; such as by a paladin's self-buff, a priest's talent, or a player whose cloak is enchanted with Subtlety.)
Generally, whichever unit has the highest raw threat against an NPC becomes its primary target, and raw threat percentage simplifies this comparison.
However, most NPCs are designed to maintain some degree of target focus -- so that they don't rapidly switch targets if, for example, a unit other than the primary target suddenly reaches 101% raw threat. The amount by which a unit must surpass the primary target's threat to become the new primary target varies by distance from the NPC.
Thus, a scaled percentage value is given to provide clarity. The rawPercent value returned from this function can be greater than 100 (indicating that unit has greater threat against mobUnit than mobUnit's primary target, and is thus in danger of becoming the primary target), but the scaledPercent value will always be 100 or lower.
Threat information for a pair of unit and mobUnit is only returned if the unit has threat against the mobUnit in question. In addition, no threat data is provided if a unit's pet is attacking an NPC but the unit himself has taken no action, even though the pet has threat against the NPC.)"
When mobs are socially pulled (i.e. they aggro indirectly, as a result of another nearby mob being pulled), 'status' often sets to 0 instead of 3, despite the player having aggro.

**Usage:**
- `/dump UnitDetailedThreatSituation("player", "target")`
  - You have 100% threat on the targeted NPC.
    - `true, 3, 100, 100, 15`
  - You have partial threat on the targeted NPC: 66% threat on the mobUnit, 73% threat relative to the primary target, threat value amount of 25.
    - `false, 0, 66.363632202148, 73, 25`

**Reference:**
- `UnitThreatSituation()`
- `GetThreatStatusColor()`
- `UNIT_THREAT_SITUATION_UPDATE`
- `UNIT_THREAT_LIST_UPDATE`
- `threatShowNumeric`

**External Resources:**
- [Wowhead Classic WoW Threat Guide by Ragorism](https://classic.wowhead.com/guides/classic-wow-threat-guide)