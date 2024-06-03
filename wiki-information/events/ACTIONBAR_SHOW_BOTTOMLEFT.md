## Event: ACTIONBAR_SHOW_BOTTOMLEFT

**Title:** ACTIONBAR SHOW BOTTOMLEFT

**Content:**
Fires if the bottom-left multi-action bar must appear to hold a new ability.
`ACTIONBAR_SHOW_BOTTOMLEFT`

**Payload:**
- `None`

**Content Details:**
The first return value from GetActionBarToggles() changes from false to true before this event fires.
This event fires (if necessary) before SPELL_PUSHED_TO_ACTIONBAR.

**Usage:**
```lua
-- prevent the MultiBarBottomLeft from appearing when the event fires
ActionBarController:UnregisterEvent("ACTIONBAR_SHOW_BOTTOMLEFT")
-- return the options to their previous state, for the next /reload
local frame = CreateFrame("Frame")
frame:RegisterEvent("ACTIONBAR_SHOW_BOTTOMLEFT")
frame:SetScript("OnEvent", function()
    local __, bottomRight, sideRight, sideLeft = GetActionBarToggles()
    SetActionBarToggles(false, bottomRight, sideRight, sideLeft)
end)
```