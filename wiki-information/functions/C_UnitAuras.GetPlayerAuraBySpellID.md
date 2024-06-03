## Title: C_UnitAuras.GetPlayerAuraBySpellID

**Content:**
Returns information about an aura on the player by a given spell ID.
`aura = C_UnitAuras.GetPlayerAuraBySpellID(spellID)`

**Parameters:**
- `spellID`
  - *number* - The spell ID to query.

**Returns:**
- `aura`
  - *AuraData?* - Structured information about the found aura, if any.
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
This function can be used to check if a player has a specific buff or debuff by its spell ID. For instance, if you want to check if the player has the "Power Word: Fortitude" buff, you can use its spell ID to query this function.

**Addons Using This Function:**
- **WeakAuras**: This popular addon uses this function to track and display auras on the player, allowing for highly customizable alerts and displays based on the player's current buffs and debuffs.
- **ElvUI**: This comprehensive UI replacement addon uses this function to manage and display aura information on unit frames, providing players with clear and concise information about their current auras.