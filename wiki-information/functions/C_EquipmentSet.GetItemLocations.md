## Title: C_EquipmentSet.GetItemLocations

**Content:**
Returns the location of all items in an equipment set.
`locations = C_EquipmentSet.GetItemLocations(equipmentSetID)`

**Parameters:**
- `equipmentSetID`
  - *number*

**Returns:**
- `locations`
  - *number* - indexed by InventorySlotId

**Description:**
The values for each slot can be examined as follows:
- `-1` : The item for this slot is unavailable.
- `0` : The slot should be emptied.
- `1` : This slot is ignored by the equipment set, no change will be made.
- Any other value can be examined by calling `EquipmentManager_UnpackLocation`

**Details:**
This function does not differentiate between slots that cannot be equipped and slots that you have chosen to ignore in the equipment manager. For example, if you are testing to see if a particular item in your inventory has become unavailable (perhaps you sold it or scrapped it by mistake), you cannot simply scan looking for `-1` values as the ammo slot will return a `-1` as well as slots that you cannot equip at all (such as shields for hunters). Additional coding, likely by class and spec, are needed to make that differentiation.