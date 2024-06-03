## Event: ZONE_CHANGED_INDOORS

**Title:** ZONE CHANGED INDOORS

**Content:**
Fires when the player enters an indoors subzone.
`ZONE_CHANGED_INDOORS`

**Payload:**
- `None`

**Content Details:**
Related API
GetSubZoneText
Related Events
ZONE_CHANGED

**Usage:**
In Shrine of Seven Stars, when moving from The Emperor's Step to The Golden Lantern.
```lua
local function OnEvent(self, event, ...)
    print(event, GetSubZoneText())
end

local f = CreateFrame("Frame")
f:RegisterEvent("ZONE_CHANGED_INDOORS")
f:SetScript("OnEvent", OnEvent)
> "ZONE_CHANGED_INDOORS", "The Emperor's Step"
> "ZONE_CHANGED_INDOORS", "The Golden Lantern"
```