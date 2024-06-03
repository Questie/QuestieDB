## Title: C_UnitAuras.GetAuraDataBySpellName

**Content:**
Needs summary.
`aura = C_UnitAuras.GetAuraDataBySpellName(unitToken, spellName)`

**Parameters:**
- `unitToken`
  - *string* - UnitId
- `spellName`
  - *string*
- `filter`
  - *string?* - A list of filters, separated by pipe chars or spaces. Otherwise defaults to "HELPFUL".

**Miscellaneous:**
- **Filter**
  - **Description**
  - `"HELPFUL"`
    - Buffs
  - `"HARMFUL"`
    - Debuffs
  - `"PLAYER"`
    - Auras Debuffs applied by the player
  - `"RAID"`
    - Buffs the player can apply and debuffs the player can dispel
  - `"CANCELABLE"`
    - Buffs that can be cancelled with /cancelaura or CancelUnitBuff()
  - `"NOT_CANCELABLE"`
    - Buffs that cannot be cancelled
  - `"INCLUDE_NAME_PLATE_ONLY"`
    - Auras that should be shown on nameplates
  - `"MAW"`
    - Torghast Anima Powers

**Returns:**
- `aura`
  - *AuraData?*
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

**Example Usage:**
This function can be used to retrieve detailed information about a specific aura (buff or debuff) on a unit by its spell name. For instance, if you want to check if a player has a specific buff and get its details, you can use this function.

**Addon Usage:**
Large addons like WeakAuras use this function to track and display aura information on units. WeakAuras can create custom visual and audio alerts based on the presence and details of specific auras, helping players to react to buffs and debuffs in real-time.