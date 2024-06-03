## Title: C_CurrencyInfo.GetCurrencyContainerInfo

**Content:**
Needs summary.
`info = C_CurrencyInfo.GetCurrencyContainerInfo(currencyType, quantity)`

**Parameters:**
- `currencyType`
  - *number* - CurrencyID
- `quantity`
  - *number*

**Returns:**
- `info`
  - *CurrencyDisplayInfo*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string* - CurrencyContainer.ContainerName_lang
    - `description`
      - *string*
    - `icon`
      - *number*
    - `quality`
      - *number*
    - `displayAmount`
      - *number*
    - `actualAmount`
      - *number*