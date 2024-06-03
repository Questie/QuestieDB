## Title: PostAuction

**Content:**
Starts the auction you have created in the Create Auction panel.
`PostAuction(minBid, buyoutPrice, runTime, stackSize, numStacks)`

**Parameters:**
- `minBid`
  - *number* - The minimum bid price for this auction in copper.
- `buyoutPrice`
  - *number* - The buyout price for this auction in copper.
- `runTime`
  - *number* - The duration for which the auction should be posted. See details for more information.
- `stackSize`
  - *number* - The size of each stack to be posted.
- `numStacks`
  - *number* - The number of stacks to post.

**Description:**
Values that may be supplied for the `runTime` parameter can be found in the table below.

| Value | Duration  |
|-------|-----------|
| 1     | 2 hours   |
| 2     | 8 hours   |
| 3     | 24 hours  |