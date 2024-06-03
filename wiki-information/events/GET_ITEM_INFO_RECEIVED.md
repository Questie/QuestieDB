## Event: GET_ITEM_INFO_RECEIVED

**Title:** GET ITEM INFO RECEIVED

**Content:**
Fired when GetItemInfo queries the server for an uncached item and the response has arrived.
`GET_ITEM_INFO_RECEIVED: itemID, success`

**Payload:**
- `itemID`
  - *number* - The Item ID of the received item info.
- `success`
  - *boolean* - Returns true if the item was successfully queried from the server.
  - Returns false if the item can't be queried from the server.
  - Returns nil if the item doesn't exist.