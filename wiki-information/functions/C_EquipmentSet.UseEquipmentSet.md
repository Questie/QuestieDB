## Title: C_EquipmentSet.UseEquipmentSet

**Content:**
Equips items from a specified equipment set.
`setWasEquipped = C_EquipmentSet.UseEquipmentSet(equipmentSetID)`

**Parameters:**
- `equipmentSetID`
  - *number*

**Returns:**
- `setWasEquipped`
  - *boolean* - true if the set was equipped, nil otherwise. Failure conditions include invalid arguments, and engaging in combat.

**Description:**
This function does not produce error messages when it fails.
FrameXML's `EquipmentManager_EquipSet("name")` will produce a visible error, but will not provide a return value indicating success/failure.