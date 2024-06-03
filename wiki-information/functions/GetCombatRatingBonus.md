## Title: GetCombatRatingBonus

**Content:**
Returns the bonus percentage for a specific combat rating.
`ratingBonus = GetCombatRatingBonus(ratingIndex)`

**Parameters:**
- `ratingIndex`
  - *number* - One of the following values from FrameXML/PaperDollFrame.lua:
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
- `ratingBonus`
  - *number* - the actual bonus in percent the combat rating confers; e.g. 5.13452

**Usage:**
```lua
hitBonus = GetCombatRatingBonus(CR_HIT_MELEE) -- 5.13452
```

**Reference:**
- `GetCombatRating`: Gets the underlying rating that contributes to the bonus
- `GetCritChance`: Gets the player's current Crit Chance %
- `GetMastery`: Gets the player's current Mastery %
- `GetDodgeChance`: Gets the player's current Dodge Chance %
- `GetParryChance`: Gets the player's current Parry Chance %
- `GetBlockChance`: Gets the player's current Block Chance %