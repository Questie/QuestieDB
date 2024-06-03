## Title: C_BarberShop.IsViewingVisibleSex

**Content:**
Returns whether the currently visible body type at the barber shop is the same as `sexId`.
`isVisibleSex = IsViewingVisibleSex(sex)`

**Parameters:**
- `sex`
  - *number* - Ranging from 0 for body type 1 (masculine/male) to 1 for body type 2 (feminine/female).

**Returns:**
- `isVisibleSex`
  - *boolean* - true if the visible body type at barber shop UI matches `sex`, otherwise false.