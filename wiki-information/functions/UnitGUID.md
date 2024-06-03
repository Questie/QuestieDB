## Title: UnitGUID

**Content:**
Returns the GUID of the unit.
`guid = UnitGUID(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - For example "player" or "target"

**Returns:**
- `guid`
  - *string?* : GUID - A string containing (hexadecimal) values, delimited with hyphens. Returns nil if the unit does not exist.

**Usage:**
Prints the target's GUID, in this case a creature.
```lua
/dump UnitName("target"), UnitGUID("target")
> "Hogger", "Creature-0-1465-0-2105-448-000043F59F"
```
Prints the npc/player ID of a unit, if applicable.
```lua
local unitLink = "|cffffff00|Hunit:%s|h|h|r"
local function ParseGUID(unit)
    local guid = UnitGUID(unit)
    local name = UnitName(unit)
    if guid then
        local link = unitLink:format(guid, name) -- clickable link
        local unit_type = strsplit("-", guid)
        if unit_type == "Creature" or unit_type == "Vehicle" then
            local _, _, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid)
            print(format("%s is a creature with NPC ID %d", link, npc_id))
        elseif unit_type == "Player" then
            local _, server_id, player_id = strsplit("-", guid)
            print(format("%s is a player with ID %s", link, player_id))
        end
    end
end
```

**Reference:**
- `GetPlayerInfoByGUID()`