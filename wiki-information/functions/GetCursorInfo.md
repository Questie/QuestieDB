## Title: GetCursorInfo

**Content:**
Returns what the mouse cursor is holding.
`infoType, ... = GetCursorInfo()`

**Returns:**
The first return value is a string indicating the nature of an object on the cursor; additional return values provide detail. The following return value combinations have been observed:
- `"item"`, `itemID`, `itemLink`
  - `itemID` : *number* - Item ID of the item on the cursor.
  - `itemLink` : *string* - ItemLink of the item on the cursor.
- `"spell"`, `spellIndex`, `bookType`, `spellID`
  - `spellIndex` : *number* - The index of the spell in the spell book.
  - `bookType` : *string* - Always BOOKTYPE_SPELL (or else the type would have been "petaction").
  - `spellID` : *number* - Spell ID of the spell on the cursor.
- `"petaction"`, `spellID`, `spellIndex`, `retVal3`
  - `spellID` : *number* - Spell ID of the pet action on the cursor, or unknown 0-4 number if the spell is a shared pet control spell (Follow, Stay, Assist, Defensive, etc...).
  - `spellIndex` : *number* - The index of the spell in the pet spell book, or nil if the spell is a shared pet control spell (Follow, Stay, Assist, Defensive, etc...).
  - `retVal3` : Needs summary.
- `"macro"`, `index`
  - `index` : *number* - The index of the macro on the cursor.
- `"money"`, `amount`
  - `amount` : *number* - The amount of money in copper.
- `"mount"`, `mountID`, `mountIndex`
  - `mountID` : *number* - The ID of the mount.
  - `mountIndex` : *number* - The index of the mount in the journal.
- `"merchant"`, `index`
  - `index` : *number* - The index of the merchant item.
- `"battlepet"`, `petGUID`
  - `petGUID` : *string* - GUID of a battle pet in your collection.

**Description:**
Related Events:
- `CURSOR_UPDATE`
- `CURSOR_CHANGED`

Related API:
- `GetCursorPosition`

**Usage:**
The following snippet, if you're holding an item, prints out the amount of that item in your bags.
```lua
local infoType, itemID, itemLink = GetCursorInfo()
if infoType == "item" then
  print("You have " .. GetItemCount(itemLink) .. "x" .. itemLink .. " in your bags.")
else
  print("You're not holding an item on your cursor.")
end
```