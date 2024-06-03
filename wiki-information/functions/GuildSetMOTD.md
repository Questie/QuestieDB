## Title: GuildSetMOTD

**Content:**
Sets the guild message of the day.
`GuildSetMOTD(message)`

**Parameters:**
- `message` : *String* - The message to set - the message is limited to 127 characters (English client - I did not test this on other clients).

**Example Usage:**
```lua
-- Set the guild message of the day to "Welcome to the guild!"
GuildSetMOTD("Welcome to the guild!")
```

**Additional Information:**
This function is commonly used in guild management addons to automate or simplify the process of updating the guild message of the day. For example, an addon might use this function to set a daily tip or announcement for guild members.