## Title: UnitExists

**Content:**
Returns true if the unit exists.
`exists = UnitExists(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `exists`
  - *boolean* - true if the unit exists and is in the current zone, or false if not

**Usage:**
The snippet below prints a message describing what the player is targeting.
```lua
if UnitExists("target") then
  print("You're targeting a " .. UnitName("target"))
else
  print("You have no target")
end
```