## Title: GetLootSourceInfo

**Content:**
Returns information about the source of the objects in a loot slot.
`guid, quantity, ... = GetLootSourceInfo(lootSlot)`

**Parameters:**
- `lootSlot`
  - *number* - index of the loot slot, ascending from 1 up to `GetNumLootItems()`

**Returns:**
(Variable returns: `guid1, quantity1, guid2, quantity2, ...`)
- `guid`
  - *string* - GUID of the source being looted. Can also return GameObject GUIDs for objects like ore veins and herbs, and Item GUIDs for containers like lockboxes.
- `quantity`
  - *number* - Quantity of the object being looted from this source.

**Usage:**
Prints out the source GUID and quantity of each loot source item individually.
```lua
local function OnEvent(self, event)
    for i = 1, GetNumLootItems() do
        local sources = {GetLootSourceInfo(i)}
        local _, name = GetLootSlotInfo(i)
        for j = 1, #sources, 2 do
            print(i, name, j, sources[j], sources[j+1])
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("LOOT_OPENED")
f:SetScript("OnEvent", OnEvent)
```

**Reference:**
- `GetLootSlotInfo()`