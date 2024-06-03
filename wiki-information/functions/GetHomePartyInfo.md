## Title: GetHomePartyInfo

**Content:**
Returns names of characters in your home (non-instance) party.
`homePlayers = GetHomePartyInfo()`

**Parameters:**
- `homePlayers`
  - *table* - table to populate and return; a new table is created if this argument is omitted.

**Returns:**
- `homePlayers`
  - *table* - array containing your (non-instance) party members' names, or nil if you're not in any non-instance party.