## Title: UnitInVehicle

**Content:**
Checks whether a specified unit is within a vehicle.
`inVehicle = UnitInVehicle(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `inVehicle`
  - *boolean*

**Example Usage:**
This function can be used to determine if a player or NPC is currently in a vehicle. This is particularly useful in scenarios where vehicle mechanics are involved, such as certain quests or battlegrounds.

**Addons:**
Many large addons, such as Deadly Boss Mods (DBM), use this function to track player status during encounters that involve vehicles. This helps in providing accurate alerts and timers based on whether players are in or out of vehicles.