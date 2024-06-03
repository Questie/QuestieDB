## Event: PLAYER_TOTEM_UPDATE

**Title:** PLAYER TOTEM UPDATE

**Content:**
This event fires whenever a totem is dropped (cast) or destroyed (either recalled or killed).
`PLAYER_TOTEM_UPDATE: totemSlot`

**Payload:**
- `totemSlot`
  - *number* - The number of the totem slot (1-4) affected by the update. See `GetTotemInfo`.