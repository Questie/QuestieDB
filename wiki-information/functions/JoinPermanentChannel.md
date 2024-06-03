## Title: JoinPermanentChannel

**Content:**
Joins the specified chat channel; the channel will be rejoined after relogging.
Joins the channel with the specified name. A player can be in a maximum of 10 chat channels. In contrast to `API_JoinTemporaryChannel`, the channel will be re-joined after relogging.
`type, name = JoinPermanentChannel(channelName)`

**Parameters:**
- `channelName`
  - *string* - The name of the channel to join. You can't use the "-" character in `channelName` (patch 1.9).
- `password`
  - *string?* - The channel password, nil if none.
- `frameID`
  - *number?* - The chat frame ID number to add the channel to. Use `Frame:GetID()` to retrieve it for chat frame objects.
- `hasVoice`
  - *number?* - (1/nil) Enable voice chat for this channel.

**Returns:**
- `type`
  - *number* - The type of channel. 0 for an undefined channel, 1 for the zone General channel, etc.
- `name`
  - *string* - The name of the channel (seems to be nil for most channels).

**Usage:**
```lua
JoinPermanentChannel("Mammoth", "thesane", ChatFrame1:GetID(), 1);
```

**Example Use Case:**
This function can be used to join a custom chat channel that you want to persist across game sessions. For instance, a guild might use a specific channel for officer communications that they want to automatically rejoin every time they log in.

**Addons Using This API:**
Many chat-related addons, such as Prat and Chatter, use this API to manage custom chat channels and ensure users are automatically rejoined to important channels after relogging.