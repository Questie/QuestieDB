## Title: GetNumGroupMembers

**Content:**
Returns the number of players in the group.
`numMembers = GetNumGroupMembers()`

**Parameters:**
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
- `numGroupMembers`
  - *number* - total number of players in the group (either party or raid), 0 if not in a group.

**Description:**
- **Related API:**
  - `GetNumSubgroupMembers`
- **Related Events:**
  - `GROUP_ROSTER_UPDATE`