## Title: C_QuestSession.CanStart

**Content:**
Indicates the player may request starting Party Sync.
`allowed = C_QuestSession.CanStart()`

**Returns:**
- `allowed`
  - *boolean* - True if the player is in a party that has not yet begun to activate Party Sync.

**Reference:**
- `C_QuestSession.CanStop()` - Applicable after Party Sync has begun.
- `C_QuestSession.RequestSessionStart()` - Used to request Party Sync, if CanStart() is true.