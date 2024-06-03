## Title: C_ReportSystem.OpenReportPlayerDialog

**Content:**
Opens the dialog for reporting a player.
`C_ReportSystem.OpenReportPlayerDialog(reportType, playerName)`

**Parameters:**
- `reportType`
  - *string* - One of the strings found in PLAYER_REPORT_TYPE
- `playerName`
  - *string* - Name of the player being reported
- `playerLocation`
  - *PlayerLocationMixin*

**PLAYER_REPORT_TYPE Constants:**
- `PLAYER_REPORT_TYPE`
  - *Constant* - *Value*
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

**Description:**
This function is not protected and therefore available to Addons, unlike `C_ReportSystem.InitiateReportPlayer` and `C_ReportSystem.SendReportPlayer`.
This reporting restriction was added because AddOn BadBoy allegedly sent out a number of false positives.
Triggers `OPEN_REPORT_PLAYER` once the window is open.

**Usage:**
Opens the spam report dialog for the current target.
```lua
/run C_ReportSystem.OpenReportPlayerDialog(PLAYER_REPORT_TYPE_SPAM, UnitName("target"), PlayerLocation:CreateFromUnit("target"))
```