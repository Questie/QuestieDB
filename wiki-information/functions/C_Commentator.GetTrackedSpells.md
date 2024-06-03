## Title: C_Commentator.GetTrackedSpells

**Content:**
Needs summary.
`spells = C_Commentator.GetTrackedSpells(teamIndex, playerIndex, category)`

**Parameters:**
- `teamIndex`
  - *number*
- `playerIndex`
  - *number*
- `category`
  - *number* - Enum.TrackedSpellCategory
    - `Enum.TrackedSpellCategory`
      - `Value`
      - `Field`
      - `Description`
        - `0` - Offensive
        - `1` - Defensive
        - `2` - Debuff
        - `3` - RacialAbility (Added in 10.0.5)
        - `4` - Count

**Returns:**
- `spells`
  - *number?*