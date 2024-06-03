## Event: PLAYERBANKSLOTS_CHANGED

**Title:** PLAYERBANKSLOTS CHANGED

**Content:**
Fired when the One of the slots in the player's 24 bank slots has changed, or when any of the equipped bank bags have changed. Does not fire when an item is added to or removed from a bank bag.
`PLAYERBANKSLOTS_CHANGED: slot`

**Payload:**
- `slot`
  - *number* - When (slot <= NUM_BANKGENERIC_SLOTS), slot is the index of the generic bank slot that changed. When (slot > NUM_BANKGENERIC_SLOTS), (slot - NUM_BANKGENERIC_SLOTS) is the index of the equipped bank bag that changed.