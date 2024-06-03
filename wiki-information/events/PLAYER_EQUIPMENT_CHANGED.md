## Event: PLAYER_EQUIPMENT_CHANGED

**Title:** PLAYER EQUIPMENT CHANGED

**Content:**
This event is fired when the players gear changes.
`PLAYER_EQUIPMENT_CHANGED: equipmentSlot, hasCurrent`

**Payload:**
- `equipmentSlot`
  - *number* - InventorySlotId
- `hasCurrent`
  - *boolean* - True when a slot becomes empty, false when filled.

**Content Details:**
The second payload value was historically documented doing the reverse; true (1) when filled or false (nil) otherwise. 
Modern FrameXML code labels the payload hasCurrent but does not actually use this payload, so the developer intent is unclear.
It is unknown if the return values in fact 'flipped' at some point, or if the early documentation was simply wrong.