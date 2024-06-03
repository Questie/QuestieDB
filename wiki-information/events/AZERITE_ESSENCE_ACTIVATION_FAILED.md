## Event: AZERITE_ESSENCE_ACTIVATION_FAILED

**Title:** AZERITE ESSENCE ACTIVATION FAILED

**Content:**
Fires when the player cannot drop an ability onto the Heart of Azeroth window.
`AZERITE_ESSENCE_ACTIVATION_FAILED: slot, essenceID`

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