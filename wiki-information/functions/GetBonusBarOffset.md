## Title: GetBonusBarOffset

**Content:**
Returns the current bonus action bar index (e.g. for the Rogue stealth bar).
`offset = GetBonusBarOffset()`

**Parameters:**
- **Returns**
  - `offset` - *Number* - The current bonus action bar index.

**Description:**
Certain classes have "bonus action bars" for their class-specific actions, e.g. the various Stance Bars for the Warrior class. `GetBonusBarOffset()` returns the index of the current action bar that is being displayed. Note that simply scrolling through the action bar pages won't change the output; only switching to the different bonus bars. Each class has their own way of indexing their bonus bars.

- **Warrior**
  - Battle Stance: 1
  - Defensive Stance: 2
  - Berserker Stance: 3
- **Druid**
  - Caster: 0
  - Cat: 1
  - Tree of Life: 2
  - Bear: 3
  - Moonkin: 4
- **Rogue**
  - Normal: 0
  - Stealthed: 1
- **Priest**
  - Normal: 0
  - Shadowform: 1
- **All Characters**
  - When Possessing a Target: 5

**Usage:**
```lua
/script ChatFrame1:AddMessage(GetBonusBarOffset())
```
This will simply print the output of `GetBonusBarOffset()`. It should change as you change between your bonus bars.

```lua
slotID = (1 + (NUM_ACTIONBAR_PAGES + GetBonusBarOffset() - 1) * NUM_ACTIONBAR_BUTTONS)
```
Here, `slotID` will be the action slot number for the first slot of the current bonus bar. For example, for a Warrior in Defensive Stance, `slotID = 85`, which is correct. (ActionSlot)