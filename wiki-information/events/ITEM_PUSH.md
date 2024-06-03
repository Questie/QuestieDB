## Event: ITEM_PUSH

**Title:** ITEM PUSH

**Content:**
Fired when an item is pushed onto the "inventory-stack". For instance when you manufacture something with your trade skills or pick something up.
`ITEM_PUSH: bagSlot, iconFileID`

**Payload:**
- `bagSlot`
  - *number* - the bag that has received the new item
- `iconFileID`
  - *number* - the FileID of the item's icon