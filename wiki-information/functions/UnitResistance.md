## Title: UnitResistance

**Content:**
Gets information about a unit's resistance.
`base, total, bonus, minus = UnitResistance(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to check
- `resistanceIndex`
  - *number* - The index of the resistance type to check
    - `0` - (Physical) - Armor rating
    - `1` - (Holy)
    - `2` - (Fire)
    - `3` - (Nature)
    - `4` - (Frost)
    - `5` - (Shadow)
    - `6` - (Arcane)

**Returns:**
- `base`
  - *number* - The base resistance
- `total`
  - *number* - The current total value after all modifiers
- `bonus`
  - *number* - The bonus resistance modifier total from gear and buffs
- `minus`
  - *number* - The negative resistance modifier total from gear and buffs

**Usage:**
```lua
/script SendChatMessage("My base armor is " .. UnitResistance("player", 0));
/script _, total, _, _ = UnitResistance("player", 0); SendChatMessage("My total armor is " .. total);
```

**Example Use Case:**
This function can be used to display a player's resistance values in the chat, which can be useful for debugging or sharing information with other players.

**Addons:**
Many large addons, such as ElvUI and WeakAuras, use this function to display or track resistance values for various purposes, including creating custom UI elements or triggering alerts based on resistance thresholds.