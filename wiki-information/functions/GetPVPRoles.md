## Title: GetPVPRoles

**Content:**
Returns which roles the player is willing to perform in PvP battlegrounds.
`tank, healer, dps = GetPVPRoles()`

**Returns:**
- `tank`
  - *boolean* - true if the player is marked as willing to tank, false otherwise.
- `healer`
  - *boolean* - true if the player is marked as willing to heal, false otherwise.
- `dps`
  - *boolean* - true if the player is marked as willing to deal damage, false otherwise.

**Reference:**
- `SetPVPRoles`
- `PVP_ROLE_UPDATE`