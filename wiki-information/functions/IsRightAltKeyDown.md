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

**Example Use Case:**
This function can be used in addons to check if a user is holding down a specific modifier key combination, which can be useful for implementing custom keybindings or conditional behaviors based on user input.

**Addons Using This Function:**
Many large addons, such as WeakAuras and Bartender4, use this function to provide advanced keybinding options and to allow users to create complex macros and conditional actions based on modifier keys.