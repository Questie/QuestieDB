## Title: GetNumAuctionItems

**Content:**
Retrieves the number of auction items of a certain type.
`batch, count = GetNumAuctionItems(list)`

**Parameters:**
- `(string type)`
  - `type`
    - One of the following:
      - `"list"` - Items up for auction, the "Browse" tab in the dialog.
      - `"bidder"` - Items the player has bid on, the "Bids" tab in the dialog.
      - `"owner"` - Items the player has up for auction, the "Auctions" tab in the dialog.

**Returns:**
- `batch`
  - The size of the batch being viewed, 50 for a page view.
- `count`
  - The total number of items in the query.
  - For a GetAll query, the batch and count are the same.
  - Bug seen in 4.0.1: If an AH has over 42554 items, batch will be returned as 42554, and count will be a seemingly random VERY HIGH number - ~1 billion has been seen.

**Usage:**
```lua
numBatchAuctions, totalAuctions = GetNumAuctionItems("bidder");
```

**Example Use Case:**
This function can be used in an addon that tracks auction house activity. For instance, an addon like Auctioneer might use this function to determine how many items a player has bid on or listed for sale, and then display this information in a user-friendly format.

**Addons Using This Function:**
- **Auctioneer:** This popular addon uses `GetNumAuctionItems` to manage and display auction data, helping players to buy, sell, and bid on items more efficiently.