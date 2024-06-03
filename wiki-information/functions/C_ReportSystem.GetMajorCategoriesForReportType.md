## Title: C_ReportSystem.GetMajorCategoriesForReportType

**Content:**
Needs summary.
`majorCategories = C_ReportSystem.GetMajorCategoriesForReportType(reportType)`

**Parameters:**
- `reportType`
  - *Enum.ReportType*
    - **Value**
    - **Field**
    - **Description**
    - `0` - Chat
    - `1` - InWorld
    - `2` - ClubFinderPosting
    - `3` - ClubFinderApplicant
    - `4` - GroupFinderPosting
    - `5` - GroupFinderApplicant
    - `6` - ClubMember
    - `7` - GroupMember
    - `8` - Friend
    - `9` - Pet
    - `10` - BattlePet
    - `11` - Calendar
    - `12` - Mail
    - `13` - PvP
    - `14` - PvPScoreboard (Added in 9.2.7)
    - `15` - PvPGroupMember (Added in 10.0.5)

**Returns:**
- `majorCategories`
  - *Enum.ReportMajorCategory*
    - **Value**
    - **Field**
    - **Description**
    - `0` - InappropriateCommunication
    - `1` - GameplaySabotage
    - `2` - Cheating
    - `3` - InappropriateName