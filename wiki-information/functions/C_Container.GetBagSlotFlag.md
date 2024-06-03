## Title: C_Container.GetBagSlotFlag

**Content:**
Needs summary.
`isSet = C_Container.GetBagSlotFlag(bagIndex, flag)`

**Parameters:**
- `bagIndex`
  - *number*
- `flag`
  - *Enum.BagSlotFlags*
    - `Value`
    - `Field`
    - `Description`
      - `1` - DisableAutoSort
      - `2` - PriorityEquipment
      - `4` - PriorityConsumables
      - `8` - PriorityTradeGoods
      - `16` - PriorityJunk
      - `32` - PriorityQuestItems
      - `63` - BagSlotValidFlagsAll
      - `62` - BagSlotPriorityFlagsAll

**Returns:**
- `isSet`
  - *boolean*