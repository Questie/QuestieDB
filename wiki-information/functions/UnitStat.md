## Title: UnitStat

**Content:**
Returns the basic attributes for a unit (strength, agility, stamina, intellect).
`currentStat, effectiveStat, statPositiveBuff, statNegativeBuff = UnitStat(unit, statID)`

**Parameters:**
- `unit`
  - *string* : UnitToken - Only works for "player" and "pet". Will work on "target" as long as it is equal to "player".
- `statID`
  - *number* - An internal id corresponding to one of the stats.
    - 1: `LE_UNIT_STAT_STRENGTH`
    - 2: `LE_UNIT_STAT_AGILITY`
    - 3: `LE_UNIT_STAT_STAMINA`
    - 4: `LE_UNIT_STAT_INTELLECT`
    - 5: `LE_UNIT_STAT_SPIRIT` (not available anymore in 9.0.5)

**Returns:**
- `currentStat`
  - *number* - The unit's stat. Seems to always return the same as effectiveStat, regardless of values of pos/negBuff.
- `effectiveStat`
  - *number* - The unit's current stat, as displayed in the paper doll frame.
- `statPositiveBuff`
  - *number* - Any positive buffs applied to the stat, including gear.
- `statNegativeBuff`
  - *number* - Any negative buffs applied to the stat.

**Usage:**
Shows your current strength.
```lua
local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 1);
DEFAULT_CHAT_FRAME:AddMessage("Your current Strength is " .. stat);
```

**Example Use Case:**
This function can be used in addons that need to display or manipulate the player's stats. For example, an addon that provides detailed character statistics or a custom UI element showing the player's current attributes.

**Addons Using This Function:**
- **ElvUI**: A popular UI overhaul addon that uses `UnitStat` to display character stats in its custom character frame.
- **Details! Damage Meter**: Uses `UnitStat` to provide detailed breakdowns of player performance, including how stats affect damage output.