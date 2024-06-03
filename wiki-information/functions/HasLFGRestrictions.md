## Title: HasLFGRestrictions

**Content:**
Returns whether the player is in a random party formed by the dungeon finder system.
`isRestricted = HasLFGRestrictions()`

**Returns:**
- `isRestricted`
  - *boolean* - 1 if the current party is subject to LFG restrictions, nil otherwise.

**Description:**
Parties formed by the dungeon finder are restricted unless all 5 party members joined the dungeon finder as a party.
The Party Leader of such parties is referred to as "Dungeon Guide" by the default UI, and may not alter the loot system or arbitrarily remove people from the party.