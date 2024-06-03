## Title: UnitReaction

**Content:**
Returns the reaction of the specified unit to another unit.
`reaction = UnitReaction(unit, otherUnit)`

**Parameters:**
- `unit`
  - *string* : UnitId
- `otherUnit`
  - *string* : UnitId - The unit to compare with the first unit.

**Returns:**
- `reaction`
  - *number* - the level of the reaction of unit towards otherUnit - this is a number between 1 and 8.
    - Hated
    - Hostile
    - Unfriendly
    - Neutral
    - Friendly
    - Honored
    - Revered
    - Exalted
  - Values other than 2, 4, or 5 are only returned when the first unit is an NPC in a reputation faction and the second is you or your pet.

**Description:**
This works even with factions that aren't listed in the reputation tab of your character window or Armory profile.
When you're Horde, the reaction of Alliance reputation-faction NPCs to you and your pet is 1. The same is true of Horde NPCs if you're Alliance.
Reaction of and to a pet is the same as for its owner.
This doesn't change when a mob becomes aggressive towards a player. I had to use the negative result of API UnitIsFriend.
Does not work across continents (or zones?)! If you query UnitReaction for a raid (or party)-member across continents, it won't return the correct value (I guess it returns nil, but I have yet to confirm that). I think it only returns correct values for units that are in 'inspect-range'.
In Blizzard Code, UnitReaction is only used between the player and a Non Player Controlled target.