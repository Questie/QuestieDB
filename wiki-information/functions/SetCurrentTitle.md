## Title: SetCurrentTitle

**Content:**
Sets the player's displayed title.
`SetCurrentTitle(titleId)`

**Parameters:**
- `titleId`
  - *number* : TitleId - ID of the title you want to set. The identifiers are global and therefore do not depend on which titles you have learned. 0, invalid or unlearned IDs clear your title.

**Description:**
The last indexed value (currently 143) returns nil and removes the player's name completely (not available to players).
`GetTitleName` can be used to find the name associated with the TitleId.

**Usage:**
This sets the title "Elder" if your character had earned the title, otherwise it removes any active title.
```lua
SetCurrentTitle(43)
```

Sets a random title from the available ones.
```lua
/run local t = {} for i = 1, GetNumTitles() do if IsTitleKnown(i) then tinsert(t, i) end end SetCurrentTitle(t[math.random(#t)])
```