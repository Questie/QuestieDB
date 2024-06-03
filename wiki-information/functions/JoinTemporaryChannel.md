## Title: JoinTemporaryChannel

**Content:**
Joins the specified chat channel; the channel will be left on logout.
Joins the channel with the specified name. A player can be in a maximum of 10 chat channels. In contrast to `API_JoinPermanentChannel`, the channel will be left at logout.
`type, name = JoinTemporaryChannel(channelName)`

**Parameters:**
- `channelName`
  - *string* - The name of the channel to join. You can't use the "-" character in `channelName` (patch 1.9).
- `password`
  - *string?* - The channel password, `nil` if none.
- `frameID`
  - *number?* - The chat frame ID number to add the channel to. Use `Frame:GetID()` to retrieve it for chat frame objects.
- `hasVoice`
  - *number* - (1/nil) Enable voice chat for this channel.

**Returns:**
- `type`
  - *number* - The type of channel. 0 for an undefined channel, 1 for the zone General channel, etc.
- `name`
  - *string* - The name of the channel (seems to be `nil` for most channels).

**Usage:**
```lua
JoinTemporaryChannel("Mammoth", "thesane", ChatFrame1:GetID(), 1);
```

**Example Use Case:**
This function can be used in an addon to temporarily join a custom chat channel for event coordination or group activities. For instance, a raid leader might use this to create a temporary channel for organizing a raid without cluttering the permanent channel list.

**Addons Using This API:**
Large addons like Deadly Boss Mods (DBM) might use this function to create temporary channels for sharing raid warnings and alerts among raid members.