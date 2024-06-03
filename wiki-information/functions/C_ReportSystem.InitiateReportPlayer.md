## Title: C_ReportSystem.InitiateReportPlayer

**Content:**
Initiates a report against a player.
`token = C_ReportSystem.InitiateReportPlayer(complaintType)`

**Parameters:**
- `complaintType`
  - *string* : PLAYER_REPORT_TYPE - the reason for reporting.
- `playerLocation`
  - *PlayerLocationMixin*

**PLAYER_REPORT_TYPE Constants:**
- `PLAYER_REPORT_TYPE_SPAM`
  - *spam*
- `PLAYER_REPORT_TYPE_LANGUAGE`
  - *language*
- `PLAYER_REPORT_TYPE_ABUSE`
  - *abuse*
- `PLAYER_REPORT_TYPE_BAD_PLAYER_NAME`
  - *badplayername*
- `PLAYER_REPORT_TYPE_BAD_GUILD_NAME`
  - *badguildname*
- `PLAYER_REPORT_TYPE_CHEATING`
  - *cheater*
- `PLAYER_REPORT_TYPE_BAD_BATTLEPET_NAME`
  - *badbattlepetname*
- `PLAYER_REPORT_TYPE_BAD_PET_NAME`
  - *badpetname*

**Returns:**
- `token`
  - *number* - the token used for `C_ReportSystem.SendReportPlayer`.