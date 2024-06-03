## Title: GetUnspentTalentPoints

**Content:**
Returns the number of unspent talent points the player, the player's pet, or an inspected unit.
`talentPoints = GetUnspentTalentPoints(isInspected, isPet, talentGroup)`

**Parameters:**
- `isInspected`
  - *Boolean* - If true, returns the information for the inspected unit instead of the player.
- `isPet`
  - *Boolean* - If true, returns the information for the pet instead of the player (only valid for hunter with a pet active).
- `talentGroup`
  - *Number* - The index of the talent group (1 for primary / 2 for secondary).

**Returns:**
- `talentPoints`
  - *Number* - number of unspent talent points.

**Usage:**
```lua
-- Get the unspent talent points for player's active spec
local talentGroup = GetActiveTalentGroup(false, false)
local talentPoints = GetUnspentTalentPoints(false, false, talentGroup)
```

**Notes and Caveats:**
This function returns 0 if an invalid combination of parameters is used (asking for pet talent for a non-hunter, asking for isInspect when no unit was inspected).