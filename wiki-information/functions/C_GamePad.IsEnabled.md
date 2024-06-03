## Title: C_GamePad.IsEnabled

**Content:**
Returns true if gamepad support is enabled on this system.
`enabled = C_GamePad.IsEnabled()`

**Returns:**
- `enabled`
  - *boolean* - True if gamepad support is enabled.

**Example Usage:**
This function can be used to check if the gamepad support is enabled before attempting to bind gamepad controls or display gamepad-specific UI elements.

**Addons:**
Large addons like ConsolePort use this function to determine if they should initialize gamepad-specific features and configurations.