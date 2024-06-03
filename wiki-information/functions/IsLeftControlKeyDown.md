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
This function can be used in macros or scripts to check if a modifier key (like Ctrl, Shift, or Alt) is being held down. This is useful for creating complex keybindings or conditional logic in addons.

**Addons Using This Function:**
Many large addons, such as WeakAuras and Bartender4, use this function to provide advanced keybinding options and conditional displays based on modifier keys. For example, WeakAuras might use it to show or hide certain auras when a modifier key is pressed.