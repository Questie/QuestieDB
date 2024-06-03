## Title: C_QuestSession.SendSessionBeginResponse

**Content:**
Consents to activating Party Sync following a request by another party member.
`C_QuestSession.SendSessionBeginResponse(beginSession)`

**Parameters:**
- `beginSession`
  - *boolean* - True to agree with starting Party Sync, or false to reject it.

**Description:**
This only applies when a pending request was initiated by another party member.

**Reference:**
- `C_QuestSession.GetSessionBeginDetails()` - Indicates which party member asked for the Party Sync to begin.