## Title: CanSendAuctionQuery

**Content:**
Determine if a new auction house query can be sent (via `QueryAuctionItems()`)
`canQuery, canQueryAll = CanSendAuctionQuery()`

**Returns:**
- `canQuery`
  - *boolean* - True if a normal auction house query can be made
- `canQueryAll`
  - *boolean* - True if a full ("getall") auction house query can be made (added in 2.3)

**Description:**
There is always a short delay (usually less than a second) after each query before another query can take place.
Full ("getall") queries are only allowed once every ~15 minutes.