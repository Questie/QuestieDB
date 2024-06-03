## Title: C_GossipInfo.SelectOption

**Content:**
Selects a gossip (conversation) option.
`C_GossipInfo.SelectOption(optionID)`

**Parameters:**
- `optionID`
  - *number* - gossipOptionID from `C_GossipInfo.GetOptions()`
- `text`
  - *string?*
- `confirmed`
  - *boolean?*

**Usage:**
Prints gossip options and automatically selects the vendor gossip when e.g. at an innkeeper.
```lua
local function OnEvent(self, event)
    local info = C_GossipInfo.GetOptions()
    for i, v in pairs(info) do
        print(i, v.icon, v.name, v.gossipOptionID)
        if v.icon == 132060 then -- interface/gossipframe/vendorgossipicon.blp
            print("Selecting vendor gossip option.")
            C_GossipInfo.SelectOption(v.gossipOptionID)
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("GOSSIP_SHOW")
f:SetScript("OnEvent", OnEvent)
```

**Reference:**
UI SelectGossipOption - This is an API for players and addon authors to continue to be able to select by index rather than ID.