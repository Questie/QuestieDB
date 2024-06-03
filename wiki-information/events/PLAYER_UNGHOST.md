## Event: PLAYER_UNGHOST

**Title:** PLAYER UNGHOST

**Content:**
Fired when the player is alive after being a ghost.
`PLAYER_UNGHOST`

**Payload:**
- `None`

**Content Details:**
The player is alive when this event happens. Does not fire when the player is resurrected before releasing. PLAYER_ALIVE is triggered in that case.
Fires after one of:
- Performing a successful corpse run and the player accepts the 'Resurrect Now' box.
- Accepting a resurrect from another player after releasing from a death.
- Zoning into an instance where the player is dead.
- When the player accept a resurrect from a Spirit Healer.