## Event: PLAYER_AVG_ITEM_LEVEL_UPDATE

**Title:** PLAYER AVG ITEM LEVEL UPDATE

**Content:**
This event fires when the player's item level changes, and it fires on both maximum item level changes (when you acquire a new piece of soulbound armor of your armor type that has the highest item level in that slot) and equipped item level changes (equipping or removing armor). This event will therefore fire when you gain azerite if it levels up your .
It fires three times in all of these scenarios:
Equipping armor in an empty slot
Removing armor to leave that slot empty
Equipping armor in a slot where it would automatically remove another armor
Using the equipment manager to equip and remove multiple pieces of armor at once.
The following scenarios still need to be tested to see if they cause this event to fire:
The player puts their highest item level armor in the bank or void storage
The player's equipped armor loses all durability
The player's highest item level armor loses all durability while in the player's inventory
`PLAYER_AVG_ITEM_LEVEL_UPDATE`

**Payload:**
- `None - You'll have to find some other way to get the player's equipped or maximum item level.`