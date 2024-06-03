## Event: AZERITE_ESSENCE_ACTIVATED

**Title:** AZERITE ESSENCE ACTIVATED

**Content:**
Fires when the player drops an ability onto the Heart of Azeroth window.
`AZERITE_ESSENCE_ACTIVATED: slot, essenceID`

**Payload:**
- `slot`
  - *Enum.AzeriteEssenceSlot*
  - *Value*
  - *Field*
  - *Description*
  - 0 - MainSlot
  - 1 - PassiveOneSlot
  - 2 - PassiveTwoSlot
  - 3 - PassiveThreeSlot
  - Added in 8.3.0
- `essenceID`
  - *number*