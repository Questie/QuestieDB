## Title: ExpandCurrencyList

**Content:**
Alters the expanded state of a currency list header.
`ExpandCurrencyList(id, expanded)`

**Parameters:**
- `id`
  - *Number* - Index of the header in the currency list to expand/collapse.
- `expanded`
  - *Number* - 0 to set to collapsed state; 1 to set to expanded state.

**Notes and Caveats:**
This function affects the `isExpanded` return value of the `GetCurrencyListInfo` API function, but has no immediate impact on the currency UI (which caches the expanded state when it is shown).
Currencies under collapsed headers are still available to `GetCurrencyListInfo`, so this is a purely visual switch.