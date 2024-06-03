## Title: C_Commentator.GetTrackedSpellsByUnit

**Content:**
Needs summary.
`spells = C_Commentator.GetTrackedSpellsByUnit(unitToken, category)`

**Parameters:**
- `unitToken`
  - *string* : UnitId
- `category`
  - *Enum.TrackedSpellCategory*
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - Offensive
    - `1`
      - Defensive
    - `2`
      - Debuff
    - `3`
      - RacialAbility
        - Added in 10.0.5
    - `4`
      - Count

**Returns:**
- `spells`
  - *number?*