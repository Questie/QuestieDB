## Event: PET_BATTLE_CLOSE

**Title:** PET BATTLE CLOSE

**Content:**
Fired twice when the client exists a Pet Battle.
`PET_BATTLE_CLOSE`

**Payload:**
- `None`

**Content Details:**
This event fires twice at the very end of a pet battle, instructing the client to transition back to normal character controls.
The macro conditional evaluates to true during the first firing, and false during the second.