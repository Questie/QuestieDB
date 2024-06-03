## Title: C_Commentator.IsTrackedSpellByUnit

**Content:**
Needs summary.
`isTracked = C_Commentator.IsTrackedSpellByUnit(unitToken, spellID, category)`

**Parameters:**
- `unitToken`
  - *string* : UnitId
- `spellID`
  - *number*
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
- `isTracked`
  - *boolean*