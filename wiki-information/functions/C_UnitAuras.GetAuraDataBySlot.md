## Title: C_UnitAuras.GetAuraDataBySlot

**Content:**
Returns information about an aura on a unit by a given slot index.
`aura = C_UnitAuras.GetAuraDataBySlot(unit, slot)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to query.
- `slot`
  - *number* - A slot index obtained from the variable returns of UnitAuraSlots.

**Returns:**
- `aura`
  - *UnitAuraInfo?* - Structured information about the found aura, if any.
    - `applications`
      - *number*
    - `auraInstanceID`
      - *number*
    - `canApplyAura`
      - *boolean* - Whether or not the player can apply this aura.
    - `charges`
      - *number*
    - `dispelName`
      - *string?*
    - `duration`
      - *number*
    - `expirationTime`
      - *number*
    - `icon`
      - *number*
    - `isBossAura`
      - *boolean* - Whether or not this aura was applied by a boss.
    - `isFromPlayerOrPlayerPet`
      - *boolean* - Whether or not this aura was applied by a player or their pet.
    - `isHarmful`
      - *boolean* - Whether or not this aura is a debuff.
    - `isHelpful`
      - *boolean* - Whether or not this aura is a buff.
    - `isNameplateOnly`
      - *boolean* - Whether or not this aura should appear on nameplates.
    - `isRaid`
      - *boolean* - Whether or not this aura meets the conditions of the RAID aura filter.
    - `isStealable`
      - *boolean*
    - `maxCharges`
      - *number*
    - `name`
      - *string* - The name of the aura.
    - `nameplateShowAll`
      - *boolean* - Whether or not this aura should always be shown irrespective of any usual filtering logic.
    - `nameplateShowPersonal`
      - *boolean*
    - `points`
      - *array* - Variable returns - Some auras return additional values that typically correspond to something shown in the tooltip, such as the remaining strength of an absorption effect.
    - `sourceUnit`
      - *string?* - Token of the unit that applied the aura.
    - `spellId`
      - *number* - The spell ID of the aura.
    - `timeMod`
      - *number*

**Description:**
This API can be used as an alternative to UnitAuraBySlot to obtain information about the aura in a structured table.