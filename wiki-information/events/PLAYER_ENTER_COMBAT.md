## Event: PLAYER_ENTER_COMBAT

**Title:** PLAYER ENTER COMBAT

**Content:**
Fired when a player engages auto-attack. Note that firing a gun or a spell, or getting aggro, does NOT trigger this event.
`PLAYER_ENTER_COMBAT`

**Payload:**
- `None`

**Content Details:**
PLAYER_ENTER_COMBAT and PLAYER_LEAVE_COMBAT are for *MELEE* combat only. They fire when you initiate autoattack and when you turn it off. However, any spell or ability that does not turn on autoattack does not trigger it. Nor does it trigger when you get aggro.
You probably want PLAYER_REGEN_DISABLED (fires when you get aggro) and PLAYER_REGEN_ENABLED (fires when you lose aggro).