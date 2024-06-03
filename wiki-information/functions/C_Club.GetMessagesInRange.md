## Title: C_Club.GetMessagesInRange

**Content:**
Get downloaded messages in the given range.
`messages = C_Club.GetMessagesInRange(clubId, streamId, oldest, newest)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `oldest`
  - *ClubMessageIdentifier*
- `newest`
  - *ClubMessageIdentifier*

**ClubMessageIdentifier Fields:**
- `epoch`
  - *number* - number of microseconds since the UNIX epoch
- `position`
  - *number* - sort order for messages at the same time

**Returns:**
- `messages`
  - *ClubMessageInfo*

**ClubMessageInfo Fields:**
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

**ClubMessageIdentifier Fields:**
- `epoch`
  - *number* - number of microseconds since the UNIX epoch
- `position`
  - *number* - sort order for messages at the same time

**ClubMemberInfo Fields:**
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

**Enum.ClubRoleIdentifier Values:**
- `1`
  - *Owner*
- `2`
  - *Leader*
- `3`
  - *Moderator*
- `4`
  - *Member*

**Enum.ClubMemberPresence Values:**
- `0`
  - *Unknown*
- `1`
  - *Online*
- `2`
  - *OnlineMobile*
- `3`
  - *Offline*
- `4`
  - *Away*
- `5`
  - *Busy*

**Enum.ClubType Values:**
- `0`
  - *BattleNet*
- `1`
  - *Character*
- `2`
  - *Guild*
- `3`
  - *Other*

**Description:**
The messages are filtered by ignored players.

**Usage:**
Prints all guild messages from start to end. Only tested with a small guild.
```lua
local club = C_Club.GetGuildClubId()
local streams = C_Club.GetStreams(club)
local guildStream = streams.streamId
local ranges = C_Club.GetMessageRanges(club, guildStream)
local oldest, newest = ranges.oldestMessageId, ranges.newestMessageId
local messages = C_Club.GetMessagesInRange(club, guildStream, oldest, newest)
for _, v in pairs(messages) do
    local timestamp = date("%Y-%m-%d %H:%M:%S", v.messageId.epoch/1e6)
    print(format("%s %s: |cffdda0dd%s|r", timestamp, v.author.name, v.content))
end
```