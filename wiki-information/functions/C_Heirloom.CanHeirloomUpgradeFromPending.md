## Title: C_Heirloom.CanHeirloomUpgradeFromPending

**Content:**
Returns true if an heirloom can be upgraded by using an upgrade item.
`boolean = C_Heirloom.CanHeirloomUpgradeFromPending(itemID)`

**Parameters:**
- `itemID`
  - *number* - a heirloom itemID

**Returns:**
- *boolean*

**Example Usage:**
This function can be used to check if a specific heirloom item can be upgraded before attempting to use an upgrade item on it. This is useful in addons that manage heirloom collections or automate the upgrading process.

**Addons:**
Large addons like "Altoholic" and "AllTheThings" might use this function to provide users with information about their heirloom items and whether they can be upgraded.