## Event: QUEST_LOG_UPDATE

**Title:** QUEST LOG UPDATE

**Content:**
Fires when the quest log updates.
`QUEST_LOG_UPDATE`

**Payload:**
- `None`

**Content Details:**
Toggle `QuestMapFrame.ignoreQuestLogUpdate` to suppress the normal event handler.
This event fires very often:
- Viewing a quest for the first time in a session
- Changing zones across an instance boundary
- Picking up a non-grey item
- Completing a quest objective
- Expanding or collapsing headers in the quest log.