## Event: ZONE_CHANGED_NEW_AREA

**Title:** ZONE CHANGED NEW AREA

**Content:**
Fires when the player enters a new zone.
`ZONE_CHANGED_NEW_AREA`

**Payload:**
- `None`

**Content Details:**
For example this fires when moving from Duskwood to Stranglethorn Vale or Durotar into Orgrimmar.
In interface terms, this is anytime you get a new set of channels.
Related API
GetChannelListC_Map.GetMapInfoGetZoneText • GetRealZoneText
Related Events
ZONE_CHANGED

**Usage:**
When moving from Stormwind City to Elwynn Forest.
```lua
local function OnEvent(self, event, ...)
    local mapID = C_Map.GetBestMapForUnit("player")
    print(event, GetZoneText(), C_Map.GetMapInfo(mapID).name)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", OnEvent)
```
> "ZONE_CHANGED_NEW_AREA", "Stormwind City", "Stormwind City"
> "ZONE_CHANGED_NEW_AREA", "Elwynn Forest", "Elwynn Forest"