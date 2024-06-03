## Title: BreakUpLargeNumbers

**Content:**
Divides digits into groups using a localized delimiter character.
`valueString = BreakUpLargeNumbers(value)`

**Parameters:**
- `value`
  - *number* - The number to convert into a localized string

**Returns:**
- `valueString`
  - *string* - The whole-number portion converted into a string if greater than 1000, or truncated to two decimals if less than 1000.

**Description:**
Large numbers are grouped into thousands and millions with a `LARGE_NUMBER_SEPARATOR`, but no further grouping happens for even larger numbers (billions).
Small numbers with a decimal portion are separated with a `DECIMAL_SEPARATOR` and truncated to two decimal places.
Not intended for use with negative numbers.

**Usage:**
```lua
BreakUpLargeNumbers(123.456789) -- 123.45
BreakUpLargeNumbers(1234567.89) -- 1,234,567
BreakUpLargeNumbers(1234567890) -- 1,234,567,890
```

**Reference:**
- `GetLocale`
- `FillLocalizedClassList`
- `FormatLargeNumber`