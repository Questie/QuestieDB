## Title: SetCurrencyBackpack

**Content:**
Alters the backpack tracking state of a currency.
`SetCurrencyBackpack(id, backpack)`

**Parameters:**
- `id`
  - *Number* - Index of the currency in the currency list to alter tracking of.
- `backpack`
  - *Number* - 1 to track; 0 to clear tracking.

**Notes and Caveats:**
This function affects the `isWatched` return value of `GetCurrencyListInfo`.
Information about watched currencies is accessible using `GetBackpackCurrencyListInfo`.