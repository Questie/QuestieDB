## Event: QUEST_ACCEPT_CONFIRM

**Title:** QUEST ACCEPT CONFIRM

**Content:**
This event fires when an escort quest is started by another player. A dialog appears asking if the player also wants to start the quest.
`QUEST_ACCEPT_CONFIRM: name, questTitle`

**Payload:**
- `name`
  - *string* - Name of player who is starting escort quest.
- `questTitle`
  - *string* - Title of escort quest. Eg. "Protecting the Shipment"