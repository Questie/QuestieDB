## Title: CancelItemTempEnchantment

**Content:**
Removes temporary weapon enchants (e.g. Rogue poisons and sharpening stones).
`CancelItemTempEnchantment(weaponHand)`

**Parameters:**
- `weaponHand`
  - *number* - 1 for Main Hand, 2 for Off Hand.

**Example Usage:**
This function can be used in macros or addons to remove temporary enchants from weapons. For instance, a Rogue might use this to remove poisons from their weapons before applying a different type of poison.

**Addons:**
Many large addons, such as WeakAuras, might use this function to manage weapon enchants dynamically based on certain conditions or triggers.