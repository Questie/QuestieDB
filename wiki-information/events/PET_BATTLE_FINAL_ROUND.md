## Event: PET_BATTLE_FINAL_ROUND

**Title:** PET BATTLE FINAL ROUND

**Content:**
Fired at the end of the final round of a pet battle.
`PET_BATTLE_FINAL_ROUND: owner`

**Payload:**
- `owner`
  - *number* - Team index of the team that won the pet battle; 1 for the player's team, 2 for the opponent.

**Content Details:**
This event is followed by HP recovery/XP gain notifications, and eventually PET_BATTLE_OVER and PET_BATTLE_CLOSE.