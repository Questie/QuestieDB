## Title: UnitThreatSituation

**Content:**
Returns the threat status of the specified unit to another unit.
`status = UnitThreatSituation(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The player or pet whose threat to request.
- `mobGUID`
  - *string?* : UnitToken - The NPC whose threat table to query.
  - If omitted, returned values reflect whichever NPC unit the player unit has the highest threat against.

**Returns:**
- `status`
  - *number?* - The threat status of the unit on the mobUnit. "High threat" means a unit has 100% threat or higher, "Primary Target" means the unit is the current target of the mob.
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
      - ✅
      - ❌
      - Unit has higher than 100% threat for mobUnit, but isn't the primary target. The default UI shows a yellow indicator.
    - `2`
      - ❌
      - ✅
      - Unit is the primary target for mobUnit, but another unit has higher than 100% threat. The default UI shows an orange indicator.
    - `3`
      - ✅
      - ✅
      - Unit is the primary target for mobUnit and no other unit has higher than 100% threat. The default UI shows a red indicator.

**Description:**
Threat information for a pair of unit and mobUnit is only returned if the unit has threat against the mobUnit in question. In addition, no threat data is provided if a unit's pet is attacking an NPC but the unit himself has taken no action, even though the pet has threat against the NPC.

**Usage:**
Prints your threat status for your target if it exists. If the target does not exist or the player is not on the target's threat table, prints your threat status for any other units.
```lua
local statusText = {
    [0] = "(0) low on threat",
    [1] = "(1) high threat",
    [2] = "(2) primary target but not on high threat",
    [3] = "(3) primary target and high threat",
}
local statusTarget = UnitThreatSituation("player", "target")
if UnitExists("target") then
    local msg = statusText[statusTarget] or "not on the target's threat table"
    print("Your threat situation for target unit: "..msg)
end
if not statusTarget then
    -- not in any target unit's threat table, look if on other threat tables
    local statusAny = UnitThreatSituation("player")
    local msg = statusText[statusAny] or "not on any threat table"
    print("Your threat situation for any unit: "..msg)
end
```
> "Your threat situation for target unit: (3) primary target and high threat"

**Reference:**
- `UnitDetailedThreatSituation()`
- `GetThreatStatusColor()`
- [WoW Programming API Reference](http://wowprogramming.com/docs/api/UnitThreatSituation.html)
- Kaivax 2020-06-12. PTR Patch Notes - WoW Classic Version 1.13.5.