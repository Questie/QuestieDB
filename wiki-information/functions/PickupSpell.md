## Title: PickupSpell

**Content:**
Places a spell onto the cursor.
`PickupSpell(spellID)`

**Parameters:**
- `spellID`
  - *number* - spell ID of the spell to pick up.

**Description:**
This function will put a spell on the mouse cursor.

**Reference:**
- `PickupAction`
- `PickupPetAction`
- `PickupBagFromSlot`
- `PickupContainerItem`
- `PickupInventoryItem`
- `PickupItem`
- `PickupMacro`
- `PickupMerchantItem`
- `PickupPlayerMoney`
- `PickupStablePet`
- `PickupTradeMoney`
- `ClearCursor`

**Example Usage:**
```lua
-- Example of how to use PickupSpell
local spellID = 116 -- Frostbolt for Mages
PickupSpell(spellID)
```

**Common Addon Usage:**
Many addons that manage action bars or spell books, such as Bartender4 or Dominos, use `PickupSpell` to allow users to drag and drop spells onto their action bars.