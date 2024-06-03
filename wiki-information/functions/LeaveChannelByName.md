## Title: LeaveChannelByName

**Content:**
Leaves the channel with the specified name.
`LeaveChannelByName(channelName)`

**Parameters:**
- `channelName`
  - *string* - The name of the channel to leave.

**Usage:**
```lua
LeaveChannelByName("Trade");
```

**Example Use Case:**
This function can be used in an addon or script to programmatically leave a specific chat channel, such as the Trade channel, which can be useful for reducing chat spam or focusing on other channels.

**Addons Using This Function:**
Many chat management addons, such as Prat or Chatter, may use this function to allow users to customize their chat experience by automatically leaving certain channels based on user preferences.