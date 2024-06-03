## Event: MINIMAP_PING

**Title:** MINIMAP PING

**Content:**
Fired when the minimap is pinged.
`MINIMAP_PING: unitTarget, y, x`

**Payload:**
- `unitTarget`
  - *string* : UnitId - Unit that created the ping (i.e. "player" or any of the group members)
- `y`
  - *number*
- `x`
  - *number*