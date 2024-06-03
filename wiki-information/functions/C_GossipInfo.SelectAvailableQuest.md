## Title: C_GossipInfo.SelectAvailableQuest

**Content:**
Selects an available quest from the gossip window.
`C_GossipInfo.SelectAvailableQuest(optionID)`

**Parameters:**
- `optionID`
  - *number* - questID from `C_GossipInfo.GetAvailableQuests`

**Example Usage:**
This function can be used in an addon to automate the selection of available quests from NPCs. For instance, an addon designed to streamline questing might use this function to automatically pick up all available quests from an NPC when the player interacts with them.

**Addons Using This Function:**
- **Questie**: A popular quest helper addon that provides quest information and tracking. It uses this function to automate the process of accepting quests from NPCs, making the questing experience more efficient for players.