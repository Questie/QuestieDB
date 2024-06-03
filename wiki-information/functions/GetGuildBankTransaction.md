## Title: GetGuildBankTransaction

**Content:**
Returns info for an item transaction from the guild bank.
`type, name, itemLink, count, tab1, tab2, year, month, day, hour = GetGuildBankTransaction(tab, index)`

**Parameters:**
- `tab`
  - *number* - Tab number, ascending from 1 to `GetNumGuildBankTabs()`.
- `index`
  - *number* - Transaction index, ascending from 1 to `GetNumGuildBankTransactions(tab)`. Higher indices correspond to more recent entries.

**Returns:**
- `type`
  - *string* - Transaction type. ("deposit", "withdraw" or "move")
- `name`
  - *string* - Name of player who made the transaction.
- `itemLink`
  - *string* - `itemLink` of transaction item.
- `count`
  - *number* - Amount of items.
- `tab1`
  - *number* - For `type=="move"`, this is the origin tab.
- `tab2`
  - *number* - For `type=="move"`, this is the destination tab.
- `year`
  - *number* - The number of years since this transaction took place.
- `month`
  - *number* - The number of months since this transaction took place.
- `day`
  - *number* - The number of days since this transaction took place.
- `hour`
  - *number* - The number of hours since this transaction took place.