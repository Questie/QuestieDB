## Title: GetCurrentBindingSet

**Content:**
Returns if either account or character-specific bindings are active.
`which = GetCurrentBindingSet()`

**Returns:**
- `which`
  - *number* - One of the following values:
    - `ACCOUNT_BINDINGS = 1`
      - indicates that account-wide bindings are currently active.
    - `CHARACTER_BINDINGS = 2`
      - indicates that per-character bindings are currently active.

**Description:**
The return value of this function depends on the last call to `SaveBindings`.