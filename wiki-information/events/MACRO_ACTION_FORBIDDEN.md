## Event: MACRO_ACTION_FORBIDDEN

**Title:** MACRO ACTION FORBIDDEN

**Content:**
Sent when a macro tries use actions that are always forbidden (movement, targeting, etc.).
`MACRO_ACTION_FORBIDDEN: function`

**Payload:**
- `function`
  - *string* - The name of the forbidden function, e.g. "ToggleRun()"