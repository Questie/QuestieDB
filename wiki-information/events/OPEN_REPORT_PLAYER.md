## Event: OPEN_REPORT_PLAYER

**Title:** OPEN REPORT PLAYER

**Content:**
Fired after launching the player reporting window.
`OPEN_REPORT_PLAYER: token, reportType, playerName`

**Payload:**
- `token`
  - *number* - report Id
- `reportType`
  - *string* - One of the values in PLAYER_REPORT_TYPE⊞
  - ⊟
  - PLAYER_REPORT_TYPE
  - Constant
  - Value
  - PLAYER_REPORT_TYPE_SPAM
  - spam
  - PLAYER_REPORT_TYPE_LANGUAGE
  - language
  - PLAYER_REPORT_TYPE_ABUSE
  - abuse
  - PLAYER_REPORT_TYPE_BAD_PLAYER_NAME
  - badplayername
  - PLAYER_REPORT_TYPE_BAD_GUILD_NAME
  - badguildname
  - PLAYER_REPORT_TYPE_CHEATING
  - cheater
  - PLAYER_REPORT_TYPE_BAD_BATTLEPET_NAME
  - badbattlepetname
  - PLAYER_REPORT_TYPE_BAD_PET_NAME
  - badpetname
- `playerName`
  - *string*