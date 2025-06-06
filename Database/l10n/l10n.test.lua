---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class l10n
---@field RunGetTest fun(fast: boolean)
---@field package testItemGetFunctions fun(fast: boolean)
---@field package testNpcGetFunctions fun(fast: boolean)
---@field package testObjectGetFunctions fun(fast: boolean)
---@field package testQuestGetFunctions fun(fast: boolean)
---@field package lastTestedID Id
---@field package lastTestedData string
local l10n = LibQuestieDB.l10n

local item = LibQuestieDB.Item
local npc = LibQuestieDB.Npc
local object = LibQuestieDB.Object
local quest = LibQuestieDB.Quest

l10n.RunGetTestAllLocales = function(fast)
  for _, locale in ipairs(LibQuestieDB.Meta.L10nMeta.locales) do
    LibQuestieDB.ColorizePrint("yellow", "Testing l10n for locale: " .. locale)
    l10n.SetLocale(locale)
    l10n.RunGetTest(fast)
  end
  l10n.SetLocale(GetLocale())
end

l10n.RunGetTest = function(fast)
  do
    local success, err = pcall(l10n.testItemGetFunctions, fast)
    if not success then
      print("l10n Item test failed: " .. err)
      print("Last tested ItemId l10n: " .. tostring(l10n.lastTestedID))
      print("Last tested Item l10n function: " .. tostring(l10n.lastTestedData))
      error("l10n Item test failed: " .. err)
    end
  end

  do
    local success, err = pcall(l10n.testNpcGetFunctions, fast)
    if not success then
      print("l10n Npc test failed: " .. err)
      print("Last tested NpcId l10n: " .. tostring(l10n.lastTestedID))
      print("Last tested Npc l10n function: " .. tostring(l10n.lastTestedData))
      error("l10n Npc test failed: " .. err)
    end
  end

  do
    local success, err = pcall(l10n.testObjectGetFunctions, fast)
    if not success then
      print("l10n Object test failed: " .. err)
      print("Last tested ObjectId l10n: " .. tostring(l10n.lastTestedID))
      print("Last tested Object l10n function: " .. tostring(l10n.lastTestedData))
      error("l10n Object test failed: " .. err)
    end
  end

  do
    local success, err = pcall(l10n.testQuestGetFunctions, fast)
    if not success then
      print("l10n Quest test failed: " .. err)
      print("Last tested QuestId l10n: " .. tostring(l10n.lastTestedID))
      print("Last tested Quest l10n function: " .. tostring(l10n.lastTestedData))
      error("l10n Quest test failed: " .. err)
    end
  end
end

local tInsert = table.insert
l10n.testItemGetFunctions = function(fast)
  debugprofilestart()
  local functions = 1
  local count = 0
  for id in pairs(item.GetAllIds()) do
    l10n.lastTestedID = id
    l10n.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing l10n item " .. id)

    -- Test item.name
    l10n.lastTestedData = "name"
    tInsert(data, "Name: " .. (item.name(id) or "nil"))


    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "l10n item Test Done", time, "ms")
  print("  ", count, "l10n items tested")
  print("  ", "time per l10n:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end

l10n.testNpcGetFunctions = function(fast)
  debugprofilestart()
  local functions = 2
  local count = 0
  for id in pairs(npc.GetAllIds()) do
    l10n.lastTestedID = id
    l10n.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing l10n npc " .. id)

    -- Test npc.name
    l10n.lastTestedData = "name"
    tInsert(data, "Name: " .. (l10n.npcName(id) or "nil"))

    -- Test npc.subname
    l10n.lastTestedData = "subname"
    tInsert(data, "Subname: " .. (l10n.npcSubName(id) or "nil"))


    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "l10n npc Test Done", time, "ms")
  print("  ", count, "l10n npcs tested")
  print("  ", "time per l10n:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end

l10n.testObjectGetFunctions = function(fast)
  debugprofilestart()
  local functions = 1
  local count = 0
  for id in pairs(object.GetAllIds()) do
    l10n.lastTestedID = id
    l10n.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing l10n object " .. id)

    -- Test object.name
    l10n.lastTestedData = "name"
    tInsert(data, "Name: " .. (l10n.objectName(id) or "nil"))


    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "l10n object Test Done", time, "ms")
  print("  ", count, "l10n objects tested")
  print("  ", "time per l10n:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end

l10n.testQuestGetFunctions = function(fast)
  debugprofilestart()
  local functions = 3
  local count = 0
  for id in pairs(quest.GetAllIds()) do
    l10n.lastTestedID = id
    l10n.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing l10n quest " .. id)

    -- Test quest.name
    l10n.lastTestedData = "name"
    tInsert(data, "Name: " .. (l10n.questName(id) or "nil"))

    -- Test quest.description
    l10n.lastTestedData = "description"
    local description = l10n.questDescription(id)
    if description then
      tInsert(data, "Description:")
      for _, desc in ipairs(description) do
        tInsert(data, "  " .. desc)
      end
    else
      tInsert(data, "Description: nil")
    end

    -- Test quest.objectivesText
    l10n.lastTestedData = "objectivesText"
    local objectivesText = l10n.questObjectivesText(id)
    if objectivesText then
      tInsert(data, "Objectives Text:")
      for _, obj in ipairs(objectivesText) do
        tInsert(data, "  " .. obj)
      end
    else
      tInsert(data, "Objectives Text: nil")
    end


    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "l10n quest Test Done", time, "ms")
  print("  ", count, "l10n quests tested")
  print("  ", "time per l10n:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
