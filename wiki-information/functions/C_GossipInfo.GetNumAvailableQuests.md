## Title: C_GossipInfo.GetNumAvailableQuests

**Content:**
Returns the number of quests (that you are not already on) offered by this NPC.
`numQuests = C_GossipInfo.GetNumAvailableQuests()`

**Returns:**
- `numQuests`
  - *number*

**Example Usage:**
This function can be used in an addon to determine how many new quests an NPC is offering to the player. For instance, an addon could use this to display a notification or update a UI element indicating the number of available quests when interacting with an NPC.

**Addon Usage:**
Large addons like Questie or Storyline might use this function to enhance the questing experience by providing additional information about available quests directly in the game's interface. Questie, for example, could use this to mark NPCs on the map that have new quests available for the player.