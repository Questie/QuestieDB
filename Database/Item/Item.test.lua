local _,
---@class QuestieSDB
QuestieSDB = ...

local tInsert = table.insert
Item.testGetFunctions = function(fast)
  debugprofilestart()
  local glob = Item.glob
  local count = 0
  for id in pairs(glob) do
    Item.lastTestedID = id
    count = count + 1
    local data = {}
    tInsert(data, "Testing Item " .. id)

    -- Test Item.name
    tInsert(data, "Name: " .. (Item.name(id) or "nil"))

    -- Test Item.npcDrops
    local npcDrops = Item.npcDrops(id)
    if npcDrops then
      tInsert(data, "NPC Drops:")
      for _, npcID in ipairs(npcDrops) do
        tInsert(data, "  NPC ID: " .. npcID)
      end
    else
      tInsert(data, "NPC Drops: nil")
    end

    -- Test Item.objectDrops
    local objectDrops = Item.objectDrops(id)
    if objectDrops then
      tInsert(data, "Object Drops:")
      for _, objectID in ipairs(objectDrops) do
        tInsert(data, "  Object ID: " .. objectID)
      end
    else
      tInsert(data, "Object Drops: nil")
    end

    -- Test Item.itemDrops
    local itemDrops = Item.itemDrops(id)
    if itemDrops then
      tInsert(data, "Item Drops:")
      for _, itemID in ipairs(itemDrops) do
        tInsert(data, "  Item ID: " .. itemID)
      end
    else
      tInsert(data, "Item Drops: nil")
    end

    -- Test Item.startQuest
    tInsert(data, "Start Quest: " .. (Item.startQuest(id) or "nil"))

    -- Test Item.questRewards
    local questRewards = Item.questRewards(id)
    if questRewards then
      tInsert(data, "Quest Rewards:")
      for _, questID in ipairs(questRewards) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Rewards: nil")
    end

    -- Test Item.flags
    tInsert(data, "Flags: " .. (Item.flags(id) or "nil"))

    -- Test Item.foodType
    tInsert(data, "Food Type: " .. (Item.foodType(id) or "nil"))

    -- Test Item.itemLevel
    tInsert(data, "Item Level: " .. (Item.itemLevel(id) or "nil"))

    -- Test Item.requiredLevel
    tInsert(data, "Required Level: " .. (Item.requiredLevel(id) or "nil"))

    -- Test Item.ammoType
    tInsert(data, "Ammo Type: " .. (Item.ammoType(id) or "nil"))

    -- Test Item.class
    tInsert(data, "Class: " .. (Item.class(id) or "nil"))

    -- Test Item.subClass
    tInsert(data, "Subclass: " .. (Item.subClass(id) or "nil"))

    -- Test Item.vendors
    local vendors = Item.vendors(id)
    if vendors then
      tInsert(data, "Vendors:")
      for _, npcID in ipairs(vendors) do
        tInsert(data, "  NPC ID: " .. npcID)
      end
    else
      tInsert(data, "Vendors: nil")
    end

    -- Test Item.relatedQuests
    local relatedQuests = Item.relatedQuests(id)
    if relatedQuests then
      tInsert(data, "Related Quests:")
      for _, questID in ipairs(relatedQuests) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Related Quests: nil")
    end

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end
  local time = debugprofilestop()
  QuestieSDB.ColorizePrint("green", "Item Test Done", time, "ms")
  print("  ", count, "items tested")
  print("  ", "time per item:", time / count, "ms")
  print("  ", "avg time per function", time / (count * 15), "ms")
end
