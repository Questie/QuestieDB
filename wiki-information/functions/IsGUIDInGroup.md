## Title: IsGUIDInGroup

**Content:**
Returns whether or not the unit with the given GUID is in your group.
`inGroup = IsGUIDInGroup(UnitGUID, )`

**Parameters:**
- `guid`
  - *string* : WOWGUID
- `groupType`
  - *number?* - If omitted, defaults to INSTANCE if applicable, HOME otherwise.
    - **Value**
    - **Enum**
    - **Description**
    - `1`
      - `LE_PARTY_CATEGORY_HOME` - Home-realm group, i.e. a manually created group.
    - `2`
      - `LE_PARTY_CATEGORY_INSTANCE` - Instance-specific temporary group, e.g. Battlegrounds, Dungeon Finder

**Returns:**
- `inGroup`
  - *bool* - True if the given GUID is in your group, considering groupType if provided, otherwise false.

**Description:**
- **Related API**
  - `UnitGUID`
- **Related Event**
  - `GROUP_ROSTER_UPDATE`