---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Item
---@field RunGetTest fun(fast: boolean)
---@field package testGetFunctions fun(fast: boolean)
---@field package lastTestedID ItemId
---@field package lastTestedData string
local Item = LibQuestieDB.Item

Item.RunGetTest = function(fast)
  local success, err = pcall(Item.testGetFunctions, fast)
  if not success then
    print("Item test failed: " .. err)
    print("Last tested ItemId: " .. tostring(Item.lastTestedID))
    print("Last tested Item function: " .. tostring(Item.lastTestedData))
    error("Item test failed: " .. err)
  end
end

local tInsert = table.insert
Item.testGetFunctions = function(fast)
  debugprofilestart()
  local beginTime = debugprofilestop()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Corrections.ItemMeta.itemKeys) do
    functions = functions + 1
  end

  local perFunctionPerformance = {}

  local count = 0
  for id in pairs(Item.GetAllIds()) do
    Item.lastTestedID = id
    Item.lastTestedData = ""
    count = count + 1
    local data = {}
    local time = 0
    local runTime = 0
    tInsert(data, "Testing Item " .. id)

    -- Test Item.name
    Item.lastTestedData = "name"
    time = debugprofilestop()
    tInsert(data, "Name: " .. (Item.name(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.npcDrops
    Item.lastTestedData = "npcDrops"
    time = debugprofilestop()
    local npcDrops = Item.npcDrops(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local objectDrops = Item.objectDrops(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local itemDrops = Item.itemDrops(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Start Quest: " .. (Item.startQuest(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.questRewards
    Item.lastTestedData = "questRewards"
    time = debugprofilestop()
    local questRewards = Item.questRewards(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Flags: " .. (Item.flags(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.foodType
    Item.lastTestedData = "foodType"
    time = debugprofilestop()
    tInsert(data, "Food Type: " .. (Item.foodType(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.itemLevel
    Item.lastTestedData = "itemLevel"
    time = debugprofilestop()
    tInsert(data, "Item Level: " .. (Item.itemLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.requiredLevel
    Item.lastTestedData = "requiredLevel"
    time = debugprofilestop()
    tInsert(data, "Required Level: " .. (Item.requiredLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.ammoType
    Item.lastTestedData = "ammoType"
    time = debugprofilestop()
    tInsert(data, "Ammo Type: " .. (Item.ammoType(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.class
    Item.lastTestedData = "class"
    time = debugprofilestop()
    tInsert(data, "Class: " .. (Item.class(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.subClass
    Item.lastTestedData = "subClass"
    time = debugprofilestop()
    tInsert(data, "Subclass: " .. (Item.subClass(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    -- Test Item.vendors
    Item.lastTestedData = "vendors"
    time = debugprofilestop()
    local vendors = Item.vendors(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local relatedQuests = Item.relatedQuests(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "TeachesSpell: " .. (Item.teachesSpell(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Item.lastTestedData] = (perFunctionPerformance[Item.lastTestedData] or 0) + runTime

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop() - beginTime
  LibQuestieDB.ColorizePrint("green", "Item Test Done", time, "ms")
  print("  ", count, "items tested")
  print("  ", "time per item:", tostring(time / count):sub(1, 6), "ms")
  print("  ", "avg time per function", tostring(time / (count * functions)):sub(1, 6), "ms")
  for i, functionName in ipairs(LibQuestieDB.Corrections.ItemMeta.NameIndexLookupTable) do
    local v = perFunctionPerformance[functionName] or 0
    print("    ", i, functionName, ":", tostring((v / count) * 1000):sub(1, 6), "µs")
  end
end
