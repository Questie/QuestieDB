## Title: GetZonePVPInfo

**Content:**
Returns PVP info for the current zone.
`pvpType, isFFA, faction = GetZonePVPInfo()`

**Returns:**
- `pvpType`
  - *string* - One of the following values:
    - `"arena"` if you are in an arena
    - `"friendly"` if the zone is controlled by the faction the player belongs to.
    - `"contested"` if the zone is contested (PvP server only)
    - `"hostile"` if the zone is controlled by the opposing faction.
    - `"sanctuary"` if the zone is a sanctuary and does not allow pvp combat (2.0.x).
    - `"combat"` if it is a combat zone where players are automatically flagged for PvP combat (3.0.x). Currently applies only to the Wintergrasp zone.
    - `nil`, if the zone is none of the above. Happens inside instances, including battlegrounds, and on PvE servers when the zone would otherwise be `"contested"`.
- `isFFA`
  - *boolean* - true if in a free-for-all arena.
- `faction`
  - *string* - the name of the faction controlling the zone if `pvpType` is `"friendly"` or `"hostile"`.

**Usage:**
```lua
local zone = GetRealZoneText().." - "..tostring(GetSubZoneText())
local pvpType, isFFA, faction = GetZonePVPInfo()
local str
if pvpType == "friendly" or pvpType == "hostile" then
    str = " is controlled by "..faction.." ("..pvpType..")"
elseif pvpType == "sanctuary" then
    str = " is a PvP-free sanctuary."
elseif isFFA then
    str = " is a free-for-all arena."
else
    str = " is a contested zone."
end
print(zone..str)
-- Example output: Stormwind City - War Room is controlled by Alliance (friendly)
-- Example output: Alterac Valley - Dun Baldar Pass is a contested zone.
```