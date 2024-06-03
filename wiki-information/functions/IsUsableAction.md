## Title: IsUsableAction

**Content:**
Returns true if the character can currently use the specified action (sufficient mana, reagents and not on cooldown).
`isUsable, notEnoughMana = IsUsableAction(slot)`

**Parameters:**
- `slot`
  - *number* - Action slot to query

**Returns:**
- `isUsable`
  - *boolean* - true if the action is currently usable (does not check cooldown or range), false otherwise.
- `notEnoughMana`
  - *boolean* - true if the action is unusable because the player does not have enough mana, rage, etc.; false otherwise.