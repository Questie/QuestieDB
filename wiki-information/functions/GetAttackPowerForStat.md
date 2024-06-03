## Title: GetAttackPowerForStat

**Content:**
Returns the amount of attack power contributed by a specific amount of a stat.
`attackPower = GetAttackPowerForStat(stat, value)`

**Parameters:**
- `stat`
  - *number* - Index of the stat (Strength, Agility, ...) to check the bonus AP of.
    - 1: `LE_UNIT_STAT_STRENGTH`
    - 2: `LE_UNIT_STAT_AGILITY`
    - 3: `LE_UNIT_STAT_STAMINA`
    - 4: `LE_UNIT_STAT_INTELLECT`
    - 5: `LE_UNIT_STAT_SPIRIT` (not available in 9.0.5)
- `value`
  - *number* - Amount of the stat to check the AP value of.

**Returns:**
- `attackPower`
  - *number* - Amount of attack power granted by the specified amount of the specified stat.