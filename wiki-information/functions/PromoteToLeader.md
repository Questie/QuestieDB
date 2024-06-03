## Title: PromoteToLeader

**Content:**
Promotes a unit to group leader.
`PromoteToLeader(unitId or playerName)`

**Parameters:**
- `unitId`
  - *UnitId* - The unit to promote.
- `playername`
  - *PlayerName* - The full name of the player to promote.

**Usage:**
If you have a character named "Character", to promote him to leader you can type in-game:
```lua
/script PromoteToLeader("Character");
```

**Example Use Case:**
This function is particularly useful in raid or party management addons where leadership roles need to be dynamically assigned based on certain conditions or user inputs. For instance, an addon that automates raid management might use this function to promote a designated raid leader when the raid is formed.

**Addons Using This Function:**
- **ElvUI**: A comprehensive UI replacement addon that includes raid management features. It might use `PromoteToLeader` to facilitate quick leadership changes during raids.
- **DBM (Deadly Boss Mods)**: A popular addon for raid encounters that could use this function to promote a player to leader for better coordination during boss fights.