## Title: DoReadyCheck

**Content:**
Initiates a ready check.
`DoReadyCheck()`

**Description:**
This function initiates a raid ready check and will cause all raid members to receive a READY_CHECK event. Processing of the ready check results appears to be either server-side or internal to the client and does not seem to be directly available to the scripting system.

Since there's no event that emits when everyone is ready, you'll have to use `CHAT_MSG_SYSTEM` events and check if the message contains the string "Everyone is Ready", which is server-sided emitted to the player when everyone is ready in a party.

You can accomplish this by registering the event:
```lua
local frame = CreateFrame("Frame") -- Create the frame
frame:RegisterEvent("CHAT_MSG_SYSTEM") -- Register the event
frame:SetScript("OnEvent", function(self, event, msg) -- When the event fires do:
  if strfind(msg, "Everyone is Ready") then -- Check if the System Message contains the string "Everyone is Ready".
    -- Insert code for when all players are ready!
  end
end)
```

**Example Usage:**
This function is commonly used in raid management addons to ensure all members are ready before starting an encounter. For instance, the popular addon "Deadly Boss Mods" (DBM) uses ready checks to confirm that all raid members are prepared for a boss fight.