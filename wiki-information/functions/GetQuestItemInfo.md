## Title: GetQuestItemInfo

**Content:**
Returns info for a required/reward/choice quest item.
`name, texture, count, quality, isUsable, itemID = GetQuestItemInfo(type, index)`

**Parameters:**
- `type`
  - *string* - type of the item to query. One of the following values:
    - `"required"`: Items the quest requires the player to gather.
    - `"reward"`: Unconditional quest rewards.
    - `"choice"`: One of the possible quest rewards.
- `index`
  - *number* - index of the item of the specified type to return information about, ascending from 1.

**Returns:**
- `name`
  - *string* - The item's name.
- `texture`
  - *number : FileID* - The item's icon texture.
- `count`
  - *number* - Amount of the item required or awarded by the quest.
- `quality`
  - *Enum.ItemQuality* - The item's quality.
- `isUsable`
  - *boolean* - True if the quest item is usable by the current player.
- `itemID`
  - *number* - The item's ID.

**Description:**
This function returns information about the current quest: the one for which the QUEST_* family of events has fired most recently. Quests in the quest log use `GetQuestLogRewardInfo` and `GetQuestLogChoiceInfo`.

**Reference:**
- `GetNumQuestChoices`
- `GetNumQuestRewards`

**Example Usage:**
```lua
local name, texture, count, quality, isUsable, itemID = GetQuestItemInfo("reward", 1)
print("Reward Item Name: ", name)
```

**Addons Using This Function:**
- **Questie**: Uses `GetQuestItemInfo` to display detailed information about quest rewards and required items in the quest tracker and tooltips.
- **AllTheThings**: Utilizes this function to gather data on quest items for collection tracking and completionist purposes.