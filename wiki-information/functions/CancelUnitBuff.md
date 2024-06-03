## Title: CancelUnitBuff

**Content:**
Removes a specific buff from the character.
`CancelUnitBuff(unit, buffIndex)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to cancel the buff from, must be under the player's control.
- `buffIndex`
  - *number* - index of the buff to cancel, ascending from 1.
- `filter`
  - *string* - any combination of "HELPFUL|HARMFUL|PLAYER|RAID|CANCELABLE|NOT_CANCELABLE".

**Description:**
This function does not work for canceling druid forms, rogue Stealth, death knight presences, or priest Shadowform.