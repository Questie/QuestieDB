## Title: UnitGetIncomingHeals

**Content:**
Returns the predicted heals cast on the specified unit.
`heal = UnitGetIncomingHeals(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken
- `healerGUID`
  - *string?* : UnitToken - Only predict incoming heals from a single UnitId.

**Returns:**
- `heal`
  - *number* - Predicted increase in health from incoming heals.

**Description:**
For Classic, this function is only partially functional. The returned value only predicts healing from direct spell casts; heal-over-time effects and channeled casts are not factored into any predictions.

**Reference:**
- `UnitHealth`
- `UnitHealthMax`
- `UnitGetTotalAbsorbs`

**References:**
- [WoWUIBugs Issue #163](https://github.com/Stanzilla/WoWUIBugs/issues/163)