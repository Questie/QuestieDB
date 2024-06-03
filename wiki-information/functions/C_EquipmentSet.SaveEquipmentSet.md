## Title: C_EquipmentSet.SaveEquipmentSet

**Content:**
Saves your currently equipped items into an equipment set.
`C_EquipmentSet.SaveEquipmentSet(equipmentSetID)`

**Parameters:**
- `equipmentSetID`
  - *number* - can be retrieved from an existing equipment set by name with `C_EquipmentSet.GetEquipmentSetID`.
- `icon`
  - *string?* - icon to use for the equipment set. If omitted, the existing icon will be used. Accepts both texture names and file IDs, e.g. `"INV_Ammo_Snowball"`, `655708` or `"655708"`.

**Description:**
Can only modify an existing equipment set.