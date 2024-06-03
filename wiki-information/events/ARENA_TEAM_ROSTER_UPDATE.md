## Event: ARENA_TEAM_ROSTER_UPDATE

**Title:** ARENA TEAM ROSTER UPDATE

**Content:**
This event fires whenever an arena team is opened in the character sheet. It also fires (3 times) when an arena member leaves, joins, or gets kicked. It does NOT fire when an arena team member logs in or out.
`ARENA_TEAM_ROSTER_UPDATE: allowQuery`

**Payload:**
- `allowQuery`
  - *boolean?*