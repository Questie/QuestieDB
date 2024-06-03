## Event: CHANNEL_COUNT_UPDATE

**Title:** CHANNEL COUNT UPDATE

**Content:**
Fired when number of players in a channel changes but only if this channel is visible in ChannelFrame (it mustn't be hidden by a collapsed category header).
`CHANNEL_COUNT_UPDATE: displayIndex, count`

**Payload:**
- `displayIndex`
  - *number* - channel id (item number in Blizzards ChannelFrame. See also `GetChannelDisplayInfo`
- `count`
  - *number* - number of players in channel