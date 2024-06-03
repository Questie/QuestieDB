## Title: GetAuctionItemBattlePetInfo

**Content:**
Retrieves info about one Battle Pet in the current retrieved list of Battle Pets from the Auction House.
`creatureID, displayID = GetAuctionItemBattlePetInfo(type, index)`

**Parameters:**
- `type`
  - *string* - One of the following:
    - `"list"` - An item up for auction, the "Browse" tab in the dialog.
    - `"bidder"` - An item the player has bid on, the "Bids" tab in the dialog.
    - `"owner"` - An item the player has up for auction, the "Auctions" tab in the dialog.
- `index`
  - *number* - The index of the item in the list to retrieve info from (normally 1-50, inclusive).

**Returns:**
- `creatureID`
  - *number* - An indexing value Blizzard uses to number NPCs.
- `displayID`
  - *number* - An indexing value Blizzard uses to number model/skin combinations.

**Description:**
The `displayID` return appears to always be 0, possibly because the function is only used by Blizzard in conjunction with `DressUpBattlePet`.

**Reference:**
- `DressUpBattlePet`
- `GetAuctionItemInfo`