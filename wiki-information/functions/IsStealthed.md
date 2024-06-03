## Title: IsStealthed

**Content:**
Returns true if the character is currently stealthed.
`stealthed = IsStealthed()`

**Returns:**
- `stealthed`
  - *boolean* - true if stealthed, otherwise false

**Description:**
Stealth includes abilities like `Stealth`, `Prowl`, and `Shadowmeld`.

**Reference:**
- `UPDATE_STEALTH` - Fires when a player enters or leaves stealth.
- Macro conditionals - `stealth` or `nostealth` may be used in macros or with a `SecureStateDriver`.