## Title: C_QuestSession.CanStop

**Content:**
Indicates the player may request stopping Party Sync.
`allowed = C_QuestSession.CanStop()`

**Returns:**
- `allowed`
  - *boolean* - True if the player is in a party with Party Sync but may end it.

**Reference:**
- `C_QuestSession.CanStart()` - Applicable before Party Sync has begun.
- `C_QuestSession.RequestSessionStop()` - Used to terminate Party Sync, if `CanStop()` is true.