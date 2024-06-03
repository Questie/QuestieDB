## Title: C_EquipmentSet.GetEquipmentSetInfo

**Content:**
Returns information about a saved equipment set.
`name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID)`

**Parameters:**
- `equipmentSetID`
  - *number* - equipment set ID to query information about.

**Returns:**
- `name`
  - *string* - name of the equipment set.
- `iconFileID`
  - *number* - icon texture selected for the equipment set.
- `setID`
  - *number* - equipment set ID.
- `isEquipped`
  - *boolean* - true if all non-ignored slots in the set are currently equipped.
- `numItems`
  - *number* - number of items included in the set.
- `numEquipped`
  - *number* - number of items in the set currently equipped.
- `numInInventory`
  - *number* - number of items in the set currently in the player's bags/bank, if bank is available.
- `numLost`
  - *number* - number of items in the set that are not currently available to the player.
- `numIgnored`
  - *number* - number of inventory slots ignored by the set.

**Description:**
Equipment set IDs are assigned when the set is created and do not change as other sets are added or deleted.