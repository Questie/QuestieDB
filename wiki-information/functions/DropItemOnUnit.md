## Title: DropItemOnUnit

**Content:**
Drops an item from the cursor onto a unit, i.e. to initiate a trade.
`DropItemOnUnit(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - Unit to which you want to give the item on the cursor.

**Usage:**
```lua
if (CursorHasItem()) then
  DropItemOnUnit("pet");
end;
```

**Miscellaneous:**
**Result:**
Item is dropped from the cursor and given to the player's pet.