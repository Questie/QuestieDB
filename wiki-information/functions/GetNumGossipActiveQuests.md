## Title: GetNumGossipActiveQuests

**Content:**
Returns the number of active quests that you should eventually turn in to this NPC.
`numActiveQuests = GetNumGossipActiveQuests()`

**Returns:**
- `numActiveQuests`
  - *number* - Number of quests you're on that should be turned in to the NPC you're gossiping with.

**Description:**
This information is available when the `GOSSIP_SHOW` event fires.

**Reference:**
- `GetGossipActiveQuests`
- `SelectGossipActiveQuest`