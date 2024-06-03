## Title: C_Map.GetMapGroupMembersInfo

**Content:**
Returns the floors for a map group.
`info = C_Map.GetMapGroupMembersInfo(uiMapGroupID)`

**Parameters:**
- `uiMapGroupID`
  - *number*

**Returns:**
- `info`
  - *table* `UiMapGroupMemberInfo`
    - `Field`
    - `Type`
    - `Description`
    - `mapID`
      - *number* - `UiMapID`
    - `relativeHeightIndex`
      - *number*
    - `name`
      - *string* - Floor name