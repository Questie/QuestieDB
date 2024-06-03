## Title: IsBattlePayItem

**Content:**
Returns whether an item was purchased from the in-game store.
`isPayItem = IsBattlePayItem(bag, slot)`

**Parameters:**
- `bag`
  - *number (bagID)* - container ID, e.g. 0 for backpack.
- `slot`
  - *number* - slot index within the container, ascending from 1.

**Returns:**
- `isPayItem`
  - *boolean* - true if the item was purchased from the in-game store, false otherwise.