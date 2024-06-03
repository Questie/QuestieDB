## Title: C_Club.GetStreams

**Content:**
Needs summary.
`streams = C_Club.GetStreams(clubId)`

**Parameters:**
- `clubId`
  - *string*

**Returns:**
- `streams`
  - *structure* - ClubStreamInfo
    - `ClubStreamInfo`
      - `Field`
      - `Type`
      - `Description`
      - `streamId`
        - *string*
      - `name`
        - *string*
      - `subject`
        - *string*
      - `leadersAndModeratorsOnly`
        - *boolean*
      - `streamType`
        - *Enum.ClubStreamType*
      - `creationTime`
        - *number*

    - `Enum.ClubStreamType`
      - `Value`
      - `Field`
      - `Description`
      - `0`
        - General
      - `1`
        - Guild
      - `2`
        - Officer
      - `3`
        - Other

**Usage:**
Prints the streams/channels for your guild.
```lua
local club = C_Club.GetGuildClubId()
local streams = C_Club.GetStreams(club)
for _, v in pairs(streams) do
    print(v.streamId, v.name)
end
-- 1, "Guild"
-- 2, "Officer"
```

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