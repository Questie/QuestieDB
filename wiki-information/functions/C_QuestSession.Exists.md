## Title: C_QuestSession.Exists

**Content:**
Indicates Party Sync is active or requested by a party member.
`exists = C_QuestSession.Exists()`

**Returns:**
- `exists`
  - *boolean* - True if Party Sync is active or there is a pending request to activate it; false otherwise.

**Reference:**
- `C_QuestSession.HasJoined()` - Only true when active (excludes pending requests).