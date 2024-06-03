## Title: GetWeaponEnchantInfo

**Content:**
Returns info for temporary weapon enchantments (e.g. sharpening stones).
`hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID, hasRangedEnchant, rangedExpiration, rangedCharges, rangedEnchantID = GetWeaponEnchantInfo()`

**Returns:**
- `hasMainHandEnchant`
  - *boolean* - true if the weapon in the main hand slot has a temporary enchant, false otherwise
- `mainHandExpiration`
  - *number* - time remaining for the main hand enchant, as thousandths of seconds
- `mainHandCharges`
  - *number* - the number of charges remaining on the main hand enchant
- `mainHandEnchantID`
  - *number* - ID of the main hand enchant (new in 6.0)
- `hasOffHandEnchant`
  - *boolean* - true if the weapon in the secondary (off) hand slot has a temporary enchant, false otherwise
- `offHandExpiration`
  - *number* - time remaining for the off hand enchant, as thousandths of seconds
- `offHandCharges`
  - *number* - the number of charges remaining on the off hand enchant
- `offHandEnchantID`
  - *number* - ID of the off hand enchant (new in 6.0)
- `hasRangedEnchant`
  - *boolean* - true if the weapon in the ranged hand slot has a temporary enchant, false otherwise (only on cataclysm/4.x)
- `rangedExpiration`
  - *number* - time remaining for the ranged enchant, as thousandths of seconds (only on cataclysm/4.x)
- `rangedCharges`
  - *number* - the number of charges remaining on the ranged enchant (only on cataclysm/4.x)
- `rangedEnchantID`
  - *number* - ID of the ranged enchant (only on cataclysm/4.x)

**Reference:**
`UNIT_INVENTORY_CHANGED` fires when (among other things) the player's temporary enchants, and thus the return values from this function, change.