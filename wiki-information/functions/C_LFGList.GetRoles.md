## Title: C_LFGList.GetRoles

**Content:**
Returns the currently selected Group Finder roles as a table.
`roles = C_LFGList.GetRoles()`

**Returns:**
- `roles`
  - *table*
    - `Key` (*string*)
    - `Value` (*boolean*)
      - `dps`
        - true/false
      - `healer`
        - true/false
      - `tank`
        - true/false