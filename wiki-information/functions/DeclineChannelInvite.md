## Title: DeclineChannelInvite

**Content:**
Declines an invitation to join a specific chat channel.
`DeclineChannelInvite(channel)`

**Parameters:**
- `channel`
  - *string* - name of the channel the player was invited to but does not wish to join.

**Description:**
`CHANNEL_INVITE_REQUEST` fires when the player has been invited to a chat channel.
There is no equivalent Accept function; FrameXML merely calls `JoinPermanentChannel` when the invitation is accepted.