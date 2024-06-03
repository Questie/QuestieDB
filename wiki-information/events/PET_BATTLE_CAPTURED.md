## Event: PET_BATTLE_CAPTURED

**Title:** PET BATTLE CAPTURED

**Content:**
Fired when a pet battle ends, if the player successfully captured a battle pet.
`PET_BATTLE_CAPTURED: owner, petIndex`

**Payload:**
- `owner`
  - *number*
- `petIndex`
  - *number*

**Content Details:**
This event does not fire when a trap successfully snares a pet during a battle. This event is meant to signify when a player snares a pet, wins the battle, and is able to add the pet to their Pet Journal.