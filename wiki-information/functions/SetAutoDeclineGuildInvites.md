## Title: SetAutoDeclineGuildInvites

**Content:**
Sets whether guild invites should be automatically declined.
`SetAutoDeclineGuildInvites(decline)`

**Parameters:**
- `decline`
  - *boolean* - True if guild invitations should be automatically declined, false if invitations should be shown to the user.

**Reference:**
- `DISABLE_DECLINE_GUILD_INVITE`, if guild invitations will now be shown to the user
- `ENABLE_DECLINE_GUILD_INVITE`, if guild invitations will now be declined automatically

See also:
- `GetAutoDeclineGuildInvites`

**Description:**
Blizzard's code always passes in a string value, but the function accepts both strings and numbers, just like `SetCVar`, and its counterpart `GetAutoDeclineGuildInvites` returns numeric values, just like `GetCVar`.