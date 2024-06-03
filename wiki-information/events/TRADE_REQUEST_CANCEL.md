## Event: TRADE_REQUEST_CANCEL

**Title:** TRADE REQUEST CANCEL

**Content:**
Fired when a trade attempt is cancelled. Fired after TRADE_CLOSED when aborted by player, and before TRADE_CLOSED when done by target.
`TRADE_REQUEST_CANCEL`

**Payload:**
- `None`

**Content Details:**
Upon a trade being cancelled (as in, either part clicking the cancel button), TRADE_CLOSED is fired twice, and then TRADE_REQUEST_CANCEL once.