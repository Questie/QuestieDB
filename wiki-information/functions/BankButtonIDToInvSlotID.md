## Title: BankButtonIDToInvSlotID

**Content:**
Maps a BankButtonID to InventorySlotID.
`invSlot = BankButtonIDToInvSlotID(buttonID, isBag)`

**Parameters:**
- `buttonID`
  - *number* - bank item/bag ID.
- `isBag`
  - *number* - 1 if buttonID is a bag, nil otherwise. Same result as ContainerIDToInventoryID, except this one only works for bank bags and is more awkward to use.

**Returns:**
- `invSlot`
  - An inventory slot ID that can be used in other inventory functions.