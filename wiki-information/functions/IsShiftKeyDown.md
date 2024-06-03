## Title: IsModifierKeyDown

**Content:**
Returns true if a modifier key is currently pressed down.
`isDown = IsModifierKeyDown() <- IsControlKeyDown() <- IsLeftControlKeyDown() <- IsRightControlKeyDown() <- IsShiftKeyDown() <- IsLeftShiftKeyDown() <- IsRightShiftKeyDown() <- IsAltKeyDown() <- IsLeftAltKeyDown() <- IsRightAltKeyDown()`

**Returns:**
- `isDown`
  - *boolean* - True if the specified modifier key is pressed down.

**Description:**
Related Events:
- `MODIFIER_STATE_CHANGED`

Related API:
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

**Example Use Case:**
This function can be used in scenarios where you need to check if a user is holding down a modifier key (like Ctrl, Shift, or Alt) to perform specific actions, such as multi-selecting items in an inventory or triggering special abilities in a game.

**Addons Using This Function:**
Many large addons, such as ElvUI and WeakAuras, use this function to enhance user interactions. For example, WeakAuras might use it to allow users to configure custom keybindings for displaying or hiding certain UI elements based on modifier keys.