## Title: GetCurrencyListInfo

**Content:**
Returns information about an entry in the currency list.
`name, isHeader, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount, unknown, itemID = GetCurrencyListInfo(index)`

**Parameters:**
- `id`
  - *Number* - index, ascending from 1 to `GetCurrencyListSize()`.

**Returns:**
- `name`
  - *String* - localized currency (or currency header) name.
- `isHeader`
  - *Boolean* - true if this entry is a header, false otherwise.
- `isExpanded`
  - *Boolean* - true if this entry is an expanded header, false otherwise.
- `isUnused`
  - *Boolean* - true if this entry is a currency marked as unused, false otherwise.
- `isWatched`
  - *Boolean* - true if this entry is a currency currently displayed on the backpack, false otherwise.
- `count`
  - *Number* - amount of this currency in the player's possession (0 for headers).
- `icon`
  - *String* - path to the icon texture for item-based currencies, invalid for arena/honor points.
- `maximum`
  - *Number* - 0 if this currency has no limit, otherwise integer value with 2 extra zeros (e.g. 400000 = 4000.00 as in Justice Points and Honor Points).
- `hasWeeklyLimit`
  - *Number* - 1 if this currency has a weekly limit (Valor Points), nil otherwise.
- `currentWeeklyAmount`
  - *Number* - amount of this currency obtained for the current week, nil otherwise.
- `unknown`
  - *unknown* - possible deprecated slot for itemID? All known cases return nil.
- `itemID`
  - *Number* - item ID corresponding to this item-based currency, invalid for arena/honor points.

**Notes and Caveats:**
- Information about currencies under collapsed headers is available; it is up to the UI code to respect the `isExpanded` flag.
- Indices are generally based on localized alphabetic order.
- The headers "contain" all currencies with index greater than theirs until the next header. This is not a nested structure.
- Marking a currency as unused alters its index, as the currency is moved down the list to fit under an "Unused" header.