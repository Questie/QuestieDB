## Title: C_EquipmentSet.CreateEquipmentSet

**Content:**
Creates an equipment set.
`C_EquipmentSet.CreateEquipmentSet(equipmentSetName)`

**Parameters:**
- `equipmentSetName`
  - *string* - The name of the equipment set to be created.
- `icon`
  - *string?* - (Optional) The icon to be used for the equipment set.

**Example Usage:**
```lua
-- Create a new equipment set named "PvP Gear"
C_EquipmentSet.CreateEquipmentSet("PvP Gear", "Interface\\Icons\\INV_Sword_27")
```

**Description:**
This function is used to create a new equipment set with the specified name and optional icon. Equipment sets allow players to quickly switch between different sets of gear, which is particularly useful for changing roles or activities, such as switching from PvE to PvP gear.

**Usage in Addons:**
Many popular addons, such as "Outfitter" and "ItemRack," use this function to manage and create equipment sets for players. These addons provide a user-friendly interface for creating, updating, and switching between different sets of gear, enhancing the player's ability to manage their equipment efficiently.