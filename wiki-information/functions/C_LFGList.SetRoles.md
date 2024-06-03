## Title: C_LFGList.SetRoles

**Content:**
Sets the player's Group Finder roles
`success = C_LFGList.SetRoles(roles)`

**Parameters:**
- `roles`
  - *table* - A table with each role as a string key, and a boolean value for whether that role should be selected. All roles must be present in the table.
    - `Key (string)`
    - `Value (boolean)`
    - `dps`
      - true/false
    - `healer`
      - true/false
    - `tank`
      - true/false

**Returns:**
- `success`
  - *boolean* - Whether setting the roles was successful or not