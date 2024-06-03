## Title: C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory

**Content:**
Needs summary.
`minorCategories = C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory(reportType, majorCategory)`

**Parameters:**
- `reportType`
  - *Enum.ReportType*
    - `Value`
    - `Field`
    - `Description`
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
- `majorCategory`
  - *Enum.ReportMajorCategory*
    - `Value`
    - `Field`
    - `Description`
    - `0` - InappropriateCommunication
    - `1` - GameplaySabotage
    - `2` - Cheating
    - `3` - InappropriateName

**Returns:**
- `minorCategories`
  - *Enum.ReportMinorCategory*
    - `Value`
    - `Field`
    - `Description`
    - `0x1` - TextChat
    - `0x2` - Boosting
    - `0x4` - Spam
    - `0x8` - Afk
    - `0x10` - IntentionallyFeeding
    - `0x20` - BlockingProgress
    - `0x40` - Hacking
    - `0x80` - Botting
    - `0x100` - Advertisement
    - `0x200` - BTag
    - `0x400` - GroupName
    - `0x800` - CharacterName
    - `0x1000` - GuildName
    - `0x2000` - Description
    - `0x4000` - Name