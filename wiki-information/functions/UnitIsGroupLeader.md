## Title: UnitIsGroupLeader

**Content:**
Returns whether the unit is the leader of a party or raid.
`isLeader = UnitIsGroupLeader(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId
- `partyCategory`
  - *number?* - If omitted, defaults to INSTANCE if applicable, HOME otherwise.
    - **Value**
      - **Enum**
      - **Description**
      - `1`
        - `LE_PARTY_CATEGORY_HOME` - Home-realm group, i.e. a manually created group.
      - `2`
        - `LE_PARTY_CATEGORY_INSTANCE` - Instance-specific temporary group, e.g. Battlegrounds, Dungeon Finder

**Returns:**
- `isLeader`
  - *boolean*