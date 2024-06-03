## Title: C_Container.GetContainerItemQuestInfo

**Content:**
Needs summary.
`questInfo = C_Container.GetContainerItemQuestInfo(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number (BagID)* - Index of the bag to query.
- `slotIndex`
  - *number* - Index of the slot within the bag (ascending from 1) to query.

**Returns:**
- `questInfo`
  - *ItemQuestInfo*
    - `Field`
    - `Type`
    - `Description`
    - `isQuestItem`
      - *boolean* - true if the item is a quest item, nil otherwise. Items starting quests are apparently not considered to be quest items.
    - `questID`
      - *number?* - Quest ID of the quest this item starts, no value if it does not start a quest or if the call refers to a bank bag/slot when the bank is not being visited.
    - `isActive`
      - *boolean* - true if the quest this item starts has been accepted by the player, false otherwise.