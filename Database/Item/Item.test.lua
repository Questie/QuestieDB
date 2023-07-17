Item.testGetFunctions = function()
  local glob = Item.glob
  for id in pairs(glob) do
    print("Testing Item " .. id)
    local data = {}

    -- Test Item.name
    table.insert(data, "Name: " .. (Item.name(id) or "nil"))

    -- Test Item.npcDrops
    local npcDrops = Item.npcDrops(id)
    if npcDrops then
      table.insert(data, "NPC Drops:")
      for _, npcID in ipairs(npcDrops) do
        table.insert(data, "  NPC ID: " .. npcID)
      end
    else
      table.insert(data, "NPC Drops: nil")
    end

    -- Test Item.objectDrops
    local objectDrops = Item.objectDrops(id)
    if objectDrops then
      table.insert(data, "Object Drops:")
      for _, objectID in ipairs(objectDrops) do
        table.insert(data, "  Object ID: " .. objectID)
      end
    else
      table.insert(data, "Object Drops: nil")
    end

    -- Test Item.itemDrops
    local itemDrops = Item.itemDrops(id)
    if itemDrops then
      table.insert(data, "Item Drops:")
      for _, itemID in ipairs(itemDrops) do
        table.insert(data, "  Item ID: " .. itemID)
      end
    else
      table.insert(data, "Item Drops: nil")
    end

    -- Test Item.startQuest
    table.insert(data, "Start Quest: " .. (Item.startQuest(id) or "nil"))

    -- Test Item.questRewards
    local questRewards = Item.questRewards(id)
    if questRewards then
      table.insert(data, "Quest Rewards:")
      for _, questID in ipairs(questRewards) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Rewards: nil")
    end

    -- Test Item.flags
    table.insert(data, "Flags: " .. (Item.flags(id) or "nil"))

    -- Test Item.foodType
    table.insert(data, "Food Type: " .. (Item.foodType(id) or "nil"))

    -- Test Item.itemLevel
    table.insert(data, "Item Level: " .. (Item.itemLevel(id) or "nil"))

    -- Test Item.requiredLevel
    table.insert(data, "Required Level: " .. (Item.requiredLevel(id) or "nil"))

    -- Test Item.ammoType
    table.insert(data, "Ammo Type: " .. (Item.ammoType(id) or "nil"))

    -- Test Item.class
    table.insert(data, "Class: " .. (Item.class(id) or "nil"))

    -- Test Item.subClass
    table.insert(data, "Subclass: " .. (Item.subClass(id) or "nil"))

    -- Test Item.vendors
    local vendors = Item.vendors(id)
    if vendors then
      table.insert(data, "Vendors:")
      for _, npcID in ipairs(vendors) do
        table.insert(data, "  NPC ID: " .. npcID)
      end
    else
      table.insert(data, "Vendors: nil")
    end

    -- Test Item.relatedQuests
    local relatedQuests = Item.relatedQuests(id)
    if relatedQuests then
      table.insert(data, "Related Quests:")
      for _, questID in ipairs(relatedQuests) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Related Quests: nil")
    end

    table.insert(data, "--------------------------------------------------")
    print(table.concat(data, "\n"))
  end
  print("Item Test Done")
end
