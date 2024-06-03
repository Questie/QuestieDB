## Event: AUCTION_OWNED_LIST_UPDATE

**Title:** AUCTION OWNED LIST UPDATE

**Content:**
Fired whenever new information about auctions posted by the current character is received. Often used to update the auction house auctions view after an auction is canceled or posted.
`AUCTION_OWNED_LIST_UPDATE`

**Payload:**
- `None`

**Content Details:**
If the auctions you are looking for are not loaded automatically it is necessary to reopen the Auction House to trigger them being loaded.
So long as an event handler is registered for this event the owned auctions list should update automatically.