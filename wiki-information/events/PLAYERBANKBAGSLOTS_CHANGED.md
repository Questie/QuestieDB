## Event: PLAYERBANKBAGSLOTS_CHANGED

**Title:** PLAYERBANKBAGSLOTS CHANGED

**Content:**
This event only fires when bank bags slots are purchased. It no longer fires when bags in the slots are changed. Instead, when the bags are changed, PLAYERBANKSLOTS_CHANGED will fire, and arg1 will be NUM_BANKGENERIC_SLOTS + BagIndex.
`PLAYERBANKBAGSLOTS_CHANGED`

**Payload:**
- `None`