## Title: SetChannelPassword

**Content:**
Changes the password of the current channel.
`SetChannelPassword(channelName, password)`

**Parameters:**
- `channelName`
  - *string* - The name of the channel.
- `password`
  - *any* - The password to assign to the channel.

**Usage:**
```lua
SetChannelPassword("Sembiance", "secretpassword");
```

**Example Use Case:**
This function can be used in a scenario where you are managing a private chat channel and need to update its password for security reasons. For instance, if you are running a guild event and want to ensure only authorized members can join the channel, you can change the password periodically.

**Addons:**
Large addons like "Prat" (a popular chat enhancement addon) might use this function to provide users with the ability to manage their chat channels more effectively, including setting and changing passwords for private channels.