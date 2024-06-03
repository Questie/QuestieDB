## Event: PET_BATTLE_XP_CHANGED

**Title:** PET BATTLE XP CHANGED

**Content:**
Fired when a battle pet gains experience during a pet battle.
`PET_BATTLE_XP_CHANGED: owner, petIndex, xpChange`

**Payload:**
- `owner`
  - *number* - team to which the pet belongs, 1 for the player's team, 2 for the opponent.
- `petIndex`
  - *number* - pet index within the team.
- `xpChange`
  - *number* - amount of XP gained.

**Content Details:**
The PetJournal and PetBattles APIs still return the old level/experience information for the pet when this event fires.