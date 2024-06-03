## Title: UnitHasVehiclePlayerFrameUI

**Content:**
Needs summary.
`hasVehicleUI = UnitHasVehiclePlayerFrameUI()`

**Parameters:**
- `unit`
  - *string?* : UnitToken = WOWGUID_NULL

**Returns:**
- `hasVehicleUI`
  - *boolean*

**Example Usage:**
This function can be used to determine if a unit (such as a player) currently has a vehicle UI. This is useful in scenarios where the UI needs to adapt based on whether the player is controlling a vehicle.

**Example:**
```lua
local unit = "player"
if UnitHasVehiclePlayerFrameUI(unit) then
    print("Player is in a vehicle.")
else
    print("Player is not in a vehicle.")
end
```

**Addons:**
Large addons like **ElvUI** and **Bartender4** use this function to adjust the user interface when the player enters or exits a vehicle, ensuring that the vehicle's abilities and controls are properly displayed.