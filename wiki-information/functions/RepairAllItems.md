## Title: RepairAllItems

**Content:**
Repairs all equipped and inventory items.
`RepairAllItems()`

**Parameters:**
- `guildBankRepair`
  - *boolean?* - true to use guild funds to repair, otherwise uses player funds.

**Reference:**
- `CanGuildBankRepair`

**Example Usage:**
```lua
-- Check if the player can use guild funds to repair
if CanGuildBankRepair() then
    -- Repair using guild funds
    RepairAllItems(true)
else
    -- Repair using player funds
    RepairAllItems(false)
end
```

**Description:**
The `RepairAllItems` function is used to repair all equipped and inventory items of the player. It can optionally use guild funds if the player has the necessary permissions. This function is commonly used in addons that manage inventory and equipment, ensuring that the player's gear is always in top condition.

**Addons Using This Function:**
- **ElvUI**: A comprehensive UI replacement addon that includes an auto-repair feature, which can automatically repair items using either player or guild funds based on user settings.
- **AutoRepair**: A lightweight addon specifically designed to automatically repair items when visiting a vendor capable of repairs. It can be configured to use guild funds if available.