## Event: CURSOR_CHANGED

**Title:** CURSOR CHANGED

**Content:**
Fires when the cursor changes. Includes information on the previous and new cursor type (e.g. item, money, spells).
`CURSOR_CHANGED: isDefault, newCursorType, oldCursorType, oldCursorVirtualID`

**Payload:**
- `isDefault`
  - *boolean*
- `newCursorType`
  - *Enum.UICursorType*
- `oldCursorType`
  - *Enum.UICursorType*
  - *Value* - *Field* - *Description*
  - 0 - Default
  - 1 - Item
  - 2 - Money
  - 3 - Spell
  - 4 - PetAction
  - 5 - Merchant
  - 6 - ActionBar
  - 7 - Macro
  - 9 - AmmoObsolete
  - 10 - Pet
  - 11 - GuildBank
  - 12 - GuildBankMoney
  - 13 - EquipmentSet
  - 14 - Currency
  - 15 - Flyout
  - 16 - VoidItem
  - 17 - BattlePet
  - 18 - Mount
  - 19 - Toy
  - 20 - ConduitCollectionItem
  - 21 - PerksProgramVendorItem
  - Added in 10.0.5
- `oldCursorVirtualID`
  - *number*