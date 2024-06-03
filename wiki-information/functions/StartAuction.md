## Title: StartAuction

**Content:**
Starts the auction you have created in the Create Auction panel.
`StartAuction(minBid, buyoutPrice, runTime, stackSize, numStacks)`

The item is that which has been put into the AuctionSellItemButton. That's the slot in the 'create auction' panel. 
The minBid and buyoutPrice are in copper. However, I can't figure out how to go below 1 silver. So putting in '50' or '10' or '1' will always make the auction do '1 silver'. But '102' will make it do '1 silver 2 copper'. 
runTime may be one of the following: 1, 2, 3 for 12, 24, and 48 hours.

**Examples:**
- `StartAuction(1,1,1)` - Start at 1 silver, buyout 1 silver, time 12 hours
- `StartAuction(1,10,1)` - Start at 1 silver, buyout 1 silver, time 12 hours
- `StartAuction(1,100,1)` - Start at 1 silver, buyout 1 silver, time 12 hours
- `StartAuction(1,1000,1)` - Start at 1 silver, buyout 10 silver, time 12 hours
- `StartAuction(1,10000,2)` - Start at 1 silver, buyout 1 gold, time 24 hours
- `StartAuction(101,150,3)` - Start at 1 silver 1 copper, buyout at 1 silver 50 copper, time 48 hours

**Usage Example:**
1. Go to the auction house.
2. Right-click on the auctioneer.
3. Click on the 'auction' tab.
4. Drag an item to the slot in the 'Create Auction' panel.
5. Type the following into the chat window:
   - `/script StartAuction(1,150,1)`

This should create an auction starting at 1 silver, buyout at 1 silver 50 copper, with an auction time of 12 hours. It should say 'Auction Created' in the chat window. Now if you go to browse the auctions, your items should show up.

**Description:**
As of Patch 4.0, `StartAuction()` requires a hardware event. This change does not show up in any patch documentation.