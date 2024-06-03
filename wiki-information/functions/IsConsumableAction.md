## Title: IsConsumableAction

**Content:**
Returns true if an action is a consumable, i.e. it has a count.
`isTrue = IsConsumableAction(slotID)`

**Parameters:**
- `slotID`
  - *ActionSlot* - The tested action slot.

**Returns:**
- `isTrue`
  - *Boolean* - True if the action in the specified slot is linked to a consumable, e.g. a potion action. False if the action is not consumable or if the action is empty.

**Description:**
Most consumable actions have a small number displayed in the bottom right corner of their action icon.
However, in Classic, spells requiring a reagent may return true to `IsConsumableAction()` but false to both `IsItemAction` and `IsStackableAction`; such spells do not display a number.

**Details:**
Currently, thrown weapons show up with a count of 1. In WoW 2.0, throwing weapons have durability and can be repaired, so this is likely a bug.