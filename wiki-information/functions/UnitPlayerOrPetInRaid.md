## Title: UnitPlayerOrPetInRaid

**Content:**
Returns true if a different unit or pet is a member of the raid.
`inRaid = UnitPlayerOrPetInRaid(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `inRaid`
  - *boolean*

**Description:**
Returns nil for player and pet as of 3.0.2

**Usage:**
```lua
local TargetInRaid = UnitPlayerOrPetInRaid("target")
local TargetInRaid = UnitPlayerOrPetInRaid("target")
```

**Miscellaneous:**
Result:
- `TargetInRaid = 1` - If your target is in your raid group.
- `TargetInRaid = nil` - If your target is not in raid group.