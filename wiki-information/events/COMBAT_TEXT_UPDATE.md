## Event: COMBAT_TEXT_UPDATE

**Title:** COMBAT TEXT UPDATE

**Content:**
Fired when the currently watched entity (as set by the CombatTextSetActiveUnit function) takes or avoids damage, receives heals, gains mana/energy/rage, etc. This event is used by Blizzard's floating combat text addon.
`COMBAT_TEXT_UPDATE: combatTextType`

**Payload:**
- `combatTextType`
  - *string* - Combat message type. Known values include
    - "DAMAGE"
    - "SPELL_DAMAGE"
    - "DAMAGE_CRIT"
    - "HEAL"
    - "PERIODIC_HEAL"
    - "HEAL_CRIT"
    - "MISS"
    - "DODGE"
    - "PARRY"
    - "BLOCK"
    - "RESIST"
    - "SPELL_RESISTED"
    - "ABSORB"
    - "SPELL_ABSORBED"
    - "MANA"
    - "ENERGY"
    - "RAGE"
    - "FOCUS"
    - "SPELL_ACTIVE"
    - "COMBO_POINTS"
    - "AURA_START"
    - "AURA_END"
    - "AURA_START_HARMFUL"
    - "AURA_END_HARMFUL"
    - "HONOR_GAINED"
    - "FACTION"