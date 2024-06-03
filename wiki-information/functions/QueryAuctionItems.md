## Title: QueryAuctionItems

**Content:**
Queries the server for information about current auctions, only when `CanSendAuctionQuery()` is true.
`QueryAuctionItems(text, minLevel, maxLevel, page, usable, rarity, getAll, exactMatch, filterData)`

**Parameters:**
- `text`
  - *string* - A part of the item's name, or an empty string; limited to 63 bytes.
- `minLevel`
  - *number?* - Minimum usable level requirement for items
- `maxLevel`
  - *number?* - Maximum usable level requirement for items
- `page`
  - *number* - What page in the auction house this shows up. Note that pages start at 0.
- `usable`
  - *boolean* - Restricts items to those usable by the current character.
- `rarity`
  - *Enum.ItemQuality?* - Restricts the quality of the items found.
- `getAll`
  - *boolean* - Download the entire auction house as one single page; see other details below.
- `exactMatch`
  - *boolean* - Will only items whose whole name is the same as searchString be found.
- `filterData`
  - *table?*
    - `Field`
    - `Type`
    - `Description`
    - `classID`
      - *number* - ItemType
    - `subClassID`
      - *number?* - Depends on the ItemType
    - `inventoryType`
      - *Enum.InventoryType?*

**Description:**
Queries appear to be throttled at 0.3 seconds normally, or 15 minutes with getAll mode. The return values from `CanSendAuctionQuery()` indicate when each mode is permitted.
getAll mode might disconnect players with low bandwidth. Also see relevant details on client-to-server traffic in `GetAuctionItemInfo()`.
text longer than 63 bytes might disconnect the player.
If any of the entered arguments is of the wrong type, the search assumes a nil value.
No effect if the auction house window is not open.
In 4.0.1, getAll mode only fetches up to 42554 items. This is usually adequate, but high-population realms might have more.

**Usage:**
Searches for rare items between levels 10 and 19:
```lua
QueryAuctionItems("", 10, 19, 0, nil, nil, false, false, nil)
```
Searches for anything with the word "Nobles" in it, such as the Darkmoon card deck:
```lua
/script QueryAuctionItems("Nobles", nil, nil, 0, false, nil, false, false, nil)
```