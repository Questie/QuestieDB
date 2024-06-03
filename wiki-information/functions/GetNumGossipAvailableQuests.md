## Title: GetNumGossipAvailableQuests

**Content:**
Returns the number of quests (that you are not already on) offered by this NPC.
`numNewQuests = GetNumGossipAvailableQuests()`

**Returns:**
- `numNewQuests`
  - *number* - Number of quests you can pick up from this NPC.

**Description:**
This information is available when the `GOSSIP_SHOW` event fires.

**Reference:**
- `GetGossipAvailableQuests`
- `SelectGossipAvailableQuest`