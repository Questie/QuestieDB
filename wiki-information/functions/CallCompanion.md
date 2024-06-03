## Title: CallCompanion

**Content:**
Summons a companion.
`CallCompanion(type, id)`

**Parameters:**
- `type`
  - *string* - The type of companion to summon or dismiss: "CRITTER" or "MOUNT".
- `id`
  - *number* - The companion index to summon or dismiss, ascending from 1.

**Usage:**
The following macro summons the first mount your character has acquired:
```lua
/run CallCompanion("MOUNT",1)
```
The following macro summons a random mount your character has acquired:
```lua
/run CallCompanion("MOUNT", random(GetNumCompanions("MOUNT")))
```

**Description:**
The list of companions is usually, but not always, alphabetically sorted. You may not rely on the indices to remain stable, even if the number of companions is not altered.

**Reference:**
- `GetNumCompanions`
- `GetCompanionInfo`