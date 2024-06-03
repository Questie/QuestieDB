## Title: GetSpellInfo

**Content:**
Returns spell info.
```lua
name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(spell)
name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(index, bookType)
```

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - BOOKTYPE_SPELL or BOOKTYPE_PET depending on if you wish to query the player or pet spellbook. Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant**
      - **Value**
      - **Description**
      - `BOOKTYPE_SPELL`
        - "spell" - The General, Class, Specs and Professions tabs
      - `BOOKTYPE_PET`
        - "pet" - The Pet tab

**Returns:**
- `name`
  - *string* - The localized name of the spell.
- `rank`
  - *string* - Always returns nil. Refer to GetSpellSubtext() for retrieving the rank of spells on Classic.
- `icon`
  - *number : FileID* - The spell icon texture.
- `castTime`
  - *number* - Cast time in milliseconds, or 0 for instant spells.
- `minRange`
  - *number* - Minimum range of the spell, or 0 if not applicable.
- `maxRange`
  - *number* - Maximum range of the spell, or 0 if not applicable.
- `spellID`
  - *number* - The ID of the spell.
- `originalIcon`
  - *number : FileID* - The original icon texture for this spell.

**Description:**
The player's form or stance may affect return values on relevant spells, such as a warlock's Corruption spell transforming to Doom while Metamorphosis is active.
When dealing with base spells that have been overridden by another spell, the icon return will represent the icon of the overriding spell, and originalIcon the icon of the base spell.
For example, if a Rogue has learned Gloomblade, then any queries for Backstab will yield Gloomblade's icon as the icon return, and the original icon for Backstab would be exposed through the originalIcon return value.

**Usage:**
```lua
/dump GetSpellInfo(2061) -- "Flash Heal", nil, 135907, 1352, 0, 40, 2061
```
Some spell data - such as subtext and description - are load on demand. You can use `SpellMixin:ContinueOnSpellLoad()` to asynchronously query the data.
```lua
local spell = Spell:CreateFromSpellID(139)
spell:ContinueOnSpellLoad(function()
    local name = spell:GetSpellName()
    local desc = spell:GetSpellDescription()
    print(name, desc) -- "Renew", "Fill the target with faith in the light, healing for 295 over 15 sec."
end)
```

**Reference:**
Battle for Azeroth Addon Changes by Ythisens, 24 Apr 2018