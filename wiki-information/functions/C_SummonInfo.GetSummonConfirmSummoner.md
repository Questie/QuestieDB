## Title: C_SummonInfo.GetSummonConfirmSummoner

**Content:**
Returns the name of the player summoning you.
`summoner = C_SummonInfo.GetSummonConfirmSummoner()`

**Returns:**
- `summoner`
  - *string?* - name of the player summoning you, or nil if no summon is currently pending.

**Description:**
The function returns correct results after the `CONFIRM_SUMMON` event.