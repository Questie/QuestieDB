## Title: DeclineGroup

**Content:**
Declines an invitation to a group.
`DeclineGroup()`

**Usage:**
The following snippet auto-declines invitations from characters whose names contain Ghost.
```lua
local frame = CreateFrame("FRAME")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:SetScript("OnEvent", function(self, event, sender)
    if sender:match("Ghost") then
        DeclineGroup()
    end
end)
```

**Description:**
You can use this after receiving the `PARTY_INVITE_REQUEST` event. If there is no invitation to a party, this function doesn't do anything.
Calling this function does NOT cause the "accept/decline dialog" to go away. Use `StaticPopup_Hide("PARTY_INVITE")` to hide the dialog.
Depending on the order events are dispatched in, your event handler may run before UIParent's, and therefore attempt to hide the dialog before it is shown. Delaying the attempt to hide the popup until `PARTY_MEMBERS_CHANGED` resolves this.