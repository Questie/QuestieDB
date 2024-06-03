## Event: BAG_UPDATE

**Title:** BAG UPDATE

**Content:**
Fired when a bags inventory changes.
`BAG_UPDATE: bagID`

**Payload:**
- `bagID`
  - *number*

**Content Details:**
Bag zero, the sixteen slot default backpack, may not fire on login. Upon login (or reloading the console) this event fires even for bank bags. When moving an item in your inventory, this fires multiple times: once each for the source and destination bag. If the bag involved is the default backpack, this event will also fire with a container ID of "-2" (twice if you are moving the item inside the same bag).