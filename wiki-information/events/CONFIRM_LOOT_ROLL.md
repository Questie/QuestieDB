## Event: CONFIRM_LOOT_ROLL

**Title:** CONFIRM LOOT ROLL

**Content:**
Fires when you try to roll "need" or "greed" for and item which Binds on Pickup.
`CONFIRM_LOOT_ROLL: rollID, rollType, confirmReason`

**Payload:**
- `rollID`
  - *number*
- `rollType`
  - *number* - 1=Need, 2=Greed, 3=Disenchant
- `confirmReason`
  - *string*

**Related Information:**
RollOnLoot()