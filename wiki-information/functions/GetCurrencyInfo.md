## Title: GetCurrencyInfo

**Content:**
Retrieve Information about a currency at index including its amount.
`name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity = GetCurrencyInfo(id or "currencyLink" or "currencyString")`

**Parameters:**
One of the following three ways to specify which currency to query:
- `id`
  - *Integer* - CurrencyID
- `currencyLink`
  - *String* - The full currencyLink as found with `GetCurrencyLink()` or `GetCurrencyListLink()`.
- `currencyString`
  - *String* - A fragment of the currencyLink string for the item, e.g. `"currency:396"` for Valor Points.

**Returns:**
- `name`
  - *String* - the name of the currency, localized to the language
- `amount`
  - *Number* - Current amount of the currency at index
- `texture`
  - *String* - The file name of the currency's icon.
- `earnedThisWeek`
  - *Number* - The amount of the currency earned this week
- `weeklyMax`
  - *Number* - Maximum amount of currency possible to be earned this week
- `totalMax`
  - *Number* - Total maximum currency possible to stockpile
- `isDiscovered`
  - *Boolean* - Whether the character has ever got some of this currency
- `rarity`
  - *Integer* - Rarity indicator for this currency

**External Resources:**
[Wowhead](https://www.wowhead.com)