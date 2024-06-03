## Title: CancelPendingEquip

**Content:**
Cancels a pending equip confirmation.
`CancelPendingEquip(slot)`

**Parameters:**
- `slot`
  - *number* - equipment slot to cancel equipping an item to.

**Description:**
When attempting to equip an item which will become soulbound, the equip operation is suspended, and a dialog is presented for the user to decide whether or not to proceed. This call is made by that dialog if the user decides not to equip the item.