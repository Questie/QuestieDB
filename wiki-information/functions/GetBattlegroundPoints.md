## Title: GetBattlegroundPoints

**Content:**
Returns battleground points earned by a team.
`currentPoints, maxPoints = GetBattlegroundPoints(team)`

**Parameters:**
- `team`
  - *number* - team to query the points of; 0 for Horde, 1 for Alliance.

**Returns:**
- `currentPoints`
  - *number* - current battleground points earned by the team.
- `maxPoints`
  - *number* - maximum amount of battleground points the team can earn.

**Description:**
As of 5.3, both return values are always 0; FrameXML comments in WorldStateFrame.lua state:
Long-term we'd like the battleground objectives to work more like this, but it's not working for 5.3.