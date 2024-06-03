## Event: GOSSIP_SHOW

**Title:** GOSSIP SHOW

**Content:**
Fires when you talk to an npc.
`GOSSIP_SHOW: uiTextureKit`

**Payload:**
- `uiTextureKit`
  - *string?*

**Content Details:**
This event typicaly fires when you are given several choices, including choosing to sell item, select available and active quests, just talk about something, or bind to a location. Even when the the only available choices are quests, this event is often used instead of QUEST_GREETING.