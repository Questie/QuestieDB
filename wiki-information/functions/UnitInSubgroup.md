## Title: UnitInSubgroup

**Content:**
Needs summary.
`inSubgroup = UnitInSubgroup()`

**Parameters:**
- `unit`
  - *string?* : UnitId
- `overridePartyType`
  - *number?* - If omitted, defaults to INSTANCE if applicable, HOME otherwise.
    - `Value`
    - `Enum`
    - `Description`
    - `1`
      - `LE_PARTY_CATEGORY_HOME` - Home-realm group, i.e. a manually created group.
    - `2`
      - `LE_PARTY_CATEGORY_INSTANCE` - Instance-specific temporary group, e.g. Battlegrounds, Dungeon Finder

**Returns:**
- `inSubgroup`
  - *boolean*