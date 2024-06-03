## Title: GetCurrencyLink

**Content:**
Get the currencyLink for the specified currencyID.
`currencyLink = GetCurrencyLink(currencyID, currencyAmount)`

**Parameters:**
- `currencyID`
  - *Integer* - currency index - see table at GetCurrencyInfo for a list
- `currencyAmount`
  - *Integer* - currency amount

**Returns:**
- `currencyLink`
  - *String* - The currency link (similar to itemLink) for the specified index (e.g. `"|cffa335ee|Hcurrency:396:0|h|h|r"` for Valor Points) or nil if the index is for a header.

**Reference:**
- `GetCurrencyListLink` (for currencies visible in the currency tab)