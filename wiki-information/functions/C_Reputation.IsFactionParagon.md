## Title: C_Reputation.IsFactionParagon

**Content:**
Returns true if a faction is a paragon reputation.
`isParagon = C_Reputation.IsFactionParagon(factionID)`

**Parameters:**
- `factionID`
  - *number* - The factionID from the 14th return of `GetFactionInfo` or the 6th return from `GetWatchedFactionInfo`.

**Returns:**
- `isParagon`
  - *boolean* - true if the faction is Paragon level, false otherwise.

**Reference:**
- `GetFactionInfo`
- `GetWatchedFactionInfo`
- `C_Reputation.GetFactionParagonInfo`