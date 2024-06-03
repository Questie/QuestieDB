## Title: GetTalentPrereqs

**Content:**
Returns the tier and column of a talent's prerequisite, and if the talent is learnable.
`tier, column, isLearnable = GetTalentPrereqs(tabIndex, talentIndex [, isInspect, isPet, talentGroup])`

**Parameters:**
- `tabIndex`
  - *number* - Ranging from 1 to `GetNumTalentTabs()`
- `talentIndex`
  - *number* - Ranging from 1 to `GetNumTalents(tabIndex)`
- `isInspect`
  - *boolean?* - Whether the talent is for the currently inspected player.
- `isPet`
  - *boolean?*
- `talentGroup`
  - *number?* - Probably the dual spec group index.

**Returns:**
- `tier`
  - *number* - The row/tier that the prerequisite talent sits on.
- `column`
  - *number* - The column that the prerequisite talent sits on.
- `isLearnable`
  - *number* - Returns 1 if you have learned the prerequisite talents, nil otherwise.

**Description:**
The `talentIndex` is counted as if it were a tree, meaning that the leftmost talent in the topmost row is number 1 followed by the one immediately to the right as number 2. If there are no more talents to the right, then it continues from the leftmost talent on the next row.
If you check a talent with no prerequisites, the function returns nil.