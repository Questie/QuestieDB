## Title: C_UserFeedback.SubmitBug

**Content:**
Replaces `GMSubmitBug`.
`success = C_UserFeedback.SubmitBug(bugInfo)`

**Parameters:**
- `bugInfo`
  - *string*
- `suppressNotification`
  - *boolean?* = false

**Returns:**
- `success`
  - *boolean*

**Example Usage:**
```lua
local bugInfo = "There is a bug with the quest 'A Threat Within'. The NPC does not spawn."
local success = C_UserFeedback.SubmitBug(bugInfo, true)
if success then
    print("Bug report submitted successfully.")
else
    print("Failed to submit bug report.")
end
```

**Description:**
This function is used to submit a bug report directly to Blizzard's bug tracking system. It replaces the older `GMSubmitBug` function. The `suppressNotification` parameter is optional and defaults to `false`. When set to `true`, it suppresses the notification that usually appears after submitting a bug report.

**Change Log:**
Patch 8.0.1 (2018-07-17): Added.