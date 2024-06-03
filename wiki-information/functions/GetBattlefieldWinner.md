## Title: GetBattlefieldWinner

**Content:**
Returns the winner of the battlefield.
`winner = GetBattlefieldWinner()`

**Returns:**
- `winner`
  - *number* - Faction/team that has won the battlefield. Results are: 
    - `nil` if nobody has won
    - `0` for Horde
    - `1` for Alliance
    - `255` for a draw in a battleground
    - `0` for Green Team and `1` for Yellow in an arena

**Description:**
Gets the winner of the battleground that the player is currently in.