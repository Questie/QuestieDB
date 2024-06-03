## Title: C_UnitAuras.IsAuraFilteredOutByInstanceID

**Content:**
Tests if an aura passes a specific filter.
`isFiltered = C_UnitAuras.IsAuraFilteredOutByInstanceID(unit, auraInstanceID, filterString)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to query.
- `auraInstanceID`
  - *number* - The aura instance ID to test.
- `filterString`
  - *string* - The aura filter string to test, e.g., "HELPFUL" or "HARMFUL".

**Miscellaneous:**
- **Filter** | **Description**
  - `"HELPFUL"` | Buffs
  - `"HARMFUL"` | Debuffs
  - `"PLAYER"` | Auras Debuffs applied by the player
  - `"RAID"` | Buffs the player can apply and debuffs the player can dispel
  - `"CANCELABLE"` | Buffs that can be cancelled with /cancelaura or CancelUnitBuff()
  - `"NOT_CANCELABLE"` | Buffs that cannot be cancelled
  - `"INCLUDE_NAME_PLATE_ONLY"` | Auras that should be shown on nameplates
  - `"MAW"` | Torghast Anima Powers

**Returns:**
- `isFiltered`
  - *boolean* - true if the aura passes the specified filter, or false if not.