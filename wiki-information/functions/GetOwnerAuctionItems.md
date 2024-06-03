## Title: GetOwnerAuctionItems

**Content:**
Updates owned auction list.
`GetOwnerAuctionItems()`

**Usage:**
When selling multiple stacks of items (multisell) sometimes the last few stacks get posted without a subsequent list update.
Useful for when `AUCTION_OWNED_LIST_UPDATE` fires but the list isn't actually updated until you switch to the tab.

**Description:**
Manually calling this function doesn't appear to do anything by itself. Having an event handler registered for the event, calling it shortly after an auction is posted or calling it in an `OnShow` handler can make it work.