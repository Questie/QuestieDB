## Title: C_Club.GetInfoFromLastCommunityChatLine

**Content:**
Needs summary.
`messageInfo, clubId, streamId, clubType = C_Club.GetInfoFromLastCommunityChatLine()`

**Returns:**
- `messageInfo`
  - *structure* - ClubMessageInfo
- `clubId`
  - *string*
- `streamId`
  - *string*
- `clubType`
  - *Enum.ClubType*

**ClubMessageInfo:**
- `Field`
- `Type`
- `Description`
- `messageId`
  - *ClubMessageIdentifier*
- `content`
  - *string* - Protected string
- `author`
  - *ClubMemberInfo*
- `destroyer`
  - *ClubMemberInfo?* - May be nil even if the message has been destroyed
- `destroyed`
  - *boolean*
- `edited`
  - *boolean*

**ClubMessageIdentifier:**
- `Field`
- `Type`
- `Description`
- `epoch`
  - *number* - number of microseconds since the UNIX epoch
- `position`
  - *number* - sort order for messages at the same time

**ClubMemberInfo:**
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