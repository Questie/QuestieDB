## Title: C_GamePad.ButtonBindingToIndex

**Content:**
Converts the name of a keybinding to its assigned gamepad button index. Returns nil if no gamepad button is assigned to the requested keybinding.
`buttonIndex = C_GamePad.ButtonBindingToIndex(bindingName)`

**Parameters:**
- `bindingName`
  - *string*

**Returns:**
- `buttonIndex`
  - *number?*

**Example Usage:**
This function can be used to map a specific keybinding to a gamepad button index, which is useful for addons that provide gamepad support or custom keybinding configurations.

**Addon Usage:**
Large addons like ConsolePort use this function to provide seamless gamepad integration by mapping World of Warcraft keybindings to gamepad buttons, enhancing the gameplay experience for players who prefer using a gamepad.