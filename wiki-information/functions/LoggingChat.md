## Title: LoggingChat

**Content:**
Gets or sets whether logging chat to `Logs\WoWChatLog.txt` is enabled.
`isLogging = LoggingChat()`

**Parameters:**
- `newState`
  - *boolean* - toggles chat logging

**Returns:**
- `isLogging`
  - *boolean* - current state of logging

**Usage:**
```lua
if (LoggingChat()) then
  print("Chat is already being logged")
else
  print("Chat is not being logged - starting it!")
  LoggingChat(1)
  print("Chat is now being logged to Logs\\WOWChatLog.txt")
end
```

**Example Use Case:**
This function can be used in an addon to ensure that chat logs are being recorded for later review or debugging purposes. For instance, a guild management addon might use this to log all guild chat for administrative review.

**Addons Using This Function:**
While specific large addons using this function are not well-documented, any addon that requires chat logging for analysis or record-keeping, such as raid logging tools or guild management addons, might utilize this function to ensure chat is being logged.