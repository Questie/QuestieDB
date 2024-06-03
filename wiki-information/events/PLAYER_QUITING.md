## Event: PLAYER_QUITING

**Title:** PLAYER QUITING

**Content:**
Fired when the player tries to quit, as opposed to logout, while outside an inn.
`PLAYER_QUITING`

**Payload:**
- `None`

**Content Details:**
The dialog which appears after this event, has choices of "Exit Now" or "Cancel".
The dialog from PLAYER_CAMPING which appears when you try to logout outside an inn, only has a "Cancel" choice.