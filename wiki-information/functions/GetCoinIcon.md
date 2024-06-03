## Title: GetCoinIcon

**Content:**
Returns the path to the texture used for a given amount of money.
`texturePath = GetCoinIcon(amount)`

**Parameters:**
- `amount`
  - *number* - amount of money in copper

**Returns:**
- `texturePath`
  - *string* - Path to icon used for the amount of money.

**Description:**
Currently returns `"Interface/Icons/INV_Misc_Coin_XX"`, where `XX` ranges from 01 to 06. Respectively, these correspond to:
- 01, 02 - Gold coins (loose and stack)
- 03, 04 - Silver coins (loose and stack)
- 05, 06 - Copper coins (loose and stack)

These are not the same icons used in a standard money frame (e.g., under your main backpack), instead these are the ones used in loot frames.