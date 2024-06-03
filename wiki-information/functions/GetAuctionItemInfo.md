## Title: GetAuctionItemInfo

**Content:**
Retrieves info about one item in the current retrieved list of items from the Auction House.
```lua
name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo(type, index)
```

**Parameters:**
- `type`
  - *string* - One of the following:
    - `"list"` - An item up for auction, the "Browse" tab in the dialog.
    - `"bidder"` - An item the player has bid on, the "Bids" tab in the dialog.
    - `"owner"` - An item the player has up for auction, the "Auctions" tab in the dialog.
- `index`
  - *number* - The index of the item in the list to retrieve info from (normally 1-50, inclusive)

**Returns:**
1. `name`
   - *string* - the name of the item
2. `texture`
   - *number* - the fileID of the texture of the item
3. `count`
   - *number* - the number of items in the auction item, zero if item is "sold" in the "owner" auctions
4. `quality`
   - *Enum.ItemQuality*
5. `canUse`
   - *boolean* - true if the user can use the item, false if not
6. `level`
   - *number* - the level required to use the item
7. `levelColHeader`
   - *string* - The preceding level return value changes depending on the value of levelColHeader:
     - `"REQ_LEVEL_ABBR"` - level represents the required character level
     - `"SKILL_ABBR"` - level represents the required skill level (for recipes)
     - `"ITEM_LEVEL_ABBR"` - level represents the item level
     - `"SLOT_ABBR"` - level represents the number of slots (for containers)
8. `minBid`
   - *number* - the starting bid price
9. `minIncrement`
   - *number* - the minimum amount of item at which to put the next bid
10. `buyoutPrice`
    - *number* - zero if no buy out, otherwise it contains the buyout price of the auction item
11. `bidAmount`
    - *number* - the current highest bid, zero if no one has bid yet
12. `highBidder`
    - *string?* - returns name of highest bidder, nil otherwise
13. `bidderFullName`
    - *string?* - returns bidder's full name if from virtual realm, nil otherwise
14. `owner`
    - *string* - the player that is selling the item
15. `ownerFullName`
    - *string?* - returns owner's full name if from virtual realm, nil otherwise
16. `saleStatus`
    - *number* - 1 for sold, 0 for unsold
17. `itemId`
    - *number* - item id
18. `hasAllInfo`
    - *boolean* - was everything returned

**Usage:**
```lua
-- Retrieves info about the first item in the list of your currently auctioned items.
local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, 
 highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("owner", 1);
```

**Description:**
- **Auctions being returned as nil:**
  As of 4.0.1, auctions will be returned as "nil" for items not yet in the client's itemcache. New items resolve at a rate of 30 unique itemids every 30 seconds. (Note that "of the Xxx" items share the same itemid)
  Blizzard's standard auction house view overcomes this problem by reacting to `AUCTION_ITEM_LIST_UPDATE` and re-querying the items.

- **The "owner" field and playername resolving:**
  Note that the "owner" field can be nil. This happens because the auction listing internally contains player GUIDs rather than names, and the WoW client does not query the server for names until `GetAuctionItemInfo()` is actually called for the item, and the result takes one RTT to arrive. The GUID->name mapping is then stored in a name resolution cache, which gets cleared upon logout (not UI reload).
  Blizzard's standard auction house view overcomes this problem by reacting to `AUCTION_ITEM_LIST_UPDATE` and re-querying the items.
  However, this event-driven approach does not really work for e.g. scanner engines. There, the correct solution is to re-query items with nil owners for a short time (a low number of seconds). There IS a possibility that it NEVER returns something - this happens when someone puts something up for auction and then deletes his character.
  Note that the playername resolver will only resolve a certain number of sellers every 30 seconds. When this limit is exceeded, it will appear as if responses arrive in batches every 30 seconds.