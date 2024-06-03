## Event: PLAYER_MONEY

**Title:** PLAYER MONEY

**Content:**
Fired whenever the player gains or loses money.
`PLAYER_MONEY`

**Payload:**
- `None`

**Content Details:**
To get the amount of money earned/lost, you'll need to save the return value from GetMoney from the last time PLAYER_MONEY fired and compare it to the new return value from GetMoney.

**Usage:**
Egingell:PLAYER_MONEY