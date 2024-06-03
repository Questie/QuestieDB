## Event: LOOT_READY

**Title:** LOOT READY

**Content:**
This is fired when looting begins, but before the loot window is shown. Loot functions like GetNumLootItems will be available until LOOT_CLOSED is fired.
`LOOT_READY: autoloot`

**Payload:**
- `autoloot`
  - *boolean* - Equal to autoLootDefault.

**Related Information:**
LOOT_OPENED
LOOT_CLOSED