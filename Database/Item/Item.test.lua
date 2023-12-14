---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class Item
local Item = LibQuestieDB.Item

local tInsert = table.insert
Item.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 16
  local count = 0
  for id in pairs(Item.GetAllItemIds()) do
    Item.lastTestedID = id
    Item.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing Item " .. id)

    -- Test Item.name
    Item.lastTestedData = "name"
    tInsert(data, "Name: " .. (Item.name(id) or "nil"))

    -- Test Item.npcDrops
    Item.lastTestedData = "npcDrops"
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
    Item.lastTestedData = "objectDrops"
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
    Item.lastTestedData = "itemDrops"
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
    Item.lastTestedData = "startQuest"
    tInsert(data, "Start Quest: " .. (Item.startQuest(id) or "nil"))

    -- Test Item.questRewards
    Item.lastTestedData = "questRewards"
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
    Item.lastTestedData = "flags"
    tInsert(data, "Flags: " .. (Item.flags(id) or "nil"))

    -- Test Item.foodType
    Item.lastTestedData = "foodType"
    tInsert(data, "Food Type: " .. (Item.foodType(id) or "nil"))

    -- Test Item.itemLevel
    Item.lastTestedData = "itemLevel"
    tInsert(data, "Item Level: " .. (Item.itemLevel(id) or "nil"))

    -- Test Item.requiredLevel
    Item.lastTestedData = "requiredLevel"
    tInsert(data, "Required Level: " .. (Item.requiredLevel(id) or "nil"))

    -- Test Item.ammoType
    Item.lastTestedData = "ammoType"
    tInsert(data, "Ammo Type: " .. (Item.ammoType(id) or "nil"))

    -- Test Item.class
    Item.lastTestedData = "class"
    tInsert(data, "Class: " .. (Item.class(id) or "nil"))

    -- Test Item.subClass
    Item.lastTestedData = "subClass"
    tInsert(data, "Subclass: " .. (Item.subClass(id) or "nil"))

    -- Test Item.vendors
    Item.lastTestedData = "vendors"
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
    Item.lastTestedData = "relatedQuests"
    local relatedQuests = Item.relatedQuests(id)
    if relatedQuests then
      tInsert(data, "Related Quests:")
      for _, questID in ipairs(relatedQuests) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Related Quests: nil")
    end

    -- Test Item.teachesSpell
    Item.lastTestedData = "teachesSpell"
    tInsert(data, "TeachesSpell: " .. (Item.teachesSpell(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end
  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "Item Test Done", time, "ms")
  print("  ", count, "items tested")
  print("  ", "time per item:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
