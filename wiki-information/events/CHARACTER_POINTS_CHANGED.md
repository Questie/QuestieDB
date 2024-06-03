## Event: CHARACTER_POINTS_CHANGED

**Title:** CHARACTER POINTS CHANGED

**Content:**
Fired when the player's available talent points change.
`CHARACTER_POINTS_CHANGED: change`

**Payload:**
- `change`
  - *number* - indicates number of talent points changed.
  - -1 indicates one used (learning a talent)
  - 1 indicates one gained (leveling)