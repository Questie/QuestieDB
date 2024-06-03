## Title: GetSpellCooldown

**Content:**
Returns the cooldown info of a spell.
`start, duration, enabled, modRate = GetSpellCooldown(spell)`
`= GetSpellCooldown(index, bookType)`

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook.
      - **Constant**
      - **Value**
      - **Description**
      - `BOOKTYPE_SPELL`
        - `"spell"` - The General, Class, Specs and Professions tabs
      - `BOOKTYPE_PET`
        - `"pet"` - The Pet tab

**Returns:**
- `startTime`
  - *number* - The time when the cooldown started (as returned by GetTime()); zero if no cooldown; current time if (enabled == 0).
- `duration`
  - *number* - Cooldown duration in seconds, 0 if spell is ready to be cast.
- `enabled`
  - *number* - 0 if the spell is active (Stealth, Shadowmeld, Presence of Mind, etc) and the cooldown will begin as soon as the spell is used/cancelled; 1 otherwise.
- `modRate`
  - *number* - The rate at which the cooldown widget's animation should be updated.

**Description:**
- **Related Events**
  - `SPELL_UPDATE_COOLDOWN`
- **Details:**
  - To check the Global Cooldown, you can use the spell ID 61304. This is a dummy spell specifically for the GCD.
  - The enabled return value allows addons to easily check if the player has used a buff-providing spell (such as Presence of Mind or Nature's Swiftness) without searching through the player's buffs.
  - Values returned by this function are not updated immediately when `UNIT_SPELLCAST_SUCCEEDED` event is raised.

**Usage:**
The following snippet checks the state of cooldown. On English clients, you could also use "Presence of Mind" in place of 12043, which is the spell's ID.
```lua
local start, duration, enabled, modRate = GetSpellCooldown(12043)
if enabled == 0 then
  print("Presence of Mind is currently active, use it and wait " .. duration .. " seconds for the next one.")
elseif (start > 0 and duration > 0) then
  local cdLeft = start + duration - GetTime()
  print("Presence of Mind is cooling down, wait " .. cdLeft .. " seconds for the next one.")
else
  print("Presence of Mind is ready.")
end
```

**Example Use Case:**
- **Checking Spell Cooldowns:** This function is commonly used in addons to monitor the cooldown status of spells, allowing players to optimize their spell usage and rotations.

**Addons Using This Function:**
- **WeakAuras:** This popular addon uses `GetSpellCooldown` to display cooldown timers for spells, helping players track their abilities more effectively.
- **ElvUI:** This comprehensive UI replacement addon uses `GetSpellCooldown` to manage and display cooldown information on action bars and other UI elements.