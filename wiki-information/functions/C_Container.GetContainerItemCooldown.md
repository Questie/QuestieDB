## Title: C_Container.GetContainerItemCooldown

**Content:**
Needs summary.
`startTime, duration, enable = C_Container.GetContainerItemCooldown(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number*
- `slotIndex`
  - *number*

**Returns:**
- `startTime`
  - *number*
- `duration`
  - *number*
- `enable`
  - *number*

**Example Usage:**
This function can be used to check the cooldown status of an item in a specific container slot. For instance, if you want to know when a health potion will be available for use again, you can call this function with the appropriate container and slot indices.

**Addon Usage:**
Large addons like **Bagnon** and **ArkInventory** use this function to display cooldown information directly on the item icons within the inventory UI, providing players with a visual indication of when items will be ready for use again.