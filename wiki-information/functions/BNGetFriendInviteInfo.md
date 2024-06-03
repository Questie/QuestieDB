## Title: BNGetFriendInviteInfo

**Content:**
Returns info for a Battle.net friend invite.
`inviteID, accountName, isBattleTag, message, sentTime = BNGetFriendInviteInfo(inviteIndex)`

**Parameters:**
- `inviteIndex`
  - *number* - Ranging from 1 to BNGetNumFriendInvites()

**Returns:**
- `inviteID`
  - *number* - Also known as the presence id.
- `accountName`
  - *number* - Protected string for the friend account name, e.g. "|Kq4|k".
- `isBattleTag`
  - *boolean*
- `message`
  - *string?* - Appears to be always nil now.
- `sentTime`
  - *number* - The unix time when the invite was sent/received.