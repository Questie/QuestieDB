## Title: SpellStopCasting

**Content:**
Stops the current spellcast.
`stopped = SpellStopCasting()`

**Returns:**
- `stopped`
  - *boolean* - 1 if a spell was being cast, nil otherwise.

**Example Usage:**
```lua
-- Example of stopping a spell cast
local wasCasting = SpellStopCasting()
if wasCasting then
    print("Spell casting was stopped.")
else
    print("No spell was being cast.")
end
```

**Description:**
The `SpellStopCasting` function is useful in scenarios where you need to interrupt a spell cast, such as when a player needs to move or switch to a different action quickly. This function is often used in macros and addons to enhance gameplay efficiency.

**Addons Using This Function:**
- **Quartz**: A popular casting bar addon that uses `SpellStopCasting` to manage and display the player's casting bar, ensuring accurate representation of spell interruptions.
- **WeakAuras**: A powerful and flexible framework for displaying highly customizable graphics on your screen to indicate buffs, debuffs, and other relevant information. It can use `SpellStopCasting` to trigger alerts or animations when a spell cast is interrupted.