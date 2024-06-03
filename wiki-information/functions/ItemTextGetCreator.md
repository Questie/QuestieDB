## Title: ItemTextGetCreator

**Content:**
Returns the name of the character who created the item text.
`creatorName = ItemTextGetCreator()`

**Returns:**
- `creatorName`
  - *string* - If this item text was created by a player (i.e. Saved mail message) then return their name, otherwise return nil.

**Description:**
This is available once the `ITEM_TEXT_BEGIN` event has been received.