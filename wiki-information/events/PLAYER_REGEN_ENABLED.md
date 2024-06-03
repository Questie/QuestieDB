## Event: PLAYER_REGEN_ENABLED

**Title:** PLAYER REGEN ENABLED

**Content:**
Fired after ending combat, as regen rates return to normal. Useful for determining when a player has left combat. This occurs when you are not on the hate list of any NPC, or a few seconds after the latest pvp attack that you were involved with.
`PLAYER_REGEN_ENABLED`

**Payload:**
- `None`

**Content Details:**
Related Events
- `PLAYER_REGEN_DISABLED`