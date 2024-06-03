## Event: AZERITE_ITEM_POWER_LEVEL_CHANGED

**Title:** AZERITE ITEM POWER LEVEL CHANGED

**Content:**
Sent to the add on each time the player's Heart of Azeroth gains a level.
`AZERITE_ITEM_POWER_LEVEL_CHANGED: azeriteItemLocation, oldPowerLevel, newPowerLevel, unlockedEmpoweredItemsInfo, azeriteItemID`

**Payload:**
- `azeriteItemLocation`
  - AzeriteItemLocation🔗
- `oldPowerLevel`
  - *number*
- `newPowerLevel`
  - *number*
- `unlockedEmpoweredItemsInfo`
  - UnlockedAzeriteEmpoweredItems
    - Field
    - Type
    - Description
    - unlockedItem
      - AzeriteEmpoweredItemLocation🔗
    - tierIndex
      - *number*
    - azeriteItemID
      - *number*