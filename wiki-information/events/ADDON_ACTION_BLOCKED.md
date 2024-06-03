## Event: ADDON_ACTION_BLOCKED

**Title:** ADDON ACTION BLOCKED

**Content:**
Fires when a protected function is being called from tainted code, e.g. taint from an addon.
`ADDON_ACTION_BLOCKED: isTainted, function`

**Payload:**
- `isTainted`
  - *string*
- `function`
  - *string*