## Title: GetShapeshiftFormInfo

**Content:**
Returns info for an available form or stance.
`icon, active, castable, spellID = GetShapeshiftFormInfo(index)`

**Parameters:**
- `index`
  - *number* - index, ascending from 1 to `GetNumShapeshiftForms()`

**Returns:**
- `icon`
  - *string* - Path to icon texture
- `active`
  - *boolean* - 1 if this shapeshift is currently active, nil otherwise
- `castable`
  - *boolean* - 1 if this shapeshift form may be entered, nil otherwise
- `spellID`
  - *number* - ID of the spell that activates this ability

**Description:**
As well as druid shapeshifting, warrior stances, paladin auras, hunter aspects, death knight presences, and shadowform use this API.