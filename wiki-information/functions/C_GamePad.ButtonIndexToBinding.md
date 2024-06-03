## Title: C_GamePad.ButtonIndexToBinding

**Content:**
Returns the name of the keybinding assigned to a specified gamepad button index. Returns nil if no keybinding is assigned to the requested button.
`bindingName = C_GamePad.ButtonIndexToBinding(buttonIndex)`

**Parameters:**
- `buttonIndex`
  - *number*

**Returns:**
- `bindingName`
  - *string?*

**Example Usage:**
This function can be used to retrieve the keybinding name for a specific button on a gamepad. For instance, if you want to check what action is bound to the "A" button on an Xbox controller, you would use this function with the appropriate button index.

**Addons:**
Large addons that support gamepad functionality, such as ConsolePort, may use this function to dynamically display or modify keybindings based on the gamepad button indices.