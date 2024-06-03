## Title: GetBackpackCurrencyInfo

**Content:**
Returns info for a tracked currency in the backpack.
`name, count, icon, currencyID = GetBackpackCurrencyInfo(index)`

**Parameters:**
- `index`
  - *number* - Index, ascending from 1 to `GetNumWatchedTokens()`.

**Returns:**
- `name`
  - *string* - Localized currency name.
- `count`
  - *number* - Amount currently possessed by the player.
- `icon`
  - *number* - FileID of the currency icon.
- `currencyID`
  - *number* - CurrencyID of the currency.