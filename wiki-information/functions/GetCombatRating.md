## Title: GetCombatRating

**Content:**
Returns a specific combat rating.
`rating = GetCombatRating(ratingIndex)`

**Parameters:**
- `ratingIndex`
  - *number* - One of the following constants from FrameXML/PaperDollFrame.lua:
    - `Value`
    - `Field`
    - `Description`
    - `1`
      - `CR_WEAPON_SKILL` - Removed in patch 6.0.2
    - `2`
      - `CR_DEFENSE_SKILL`
    - `3`
      - `CR_DODGE`
    - `4`
      - `CR_PARRY`
    - `5`
      - `CR_BLOCK`
    - `6`
      - `CR_HIT_MELEE`
    - `7`
      - `CR_HIT_RANGED`
    - `8`
      - `CR_HIT_SPELL`
    - `9`
      - `CR_CRIT_MELEE`
    - `10`
      - `CR_CRIT_RANGED`
    - `11`
      - `CR_CRIT_SPELL`
    - `12`
      - `CR_MULTISTRIKE` - Formerly CR_HIT_TAKEN_MELEE until patch 6.0.2
    - `13`
      - `CR_READINESS` - Formerly CR_HIT_TAKEN_SPELL until patch 6.0.2
    - `14`
      - `CR_SPEED` - Formerly CR_HIT_TAKEN_SPELL until patch 6.0.2
    - `15`
      - `CR_RESILIENCE_CRIT_TAKEN`
    - `16`
      - `CR_RESILIENCE_PLAYER_DAMAGE_TAKEN`
    - `17`
      - `CR_LIFESTEAL` - Formerly CR_CRIT_TAKEN_SPELL until patch 6.0.2
    - `18`
      - `CR_HASTE_MELEE`
    - `19`
      - `CR_HASTE_RANGED`
    - `20`
      - `CR_HASTE_SPELL`
    - `21`
      - `CR_AVOIDANCE` - Formerly CR_WEAPON_SKILL_MAINHAND until patch 6.0.2
    - `22`
      - `CR_WEAPON_SKILL_OFFHAND` - Removed in patch 6.0.2
    - `23`
      - `CR_WEAPON_SKILL_RANGED`
    - `24`
      - `CR_EXPERTISE`
    - `25`
      - `CR_ARMOR_PENETRATION`
    - `26`
      - `CR_MASTERY`
    - `27`
      - `CR_PVP_POWER` - Removed in patch 6.0.2
    - `29`
      - `CR_VERSATILITY_DAMAGE_DONE`
    - `31`
      - `CR_VERSATILITY_DAMAGE_TAKEN`

**Returns:**
- `rating`
  - *number* - the actual rating for the combat rating.

**Description:**
Related API: `GetCombatRatingBonus`

**Usage:**
```lua
local hitRating = GetCombatRating(CR_HIT_MELEE)
print(hitRating) -- 63
```

**Example Use Case:**
This function can be used to retrieve the player's current rating for a specific combat stat, which can be useful for addons that display detailed character statistics or for custom UI elements that need to show combat ratings.

**Addons Using This API:**
Many popular addons like "Details! Damage Meter" and "Recount" use this API to display detailed combat statistics and performance metrics for players.