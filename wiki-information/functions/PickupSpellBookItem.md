## Title: PickupSpellBookItem

**Content:**
Picks up a skill from the spellbook so that it can subsequently be placed on an action bar.
```lua
PickupSpellBookItem(spell)
PickupSpellBookItem(index, bookType)
```

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook.
      - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant Values:**
        - `BOOKTYPE_SPELL`
          - "spell" - The General, Class, Specs, and Professions tabs
        - `BOOKTYPE_PET`
          - "pet" - The Pet tab

**Usage:**
The following sequence of macro commands places the Cat Form ability into the current action bar's first slot.
```lua
/run PickupSpellBookItem("Cat Form")
/click ActionButton1
/run ClearCursor()
```

**Example Use Case:**
This function is particularly useful for creating macros that automate the placement of spells and abilities on action bars. For instance, a player might use this function to quickly set up their action bars after resetting their UI or switching specializations.

**Addons:**
Many popular addons, such as Bartender4 and Dominos, use this function to allow players to customize their action bars by dragging and dropping spells from the spellbook. These addons enhance the default UI by providing more flexible and user-friendly ways to manage action bars.