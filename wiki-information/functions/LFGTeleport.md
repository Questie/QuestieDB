## Title: LFGTeleport

**Content:**
Teleports the player to or from a LFG dungeon.
`LFGTeleport(toSafety)`

**Parameters:**
- `toSafety`
  - *boolean* - false to teleport to the dungeon, true to teleport to where you were before you were teleported to the dungeon.

**Usage:**
`/run LFGTeleport(IsInLFGDungeon())`

**Example Use Case:**
This function can be used to quickly teleport in and out of a dungeon when you are in a Looking For Group (LFG) instance. For example, if you need to quickly leave the dungeon to repair your gear or restock on supplies, you can use this function to teleport out and then back in.

**Addons:**
Many popular addons like Deadly Boss Mods (DBM) and ElvUI use this function to provide quick access buttons for players to teleport in and out of LFG dungeons, enhancing the user experience by providing convenient shortcuts.