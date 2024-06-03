## Title: C_QuestSession.GetSessionBeginDetails

**Content:**
Identifies the party member requesting Party Sync.
`details = C_QuestSession.GetSessionBeginDetails()`

**Returns:**
- `details`
  - *QuestSessionPlayerDetails?* - Returns nil if there is no pending request from another party member.
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `guid`
      - *string* - GUID

**Description:**
This only applies when a pending request was initiated by another party member.

**Reference:**
C_QuestSession.SendSessionBeginResponse(beginSession) - Used to indicate agreement with starting Party Sync.