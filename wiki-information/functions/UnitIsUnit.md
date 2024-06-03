## Title: UnitIsUnit

**Content:**
Returns true if the specified units are the same unit.
`isSame = UnitIsUnit(unit1, unit2)`

**Parameters:**
- `unit1`
  - *string* : UnitId - The first unit to query (e.g. "party1", "pet", "player")
- `unit2`
  - *string* : UnitId - The second unit to compare it to (e.g. "target")

**Returns:**
- `isSame`
  - *boolean* - 1 if the two units are the same entity, nil otherwise.

**Usage:**
```lua
if ( UnitIsUnit("targettarget", "player") ) then
  message("Look at me, I have aggro from " .. UnitName("target") .. "!");
end;
```

**Miscellaneous:**
Result:
Displays a message if your target is targeting you.