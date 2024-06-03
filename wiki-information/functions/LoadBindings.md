## Title: LoadBindings

**Content:**
Loads default, account, or character-specific key bindings.
`LoadBindings(bindingSet)`

**Parameters:**
- `bindingSet`
  - *number* - Which binding set to load; one of the following three numeric constants:
    - `DEFAULT_BINDINGS` (0)
    - `ACCOUNT_BINDINGS` (1)
    - `CHARACTER_BINDINGS` (2)

**Reference:**
- `UPDATE_BINDINGS` when the binding set has been loaded.

**Description:**
The file it reads from is `WTF\Account\ACCOUNTNAME\bindings-cache.wtf`.