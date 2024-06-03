## Title: GetItemCooldown

**Content:**
Returns cooldown info for an item ID.
`startTime, duration, enable = GetItemCooldown(itemInfo)`

**Parameters:**
- `itemInfo`
  - *number|string* : Item ID, Link or Name

**Returns:**
- `startTime`
  - *number* - The time when the cooldown started (as returned by GetTime()) or zero if no cooldown.
- `duration`
  - *number* - The number of seconds the cooldown will last, or zero if no cooldown.
- `enable`
  - *number* - 1 if the item is ready or on cooldown, 0 if the item is used, but the cooldown didn't start yet (e.g. potion in combat).

**Description:**
As of patch 4.0.1, you can no longer use this function to return the Cooldown of an item link or name, you MUST pass in the itemID.
If you need the original behavior, here is a function that simulates that function...

```lua
function GetItemCooldown_Orig(searchItemLink)
    local bagID = 1;
    local bagName = GetBagName(bagID);
    local searchItemName = GetItemInfo(searchItemLink);
    if (searchItemName == nil) then return nil end
    while (bagName ~= nil) do
        local slots = GetContainerNumSlots(bagID);
        for slot = 1, slots, 1 do
            local _, _, _, _, _, _, itemLink = GetContainerItemInfo(bagID, slot);
            if (itemLink ~= nil) then
                local startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slot);
                if (startTime ~= nil and startTime > 0 and itemLink ~= nil) then
                    if (searchItemName == itemName) then
                        return startTime, duration, isEnabled;
                    end
                end
            end
        end
        -- Restart While Loop
        bagID = bagID + 1;
        bagName = GetBagName(bagID);
    end
    return nil;
end
```

**Example Usage:**
This function can be used to check the cooldown of a specific item in your inventory, such as a health potion or a trinket, to determine if it is ready to be used again.

**Addons:**
Many large addons, such as WeakAuras and OmniCC, use this function to track item cooldowns and display them to the player. WeakAuras, for example, can create custom visual and audio alerts when an item comes off cooldown, while OmniCC overlays cooldown numbers directly on item icons.