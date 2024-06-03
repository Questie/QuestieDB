## Event: REPORT_PLAYER_RESULT

**Title:** REPORT PLAYER RESULT

**Content:**
Fires when attempting to report a player
`REPORT_PLAYER_RESULT: success, reportType`

**Payload:**
- `success`
  - *boolean*
- `reportType`
  - *Enum.ReportType*
  - *Value*
    - *Field*
    - *Description*
    - 0
      - Chat
    - 1
      - InWorld
    - 2
      - ClubFinderPosting
    - 3
      - ClubFinderApplicant
    - 4
      - GroupFinderPosting
    - 5
      - GroupFinderApplicant
    - 6
      - ClubMember
    - 7
      - GroupMember
    - 8
      - Friend
    - 9
      - Pet
    - 10
      - BattlePet
    - 11
      - Calendar
    - 12
      - Mail
    - 13
      - PvP
    - 14
      - PvPScoreboard
      - Added in 9.2.7
    - 15
      - PvPGroupMember
      - Added in 10.0.5