## Event: TRADE_ACCEPT_UPDATE

**Title:** TRADE ACCEPT UPDATE

**Content:**
Fired when the status of the player and target accept buttons has changed.
`TRADE_ACCEPT_UPDATE: playerAccepted, targetAccepted`

**Payload:**
- `playerAccepted`
  - *number* - Player has agreed to the trade (1) or not (0)
- `targetAccepted`
  - *number* - Target has agreed to the trade (1) or not (0)

**Content Details:**
Target agree status only shown when he has done it first. By this, player and target agree status is only shown together (playerAccepted == 1 and targetAccepted == 1), when player agreed after target.