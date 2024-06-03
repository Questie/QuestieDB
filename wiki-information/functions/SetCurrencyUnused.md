## Title: SetCurrencyUnused

**Content:**
Marks/unmarks a currency as unused.
`SetCurrencyUnused(id, unused)`

**Parameters:**
- `id`
  - *Number* - Index of the currency in the currency list to alter unused status of.
- `unused`
  - *Number* - 1 to mark the currency as unused; 0 to mark the currency as used.

**Notes and Caveats:**
When a currency is marked as unused, it is placed under the "Unused" header in the currency list; this is always the last header in the list. This alters the currency's index in the currency list.
The `isUnused` return value of `GetCurrencyListInfo` can be used to get the current state.