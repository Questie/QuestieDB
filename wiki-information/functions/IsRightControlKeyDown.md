## Title: IsModifierKeyDown

**Content:**
Returns true if a modifier key is currently pressed down.
`isDown = IsModifierKeyDown()`
- `IsControlKeyDown()`
- `IsLeftControlKeyDown()`
- `IsRightControlKeyDown()`
- `IsShiftKeyDown()`
- `IsLeftShiftKeyDown()`
- `IsRightShiftKeyDown()`
- `IsAltKeyDown()`
- `IsLeftAltKeyDown()`
- `IsRightAltKeyDown()`

**Returns:**
- `isDown`
  - *boolean* - True if the specified modifier key is pressed down.

**Description:**
- **Related Events:**
  - `MODIFIER_STATE_CHANGED`
- **Related API:**
  - `IsModifiedClick`
  - `GetBindingByKey`

**Usage:**
Prints if the left-ctrl and left-shift modifiers are pressed down.
```lua
local function OnEvent(self, event, ...)
    if IsLeftControlKeyDown() and IsLeftShiftKeyDown() then
        print("hello")
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MODIFIER_STATE_CHANGED")
f:SetScript("OnEvent", OnEvent)
```