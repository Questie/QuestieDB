## Title: GetUnitSpeed

**Content:**
Returns the movement speed of the unit.
`currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to query the speed of.

**Returns:**
- `currentSpeed`
  - *number* - current movement speed in yards per second (normal running: 7; an epic ground mount: 14)
- `runSpeed`
  - *number* - the maximum speed on the ground, in yards per second (including talents such as Pursuit of Justice and ground mounts)
- `flightSpeed`
  - *number* - the maximum speed while flying, in yards per second (the unit needs to be on a flying mount to get the flying speed)
- `swimSpeed`
  - *number* - the maximum speed while swimming, in yards per second (not tested but it should be as the flying mount)

**Usage:**
The following snippet prints your current movement speed in percent:
```lua
/script print(string.format("Current speed: %d%%", GetUnitSpeed("player") / 7 * 100))
```

**Description:**
As of 4.2, `runSpeed`, `flightSpeed`, and `swimSpeed` returns were added. It seems you can also get the target unit's speed (not tested on the opposite faction).
A constant exists: `BASE_MOVEMENT_SPEED` which is equal to 7 (as of patch 4.2).