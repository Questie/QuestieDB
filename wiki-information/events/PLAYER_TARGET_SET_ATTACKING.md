## Event: PLAYER_TARGET_SET_ATTACKING

**Title:** PLAYER TARGET SET ATTACKING

**Content:**
Fired when the player enables autoattack.
`PLAYER_TARGET_SET_ATTACKING: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
This can occur when:
- IsCurrentSpell(6603) (where 6603 is the autoattack spell) changes from false to true
- The player changes target while autoattack is active.