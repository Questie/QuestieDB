## Title: GetQuestLogIndexByID

**Content:**
Returns the current quest log index of a quest by its ID.
`questLogIndex = GetQuestLogIndexByID(questID)`

**Parameters:**
- `questID`
  - *number* - Unique identifier for each quest. Used as each quest's URL on database sites such as Wowhead.

**Returns:**
- `questLogIndex`
  - *number* - The index of the queried quest in the quest log. Returns "0" if a quest with this questID does not exist in the quest log.

**Usage:**
This snippet gets the QuestID of the most recently displayed quest in a Gossip frame, then gets the index. Now that we have the index of the quest, we can utilize many of the functions that require a quest index. For example, `GetQuestLink()` requires a quest index.
```lua
local qID = GetQuestID();
local qLink = GetQuestLink(GetQuestLogIndexByID(qID));
print("Here's a link to the quest I'm currently viewing at a quest-giver: " .. qLink);
```