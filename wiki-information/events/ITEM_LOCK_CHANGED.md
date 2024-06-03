## Event: ITEM_LOCK_CHANGED

**Title:** ITEM LOCK CHANGED

**Content:**
Fires when the "locked" status on a container or inventory item changes, usually from but not limited to Pickup functions to move items.
`ITEM_LOCK_CHANGED: bagOrSlotIndex, slotIndex`

**Payload:**
- `bagOrSlotIndex`
  - *number* - If slotIndex is nil: Equipment slot of item; otherwise bag of updated item.
- `slotIndex`
  - *number?* - Slot of updated item.

**Content Details:**
Usually fires in pairs when an item is swapping with another.
Empty slots do not lock.
GetContainerItemInfo and IsInventoryItemLocked can be used to query lock status.
This does NOT fire on ammo pickups.