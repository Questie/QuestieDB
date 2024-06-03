## Title: GetChannelName

**Content:**
Returns info for a chat channel.
`id, name, instanceID, isCommunitiesChannel = GetChannelName(name)`

**Parameters:**
- `name`
  - *string|number* - name of the channel to query, e.g. "Trade - City", or a channel ID to query, e.g. 1 for the chat channel currently addressable using /1.

**Returns:**
- `id`
  - *number* - The ID of the channel, or 0 if the channel is not found.
- `name`
  - *string* - The name of the channel, e.g. "Trade - Stormwind", or nil if the player is not in the queried channel.
- `instanceID`
  - *number* - Index used to deduplicate channels. Usually zero, unless two channels with the same name exist.
- `isCommunitiesChannel`
  - *boolean* - True if this is a Blizzard Communities channel, false if not.

**Description:**
Note that querying `GetChannelName("Trade - City")` may return values which appear to be valid even while the player is not in a city. Consider using `GetChannelName((GetChannelName("Trade - City"))) > 0` to check whether you really have access to the Trade channel.