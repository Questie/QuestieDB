## Title: GetGuildBankItemInfo

**Content:**
Returns item info for a guild bank slot.
`texture, itemCount, locked, isFiltered, quality = GetGuildBankItemInfo(tab, slot)`

**Parameters:**
- `tab`
  - *number* - The index of the tab in the guild bank
- `slot`
  - *number* - The index of the slot in the chosen tab.

**Returns:**
- `texture`
  - *number* - The id of the texture to use for the item. Returns nil if there is no item.
- `itemCount`
  - *number* - The size of the item stack at the chosen slot. Returns 0 if there is no item.
- `locked`
  - *boolean* - Whether or not the slot is locked. Returns nil if it's not locked or the item doesn't exist, 1 otherwise.
- `isFiltered`
  - *boolean* - Returns true if the slot should be hidden because of the user's filter, false otherwise.
- `quality`
  - *number* - The quality of the item at the chosen slot. Returns nil if there is no item.