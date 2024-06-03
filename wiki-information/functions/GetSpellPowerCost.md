## Title: GetSpellPowerCost

**Content:**
Returns resource cost info for a spell.
`costs = GetSpellPowerCost(spell)`
`costs = GetSpellPowerCost(index, bookType)`

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook.
      - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant**
        - **Value**
        - **Description**
        - `BOOKTYPE_SPELL`
          - "spell" - The General, Class, Specs and Professions tabs
        - `BOOKTYPE_PET`
          - "pet" - The Pet tab

**Returns:**
- `costs`
  - *table*
    - **Field**
    - **Type**
    - **Description**
    - `minCost`
      - *number* - minimum cost
    - `cost`
      - *number* - maximum cost
    - `costPercent`
      - *number* - percentual cost
    - `costPerSec`
      - *number* - The cost per second for channeled spells.
    - `type`
      - *Enum.PowerType* - Enum.PowerType
    - `name`
      - *string* - powerToken: "MANA", "RAGE", "FOCUS", "ENERGY", "HAPPINESS", "RUNES", "RUNIC_POWER", "SOUL_SHARDS", "HOLY_POWER", "STAGGER", "CHI", "FURY", "PAIN", "LUNAR_POWER", "INSANITY"
    - `hasRequiredAura`
      - *boolean*
    - `requiredAuraID`
      - *number*

**Description:**
Returns an empty table if the spell has no resource cost.
Reflects resource discounts provided by auras.
`requiredAuraID` has a return value different than zero for 36 spells. Most are spellIDs associated with a hidden healing/damage modifier spec aura, one refers to , two seem to be connected to Helya; some are honor talents, and some don't refer to a valid aura spellID. This return value mostly exists for spells that change their cost depending on which spec the player is in.
Some spells may have costs composed of multiple resource types. In this case, the costs array contains multiple tables. For example, `GetSpellPowerCost("Rip")` returns:
```lua
{
  {type=3, name="ENERGY", cost=30, minCost=30, costPercent=0, costPerSec=0, hasRequiredAura=false, requiredAuraID=0},
  {type=4, name="COMBO_POINTS", cost=5, minCost=1, costPercent=0, costPerSec=0, hasRequiredAura=false, requiredAuraID=0}
}
```