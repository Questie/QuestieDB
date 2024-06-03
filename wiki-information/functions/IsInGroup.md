## Title: IsInGroup

**Content:**
Returns true if the player is in a group.
`inGroup = IsInGroup()`

**Parameters:**
- `groupType`
  - *number?* - If omitted, checks if you're in any type of group.
  - If omitted, defaults to INSTANCE if applicable, HOME otherwise.
  - **Value**
    - **Enum**
    - **Description**
    - `1`
      - `LE_PARTY_CATEGORY_HOME` - Home-realm group, i.e. a manually created group.
    - `2`
      - `LE_PARTY_CATEGORY_INSTANCE` - Instance-specific temporary group, e.g. Battlegrounds, Dungeon Finder

**Returns:**
- `inGroup`
  - *boolean* - Returns true if the player is in the `groupType` group if specified, or in any type of group.

**Description:**
It is possible for a character to belong to a home group at the same time they are in an instance group (LFR or Flex). To distinguish between a party and a raid, use `IsInRaid()`.