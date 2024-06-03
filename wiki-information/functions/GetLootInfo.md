## Title: GetLootInfo

**Content:**
Returns a table with all of the loot info for the current loot window.
`info = GetLootInfo()`

**Returns:**
- `info`
  - *table*
    - `Field`
    - `Type`
    - `Description`
    - `isQuestItem`
      - *boolean?*
    - `item`
      - *string* - Item Name, e.g. "Linen Cloth" or "65 Copper"
    - `locked`
      - *boolean* - Whether you are eligible to loot this item or not. Locked items are by default shown tinted red.
    - `quality`
      - *number* - Item Quality
    - `quantity`
      - *number* - The quantity of the item in a stack. The quantity for coin is always 0.
    - `roll`
      - *boolean*
    - `texture`
      - *number* - Texture FileID

**Reference:**
- `GetLootSlotInfo`
- `LOOT_READY` - When this event fires, the function will have new data available.