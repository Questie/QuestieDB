## Title: GetChannelList

**Content:**
Returns the list of joined chat channels.
`id, name, disabled, ... = GetChannelList()`

**Returns:**
- (Variable returns: `id1, name1, disabled1, id2, name2, disabled2, ...`)
  - `id`
    - *number* - channel number
  - `name`
    - *string* - channel name
  - `disabled`
    - *boolean* - If the channel is disabled, e.g. the Trade channel when you're not in a city.

**Usage:**
Prints the channels the player is currently in.
```lua
local channels = {GetChannelList()}
for i = 1, #channels, 3 do
    local id, name, disabled = channels[i], channels[i+1], channels[i+2]
    print(id, name, disabled)
end
```