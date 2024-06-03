## Title: RollOnLoot

**Content:**
Rolls or passes on loot.
`RollOnLoot(rollID)`

**Parameters:**
- `rollID`
  - *number* - The number increases with every roll you have in a party. Maximum value is unknown.
- `rollType`
  - *number?* - 0 or nil to pass, 1 to roll Need, 2 to roll Greed, or 3 to roll Disenchant.

**Usage:**
The code snippet below will display a message when you roll or pass on a roll. This could easily be changed to record how many times you roll on loot.
```lua
hooksecurefunc("RollOnLoot", function(rollID, rollType)
  if (rollType and rollType > 0) then
    DEFAULT_CHAT_FRAME:AddMessage("You rolled on the item with id: " .. rollID );
  else
    DEFAULT_CHAT_FRAME:AddMessage("You passed on the item with id: " .. rollID );
  end
end)
```

**Example Use Case:**
This function can be used in addons that manage loot distribution in parties or raids. For instance, an addon could track the number of times a player rolls Need, Greed, or Disenchant on items to provide statistics or enforce loot rules.

**Addons Using This Function:**
- **LootMaster:** This addon uses `RollOnLoot` to manage and automate loot distribution in raids, ensuring fair distribution based on predefined rules.
- **EPGP Lootmaster:** Utilizes `RollOnLoot` to integrate with the EPGP (Effort Points/Gear Points) system, allowing players to roll on loot while keeping track of their points.