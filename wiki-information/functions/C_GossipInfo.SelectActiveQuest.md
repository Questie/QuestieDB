## Title: C_GossipInfo.SelectActiveQuest

**Content:**
Selects an active quest from the gossip window.
`C_GossipInfo.SelectActiveQuest(optionID)`

**Parameters:**
- `optionID`
  - *number* - questID from `C_GossipInfo.GetActiveQuests`

**Example Usage:**
This function can be used in an addon to automate the selection of active quests from NPCs that offer multiple quests. For instance, if an NPC offers several quests and you want to programmatically select a specific one, you can use this function.

**Addon Usage:**
Large addons like **Questie** or **Zygor Guides** might use this function to streamline quest interactions, ensuring that the correct quest is selected without user intervention. This can be particularly useful in questing guides or automation scripts where minimizing user input is desired.