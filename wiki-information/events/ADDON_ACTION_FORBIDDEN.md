## Event: ADDON_ACTION_FORBIDDEN

**Title:** ADDON ACTION FORBIDDEN

**Content:**
Fires when an AddOn tries use actions that are always forbidden (movement, targeting, etc.).
`ADDON_ACTION_FORBIDDEN: isTainted, function`

**Payload:**
- `isTainted`
  - *string* - Name of the AddOn that was last involved in the execution path. It's very possible that the name will not be the name of the addon that tried to call the protected function.
- `function`
  - *string* - The protected function that was called.