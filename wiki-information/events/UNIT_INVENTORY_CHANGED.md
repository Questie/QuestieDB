## Event: UNIT_INVENTORY_CHANGED

**Title:** UNIT INVENTORY CHANGED

**Content:**
Fired when the player equips or unequips an item.
`UNIT_INVENTORY_CHANGED: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
This event is not triggered when equipping/unequipping rings or trinkets.
This can also be called if your target or party members changes equipment (untested for hostile targets).
This event is also raised when a new item is placed in the player's containers, taking up a new slot. If the new item(s) are placed onto an existing stack or when two stacks already in the containers are merged, the event is not raised. When an item is moved inside the container or to the bank, the event is not raised. The event is raised when an existing stack is split inside the player's containers.
This event is also raised when a temporary enhancement (poison, lure, etc..) is applied to the player's weapon (untested for other units). It will again be raised when that enhancement is removed, including by manual cancellation or buff expiration.
If multiple slots are equipped/unequipped at once it only fires once now.
This event is triggered during initial character login but not during subsequent reloads.
This event is no longer triggered when changing zones. Inventory information is available when PLAYER_ENTERING_WORLD is triggered.