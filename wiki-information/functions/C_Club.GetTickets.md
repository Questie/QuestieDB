## Title: C_Club.GetTickets

**Content:**
Needs summary.
`tickets = C_Club.GetTickets(clubId)`

**Parameters:**
- `clubId`
  - *string*

**Returns:**
- `tickets`
  - *structure* - ClubTicketInfo
    - `ClubTicketInfo`
      - `Field`
      - `Type`
      - `Description`
      - `ticketId`
        - *string*
      - `allowedRedeemCount`
        - *number*
      - `currentRedeemCount`
        - *number*
      - `creationTime`
        - *number* - Creation time in microseconds since the UNIX epoch
      - `expirationTime`
        - *number* - Expiration time in microseconds since the UNIX epoch
      - `defaultStreamId`
        - *string?*
      - `creator`
        - *ClubMemberInfo*
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

**Enum.ClubRoleIdentifier**
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

**Enum.ClubMemberPresence**
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

**Enum.ClubType**
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
Get the existing tickets for this club. Call `RequestTickets()` to retrieve tickets from the server.