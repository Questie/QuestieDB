## Title: GetGuildBankItemLink

**Content:**
Returns the item link for a guild bank slot.
`itemLink = GetGuildBankItemLink(tab, slot)`

**Parameters:**
- `tab`
  - *number* - The index of the tab in the guild bank
- `slot`
  - *number* - The index of the slot in the provided tab.

**Returns:**
- `itemLink`
  - *string* - The item link for the item. Returns nil if there is no item.