## Event: ZONE_CHANGED

**Title:** ZONE CHANGED

**Content:**
Fires when the player enters an outdoors subzone.
`ZONE_CHANGED`

**Payload:**
- `None`

**Content Details:**
Related API
GetSubZoneText
Related Events
ZONE_CHANGED_NEW
AREAZONE_CHANGED_INDOORS

**Usage:**
In Stormwind, when moving from Valley of Heroes to Trade District.
```lua
local function OnEvent(self, event, ...)
    print(event, GetSubZoneText())
end

local f = CreateFrame("Frame")
f:RegisterEvent("ZONE_CHANGED")
f:SetScript("OnEvent", OnEvent)
```
> "ZONE_CHANGED", "Valley of Heroes"
> "ZONE_CHANGED", "Trade District"