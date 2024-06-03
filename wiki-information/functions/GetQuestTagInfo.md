## Title: GetQuestTagInfo

**Content:**
Retrieves tag information about the quest.
`tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(questID)`

**Parameters:**
- `questID`
  - *number* - The ID of the quest to retrieve the tag info for.

**Returns:**
- `tagID`
  - *number* - the tagID, nil if quest is not tagged
- `tagName`
  - *string* - human readable representation of the tagID, nil if quest is not tagged
- `worldQuestType`
  - *number* - type of world quest, or nil if not world quest
- `rarity`
  - *number* - the rarity of the quest (used for world quests)
- `isElite`
  - *boolean* - is this an elite quest? (used for world quests)
- `tradeskillLineIndex`
  - *tradeskillID* if this is a profession quest (used to determine which profession icon to display for world quests)
- `displayTimeLeft`
  - *?*

**Description:**
- `tagID`
- `tagName`
  - 1: Group
  - 41: PvP
  - 62: Raid
  - 81: Dungeon
  - 83: Legendary
  - 85: Heroic
  - 98: Scenario
  - 102: Account
  - 117: Leatherworking World Quest

- `worldQuestTypes`
  - `LE_QUEST_TAG_TYPE_PVP`
  - `LE_QUEST_TAG_TYPE_PET_BATTLE`
  - `LE_QUEST_TAG_TYPE_PROFESSION`
  - `LE_QUEST_TAG_TYPE_DUNGEON`

- `rarity`
  - `LE_WORLD_QUEST_QUALITY_COMMON`
  - `LE_WORLD_QUEST_QUALITY_RARE`
  - `LE_WORLD_QUEST_QUALITY_EPIC`

**Reference:**
`GetQuestLogTitle`