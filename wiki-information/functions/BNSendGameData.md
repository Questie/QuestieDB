## Title: BNSendGameData

**Content:**
Sends an addon comm message to a Battle.net friend.
`BNSendGameData(presenceID, addonPrefix, message)`

**Parameters:**
- `presenceID`
  - *number* - A unique numeric identifier for the friend during this session. -- get it with `BNGetFriendInfo()`
- `addonPrefix`
  - *string* - <=16 bytes, cannot include a colon
- `message`
  - *string* - <=4078 bytes

On receive, will trigger event `BN_CHAT_MSG_ADDON` with arguments `addonPrefix`, `message`, `"WHISPER"`, `senderPresenceID`.

**Reference:**
- `BNSendWhisper(presenceID, message)`
- `BN_CHAT_MSG_ADDON`

**References:**
- [Battle.net Forum](http://us.battle.net/wow/en/forum/topic/11437004031)