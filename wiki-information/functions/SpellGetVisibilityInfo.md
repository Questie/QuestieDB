## Title: SpellGetVisibilityInfo

**Content:**
Checks if the spell should be visible, depending on spellId and raid combat status.
`hasCustom, alwaysShowMine, showForMySpec = SpellGetVisibilityInfo(spellId, visType)`

**Parameters:**
- `spellId`
  - *number* - The ID of the spell to check.
- `visType`
  - *string* - either "RAID_INCOMBAT" if in combat, "RAID_OUTOFCOMBAT" otherwise.

**Returns:**
- `hasCustom`
  - *boolean* - whether the spell visibility should be customized, if false it means always display.
- `alwaysShowMine`
  - *boolean* - whether to show the spell if cast by the player/player's pet/vehicle (e.g. the Paladin Forbearance debuff).
- `showForMySpec`
  - *boolean* - whether to show the spell for the current specialization of the player.

**Description:**
This is used by Blizzard's compact frame until 8.2.5, for whether it should be shown in the raid UI.