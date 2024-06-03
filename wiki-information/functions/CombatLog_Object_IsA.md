## Title: CombatLog_Object_IsA

**Content:**
Returns whether a unit from the combat log matches a given filter.
`isMatch = CombatLog_Object_IsA(unitFlags, mask)`

**Parameters:**
- `unitFlags`
  - *number* - UnitFlag bitfield, i.e. sourceFlags or destFlags from COMBAT_LOG_EVENT.
- `mask`
  - *number* - COMBATLOG_FILTER constant.

**Returns:**
- `isMatch`
  - *boolean* - True if a bitfield in each of the four main categories matches.

**Description:**
Both of the arguments to this function must be valid Combat Log Objects. That is, for the four main categories of the UnitFlag bitfield, there must be at least one nonzero bit. Passing in a single COMBATLOG_OBJECT constant will cause the check to return false.

**Miscellaneous:**
- **Constant** - bit field
  - `COMBATLOG_FILTER_ME`
    - `0x0000000000000001`
  - `COMBATLOG_FILTER_MINE`
    - `0x0000000000000005`
  - `COMBATLOG_FILTER_MY_PET`
    - `0x0000000000000011`
  - `COMBATLOG_FILTER_FRIENDLY_UNITS`
    - `0x00000000000000E1`
  - `COMBATLOG_FILTER_HOSTILE_PLAYERS`
    - `0x00000000000004E1`
  - `COMBATLOG_FILTER_HOSTILE_UNITS`
    - `0x00000000000004E2`
  - `COMBATLOG_FILTER_NEUTRAL_UNITS`
    - `0x00000000000004E4`
  - `COMBATLOG_FILTER_UNKNOWN_UNITS`
    - `0x0000000000000800`
  - `COMBATLOG_FILTER_EVERYTHING`
    - `0xFFFFFFFFFFFFFFFF`

You can also construct your own filter; make sure to use at least one constant from each category:
```lua
local COMBATLOG_FILTER_FRIENDLY_PLAYERS = bit.bor(
    COMBATLOG_OBJECT_AFFILIATION_PARTY,
    COMBATLOG_OBJECT_AFFILIATION_RAID,
    COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
    COMBATLOG_OBJECT_REACTION_FRIENDLY,
    COMBATLOG_OBJECT_CONTROL_PLAYER,
    COMBATLOG_OBJECT_TYPE_PLAYER
)
```

**Usage:**
Prints if the combat log source unit is a hostile NPC.
```lua
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags = CombatLogGetCurrentEventInfo()
    if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_HOSTILE_UNITS) then
        print(subevent, sourceName, format("0x%X", sourceFlags), "is a hostile NPC")
    end
end)
```