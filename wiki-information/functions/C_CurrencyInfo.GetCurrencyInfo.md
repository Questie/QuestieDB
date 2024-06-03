## Title: C_CurrencyInfo.GetCurrencyInfo

**Content:**
Returns info for a currency by ID.
```lua
info = C_CurrencyInfo.GetCurrencyInfo(type)
info = C_CurrencyInfo.GetCurrencyInfoFromLink(link)
```

**Parameters:**

*GetCurrencyInfo:*
- `type`
  - *number* : CurrencyID

*GetCurrencyInfoFromLink:*
- `link`
  - *string* : currencyLink

**Returns:**
- `info`
  - *CurrencyInfo*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string* - Localized name of the currency
    - `description`
      - *string* - Added in 10.0.0
    - `isHeader`
      - *boolean* - Used by currency window (some currency IDs are the headers)
    - `isHeaderExpanded`
      - *boolean* - Whether header is expanded or collapsed in currency window
    - `isTypeUnused`
      - *boolean* - Sorts currency at the bottom of currency window in "Unused" header
    - `isShowInBackpack`
      - *boolean* - Shows currency on Blizzard backpack frame
    - `quantity`
      - *number* - Current amount of the currency
    - `trackedQuantity`
      - *number* - Added in 9.1.5
    - `iconFileID`
      - *number* - FileID
    - `maxQuantity`
      - *number* - Total maximum currency possible
    - `canEarnPerWeek`
      - *boolean* - Whether the currency is limited per week
    - `quantityEarnedThisWeek`
      - *number* - 0 if canEarnPerWeek is false
    - `isTradeable`
      - *boolean*
    - `quality`
      - *Enum.ItemQuality*
    - `maxWeeklyQuantity`
      - *number* - 0 if canEarnPerWeek is false
    - `totalEarned`
      - *number* - Added in 9.0.2; Returns 0 if useTotalEarnedForMaxQty is false, prevents earning if equal to maxQuantity
    - `discovered`
      - *boolean* - Whether the character has ever earned the currency
    - `useTotalEarnedForMaxQty`
      - *boolean* - Added in 9.0.2; Whether the currency has a moving maximum (e.g. seasonal)

**Example Usage:**
This function can be used to retrieve detailed information about a specific currency in the game, such as the player's current amount, whether it is displayed in the backpack, and other metadata. For instance, it can be used in an addon to display a custom currency tracker.

**Addon Usage:**
Large addons like "Titan Panel" use this API to display currency information on the player's UI, allowing players to keep track of their currencies without opening the currency window.