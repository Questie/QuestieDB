## Title: C_GossipInfo.GetOptions

**Content:**
Returns the available gossip options at a quest giver.
`info = C_GossipInfo.GetOptions()`

**Returns:**
- `info`
  - *GossipOptionUIInfo*
    - `Field`
    - `Type`
    - `Description`
    - `gossipOptionID`
      - *number?* - This can be nil to avoid automation
    - `name`
      - *string* - Text of the gossip item
    - `icon`
      - *number : fileID* - Icon of the gossip type
    - `rewards`
      - *GossipOptionRewardInfo*
    - `status`
      - *Enum.GossipOptionStatus*
    - `spellID`
      - *number?*
    - `flags`
      - *number*
    - `overrideIconID`
      - *number? : fileID*
    - `selectOptionWhenOnlyOption`
      - *boolean*
    - `orderIndex`
      - *number*

- `GossipOptionRewardInfo`
  - `Field`
  - `Type`
  - `Description`
  - `id`
    - *number*
  - `quantity`
    - *number*
  - `rewardType`
    - *Enum.GossipOptionRewardType*

- `Enum.GossipOptionRewardType`
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - *Item*
  - `1`
    - *Currency*

- `Enum.GossipOptionStatus`
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - *Available*
  - `1`
    - *Unavailable*
  - `2`
    - *Locked*
  - `3`
    - *AlreadyComplete*

**Description:**
Related Events:
- `GOSSIP_SHOW`

Related API:
- `C_GossipInfo.SelectOption`
- `C_GossipInfo.SelectOptionByIndex`
- `C_GossipInfo.SelectActiveQuest`
- `C_GossipInfo.SelectAvailableQuest`

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