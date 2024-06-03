## Event: QUEST_WATCH_UPDATE

**Title:** QUEST WATCH UPDATE

**Content:**
Seems to fire each time the objectives of the quest with the supplied questID update, i.e. whenever a partial objective has been accomplished: killing a mob, looting a quest item etc.
`QUEST_WATCH_UPDATE: questID`

**Payload:**
- `questID`
  - *number*

**Content Details:**
UNIT_QUEST_LOG_CHANGED and QUEST_LOG_UPDATE both also seem to fire consistently – in that order – after each QUEST_WATCH_UPDATE.