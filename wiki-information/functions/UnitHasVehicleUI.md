## Title: UnitHasVehicleUI

**Content:**
Needs summary.
`hasVehicleUI = UnitHasVehicleUI()`

**Parameters:**
- `unit`
  - *string?* : UnitToken = WOWGUID_NULL

**Returns:**
- `hasVehicleUI`
  - *boolean*

**Example Usage:**
This function can be used to determine if a unit is currently using a vehicle UI. This is particularly useful in scenarios where the player's interface changes due to vehicle control, such as in certain quests or battlegrounds.

**Addons Usage:**
Large addons like **DBM (Deadly Boss Mods)** and **ElvUI** may use this function to adjust the UI dynamically when the player enters or exits a vehicle, ensuring that the interface remains functional and informative.