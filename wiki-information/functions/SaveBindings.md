## Title: SaveBindings

**Content:**
Saves account or character specific key bindings.
`SaveBindings(which)`

**Parameters:**
- `which`
  - *number* - Whether the key bindings should be saved as account or character specific.
    - `Value`
    - `Constant`
    - `Description`
    - `0`
      - `DEFAULT_BINDINGS`
    - `1`
      - `ACCOUNT_BINDINGS`
    - `2`
      - `CHARACTER_BINDINGS`

**Description:**
Bindings are stored in `WTF\Account\ACCOUNTNAME\bindings-cache.wtf`.
Triggers `UPDATE_BINDINGS`.

**Reference:**
- `GetCurrentBindingSet`

**Example Usage:**
```lua
-- Save current key bindings as character-specific
SaveBindings(2)
```

**Addons Using This Function:**
Many large addons that manage custom key bindings, such as Bartender4 and ElvUI, use this function to save user-defined key bindings either globally or per character. This allows users to have different key bindings for different characters or a consistent set across all characters.