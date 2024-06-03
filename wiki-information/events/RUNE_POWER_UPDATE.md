## Event: RUNE_POWER_UPDATE

**Title:** RUNE POWER UPDATE

**Content:**
Fired when a rune's state switches from usable to un-usable or visa-versa.
`RUNE_POWER_UPDATE: runeIndex, added`

**Payload:**
- `runeIndex`
  - *number*
- `added`
  - *boolean?* - is the rune usable (if usable, it's not cooling, if not usable it's cooling)