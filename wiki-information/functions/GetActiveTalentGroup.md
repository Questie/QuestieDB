## Title: GetActiveTalentGroup

**Content:**
Returns the index of the current active talent group.
`index = GetActiveTalentGroup(isInspect, isPet);`

**Parameters:**
- `isInspect`
  - *Boolean* - If true returns the information for the inspected unit instead of the player.
- `isPet`
  - *Boolean* - If true returns the information for the inspected pet.

**Returns:**
- `index`
  - *Number* - The index of the current active talent group (1 for primary / 2 for secondary).