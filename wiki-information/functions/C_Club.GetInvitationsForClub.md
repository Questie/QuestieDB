## Title: C_Club.GetInvitationsForClub

**Content:**
Needs summary.
`invitations = C_Club.GetInvitationsForClub(clubId)`

**Parameters:**
- `clubId`
  - *string*

**Returns:**
- `invitations`
  - *structure* - ClubInvitationInfo
    - `Field`
    - `Type`
    - `Description`
    - `invitationId`
      - *string*
    - `isMyInvitation`
      - *boolean*
    - `invitee`
      - *structure* ClubMemberInfo
        - `ClubMemberInfo`
          - `Field`
          - `Type`
          - `Description`
          - `isSelf`
            - *boolean*
          - `memberId`
            - *number*
          - `name`
            - *string?* - name may be encoded as a Kstring
          - `role`
            - *Enum.ClubRoleIdentifier?*
          - `presence`
            - *Enum.ClubMemberPresence*
          - `clubType`
            - *Enum.ClubType?*
          - `guid`
            - *string?*
          - `bnetAccountId`
            - *number?*
          - `memberNote`
            - *string?*
          - `officerNote`
            - *string?*
          - `classID`
            - *number?*
          - `race`
            - *number?*
          - `level`
            - *number?*
          - `zone`
            - *string?*
          - `achievementPoints`
            - *number?*
          - `profession1ID`
            - *number?*
          - `profession1Rank`
            - *number?*
          - `profession1Name`
            - *string?*
          - `profession2ID`
            - *number?*
          - `profession2Rank`
            - *number?*
          - `profession2Name`
            - *string?*
          - `lastOnlineYear`
            - *number?*
          - `lastOnlineMonth`
            - *number?*
          - `lastOnlineDay`
            - *number?*
          - `lastOnlineHour`
            - *number?*
          - `guildRank`
            - *string?*
          - `guildRankOrder`
            - *number?*
          - `isRemoteChat`
            - *boolean?*
          - `overallDungeonScore`
            - *number?* - Added in 9.1.0
          - `faction`
            - *Enum.PvPFaction?* - Added in 9.2.5

**Enum.ClubRoleIdentifier:**
- `Value`
- `Field`
- `Description`
  - `1`
    - Owner
  - `2`
    - Leader
  - `3`
    - Moderator
  - `4`
    - Member

**Enum.ClubMemberPresence:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Unknown
  - `1`
    - Online
  - `2`
    - OnlineMobile
  - `3`
    - Offline
  - `4`
    - Away
  - `5`
    - Busy

**Enum.ClubType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - BattleNet
  - `1`
    - Character
  - `2`
    - Guild
  - `3`
    - Other

**Description:**
Get the pending invitations for this club. Call `RequestInvitationsForClub()` to retrieve invitations from the server.