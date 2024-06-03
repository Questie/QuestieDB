## Title: UnitGetAvailableRoles

**Content:**
Returns the recommended roles for a specified unit.
`tank, heal, dps = UnitGetAvailableRoles(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `tank`
  - *boolean* - Whether the unit can perform as a tank
- `heal`
  - *boolean* - Whether the unit can perform as a healer
- `dps`
  - *boolean* - Whether the unit can perform as a dps

**Notes and Caveats:**
Although the Group Finder allows every class to pick any role, for some there is a warning that it is not recommended (e.g., healer as a Warrior). This function returns results based on the same logic.