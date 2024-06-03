## Title: GetActionCharges

**Content:**
Returns information about the charges of a charge-accumulating player ability.
`currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetActionCharges(slot)`

**Parameters:**
- `slot`
  - *number* - The action slot to retrieve data from.

**Returns:**
- `currentCharges`
  - *number* - The number of charges of the ability currently available.
- `maxCharges`
  - *number* - The maximum number of charges the ability may have available.
- `cooldownStart`
  - *number* - Time (per GetTime) at which the next charge cooldown began, or 2^32 / 1000 if the spell is not currently recharging.
- `cooldownDuration`
  - *number* - Time (in seconds) required to gain a charge.
- `chargeModRate`
  - *number* - The rate at which the charge cooldown widget's animation should be updated.

**Description:**
Abilities like can be used by the player rapidly, and then slowly accumulate charges over time. The `cooldownStart` and `cooldownDuration` return values indicate the cooldown timer for acquiring the next charge (when `currentCharges` is less than `maxCharges`).
If the queried spell does not accumulate charges over time (e.g. or ), this function does not return any values.

**Reference:**
- `GetSpellCharges()` - Referring to any spell ID or localized spell name.