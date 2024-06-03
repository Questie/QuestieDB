## Title: IsInRaid

**Content:**
Returns true if the player is in a raid.
`isInRaid = IsInRaid()`

**Parameters:**
- `groupType`
  - *number?* - To check for a specific type of group, provide one of:
    - `LE_PARTY_CATEGORY_HOME` : checks for home-realm parties.
    - `LE_PARTY_CATEGORY_INSTANCE` : checks for instance-specific groups.

**Returns:**
- `isInRaid`
  - *boolean* - true if the player is currently in a `groupType` raid group (if `groupType` was not specified, true if in any type of raid), false otherwise.

**Description:**
This returns true in arenas if `groupType` is `LE_PARTY_CATEGORY_INSTANCE` or is unspecified.