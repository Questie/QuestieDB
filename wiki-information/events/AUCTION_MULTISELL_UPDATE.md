## Event: AUCTION_MULTISELL_UPDATE

**Title:** AUCTION MULTISELL UPDATE

**Content:**
Fired when the client lists a stack as part of listing multiple stacks.
`AUCTION_MULTISELL_UPDATE: createdCount, totalToCreate`

**Payload:**
- `createdCount`
  - *number* - number of stacks listed so far.
- `totalToCreate`
  - *number* - total number of stacks in the current mass-listing operation.