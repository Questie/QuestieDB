## Event: ITEM_DATA_LOAD_RESULT

**Title:** ITEM DATA LOAD RESULT

**Content:**
Fires when data is available in response to C_Item.RequestLoadItemData.
`ITEM_DATA_LOAD_RESULT: itemID, success`

**Payload:**
- `itemID`
  - *number*
- `success`
  - *boolean* - True if the item was successfully queried from the server.