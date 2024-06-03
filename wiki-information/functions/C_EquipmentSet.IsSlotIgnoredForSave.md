## Title: C_EquipmentSet.IsSlotIgnoredForSave

**Content:**
Returns whether a slot is ignored for saving.
`isSlotIgnored = C_EquipmentSet.IsSlotIgnoredForSave(slot)`

**Parameters:**
- `slot`
  - *number*

**Returns:**
- `isSlotIgnored`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific equipment slot is set to be ignored when saving an equipment set. This is useful for addons that manage equipment sets and need to ensure certain slots are not altered.

**Addons:**
Large addons like "ItemRack" and "Outfitter" use this function to manage and save equipment sets, ensuring that specific slots (like trinkets or weapons) can be ignored based on user preferences.