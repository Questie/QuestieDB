## Title: BNGetInfo

**Content:**
Returns the player's own Battle.net info.
`presenceID, battleTag, toonID, currentBroadcast, bnetAFK, bnetDND, isRIDEnabled = BNGetInfo()`

**Returns:**
- `presenceID`
  - *number?* - Your presenceID - appears to be always nil in 8.1.5
- `battleTag`
  - *string* - A nickname and number that when combined, form a unique string that identifies the friend (e.g., "Nickname#0001")
- `toonID`
  - *number* - Your toonID
- `currentBroadcast`
  - *string* - the current text in your broadcast box
- `bnetAFK`
  - *boolean* - true if you're flagged "Away"
- `bnetDND`
  - *boolean* - true if you're flagged "Busy"
- `isRIDEnabled`
  - *boolean*