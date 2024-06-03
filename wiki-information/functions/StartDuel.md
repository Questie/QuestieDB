## Title: StartDuel

**Content:**
Challenges the specified player to a duel.
`StartDuel(unit)`
`StartDuel(name)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit id of the unit.
- `name`
  - *string* - The name of the unit.
- `exactMatch`
  - *boolean?* - true to check only units whose name exactly matches the name given; false to allow partial matches.

**Description:**
`StartDuel("player")` is an apparent special case, creating a mouse cursor to select someone else to duel against.

**Reference:**
- `AcceptDuel()`
- `CancelDuel()`