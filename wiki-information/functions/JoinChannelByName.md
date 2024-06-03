## Title: JoinChannelByName

**Content:**
Joins the specified chat channel.
`type, name = JoinChannelByName(channelName)`

**Parameters:**
- `channelName`
  - *string* - The name of the channel to join. You can't use the "-" character in `channelName`.
- `password`
  - *string?* - The channel password, `nil` if none.
- `frameID`
  - *number?* - The chat frame ID number to add the channel to. Use `Frame:GetID()` to retrieve it for chat frame objects.
- `hasVoice`
  - *boolean* - Enable voice chat for this channel.

**Returns:**
- `type`
  - *number* - The type of channel. 0 for an undefined channel, 1 for the zone General channel, etc.
- `name`
  - *string?* - The name of the channel.

**Usage:**
```lua
local channel_type, channel_name = JoinChannelByName("Mammoth", "thesane", ChatFrame1:GetID(), 1);
```

**Example Use Case:**
This function can be used to programmatically join a custom chat channel in World of Warcraft. For instance, an addon could use this to automatically join a guild's custom chat channel upon login.

**Addon Usage:**
Large addons like Prat or Chatter, which enhance the chat interface, might use this function to manage custom chat channels, ensuring users are automatically joined to specific channels for better communication and coordination.