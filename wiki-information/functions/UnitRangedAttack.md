## Title: UnitRangedAttack

**Content:**
Returns the unit's ranged attack and modifier.
`base, modifier = UnitRangedAttack(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - Likely only works for "player" and "pet"

**Returns:**
- `base`
  - *number* - The unit's base ranged attack number (0 if no ranged weapon is equipped)
- `modifier`
  - *number* - The total effect of all modifiers (positive and negative) to ranged attack.

**Usage:**
```lua
local base, modifier = UnitRangedAttack("player");
local effective = base + modifier;
message(effective);
```

**Miscellaneous:**
Result:
Displays a message containing your effective ranged attack skill (Weapon Skill).