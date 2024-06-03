## Title: GetText

**Content:**
Returns localized text depending on the specified gender.
`text = GetText(token)`

**Parameters:**
- `token`
  - *string* - Reputation index
- `gender`
  - *number* - Gender ID
- `ordinal`
  - *unknown*

**Returns:**
- `text`
  - *string* - The localized text

**Usage:**
- This should return `FACTION_STANDING_LABEL1`
  ```lua
  /dump GetText("FACTION_STANDING_LABEL1") -- "Hated"
  ```
- This should return `FACTION_STANDING_LABEL1_FEMALE`
  ```lua
  /dump GetText("FACTION_STANDING_LABEL1", 3) -- "Hated"
  ```

**Reference:**
- `getglobal`