## Title: GetSpellCharges

**Content:**
Returns information about the charges of a charge-accumulating player ability.
```lua
currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spell)
currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(index, bookType)
```

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook. Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant**
        - **Value**
        - **Description**
        - `BOOKTYPE_SPELL`
          - `"spell"` - The General, Class, Specs and Professions tabs
        - `BOOKTYPE_PET`
          - `"pet"` - The Pet tab

**Returns:**
- `currentCharges`
  - *number* - The number of charges of the ability currently available.
- `maxCharges`
  - *number* - The maximum number of charges the ability may have available.
- `cooldownStart`
  - *number* - Time (per GetTime) at which the last charge cooldown began, or 2^32 / 1000 - cooldownDuration if the spell is not currently recharging.
- `cooldownDuration`
  - *number* - Time (in seconds) required to gain a charge.
- `chargeModRate`
  - *number* - The rate at which the charge cooldown widget's animation should be updated.

**Description:**
Abilities like can be used by the player rapidly, and then slowly accumulate charges over time. The `cooldownStart` and `cooldownDuration` return values indicate the cooldown timer for acquiring the next charge (when `currentCharges` is less than `maxCharges`).
If the queried spell does not accumulate charges over time (e.g. or ), this function does not return any values.
Targeted dispels like or hold one hidden charge which may be queried with `GetSpellCharges`. The spells will immediately—or after a few in-game ticks—regain their charge if cast on a friendly unit that could not be dispelled. This may cause sporadic behavior when tracking cooldowns, because upon raising `SPELL_UPDATE_COOLDOWN`, the function API `GetSpellCooldown` will momentarily return that the spell is on its full cooldown duration.

**Reference:**
- `GetActionCharges(slot)` - Referring to a button on an action bar.