## Event: MODIFIER_STATE_CHANGED

**Title:** MODIFIER STATE CHANGED

**Content:**
Fired when shift/ctrl/alt keys are pressed or released. Does not fire when an EditBox has keyboard focus.
`MODIFIER_STATE_CHANGED: key, down`

**Payload:**
- `key`
  - *string* - LCTRL, RCTRL, LSHIFT, RSHIFT, LALT, RALT
- `down`
  - *number* - 1 for pressed, 0 for released.

**Content Details:**
Related API
IsModifierKeyDown

**Usage:**
Prints when a modifier key is pressed down.
```lua
local function OnEvent(self, event, key, down)
    if down == 1 then
        print("pressed in", key)
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("MODIFIER_STATE_CHANGED")
f:SetScript("OnEvent", OnEvent)
```