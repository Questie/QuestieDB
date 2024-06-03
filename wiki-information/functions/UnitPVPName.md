## Title: UnitPVPName

**Content:**
Returns the unit's name with title (e.g. "Bob the Explorer").
`titleName = UnitPVPName(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to retrieve the name and title of.

**Returns:**
- `titleName`
  - *string* - The unit's combined title and name, e.g. "Playername, the Insane", or nil if the unit is out of range.

**Description:**
This function retrieves information about all titles; at the time it was added, titles were exclusively gained through PvP rankings.
Note that `titleName` can be nil if the unit is not currently visible to the client.