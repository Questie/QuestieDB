## Title: GetNumSubgroupMembers

**Content:**
Returns the number of other players in the party or raid subgroup.
`numSubgroupMembers = GetNumSubgroupMembers()`

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
- `numSubgroupMembers`
  - *number* - number of players in the player's sub-group, excluding the player.

**Description:**
- **Related API**
  - `GetNumGroupMembers`
- **Related Events**
  - `GROUP_ROSTER_UPDATE`