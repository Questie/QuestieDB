------------------------------------------------------
--   ____                  _   _      _____  ____
--  / __ \                | | (_)    |  __ \|  _ \
-- | |  | |_   _  ___  ___| |_ _  ___| |  | | |_) |
-- | |  | | | | |/ _ \/ __| __| |/ _ \ |  | |  _ <
-- | |__| | |_| |  __/\__ \ |_| |  __/ |__| | |_) |
--  \___\_\\__,_|\___||___/\__|_|\___|_____/|____/
------------------------------------------------------



---* See file Library.lua for API *---



------------------------------------------------------
---@class LibQuestieDB
local LibQuestieDB = select(2, ...)
--- Imports
local Npc = LibQuestieDB.Npc
local Object = LibQuestieDB.Object
local Quest = LibQuestieDB.Quest
local Item = LibQuestieDB.Item

--- We give it 0.2 seconds to allow other code to run first
C_Timer.After(0.2, function()
  -- Starts the addon
  LibQuestieDB.Database.Init()
end)

-- Register slash command
SlashCmdList["QuestieDB"] = function(args)
  if args == "test" then
    print("Running tests")
    local success, error = pcall(Npc.testGetFunctions, true)
    if not success then
      print("Npc test failed: " .. error)
      print("Last tested NPC: " .. tostring(Npc.lastTestedID))
      print("Last tested Npc function: " .. tostring(Npc.lastTestedData))
    end
    success, error = pcall(Object.testGetFunctions, true)
    if not success then
      print("Object test failed: " .. error)
      print("Last tested Object: " .. tostring(Object.lastTestedID))
      print("Last tested Object function: " .. tostring(Object.lastTestedData))
    end
    success, error = pcall(Quest.testGetFunctions, true)
    if not success then
      print("Quest test failed: " .. error)
      print("Last tested Quest: " .. tostring(Quest.lastTestedID))
      print("Last tested Quest function: " .. tostring(Quest.lastTestedData))
    end
    success, error = pcall(Item.testGetFunctions, true)
    if not success then
      print("Item test failed: " .. error)
      print("Last tested Item: " .. tostring(Item.lastTestedID))
      print("Last tested Item function: " .. tostring(Item.lastTestedData))
    end
  elseif args == "t" then
    local floor = math.floor
    debugprofilestart()
    for i = 1, 1000000 do
      ---@diagnostic disable-next-line: unused-local
      local mid = floor((i + (i+0.5)) / 2)
    end
    local time1 = debugprofilestop()
    debugprofilestart()
    for i = 1, 1000000 do
      local mid = (i + (i + 0.5)) / 2
      mid = mid - mid % 1
    end
    local time2 = debugprofilestop()
    -- Validate
    for i = 1, 1000000 do
      local mid = floor((i + (i+0.5)) / 2)
      local mid2 = (i + (i + 0.5)) / 2
      mid2 = mid2 - mid2 % 1
      if mid ~= mid2 then
        print("Error")
        print(mid, mid2)
        break
      end
    end
    print("Floor Test Done and validated.")
    print("Localized math.floor", time1, "ms")
    print("Modulus to floor", time2, "ms")
  end
end
SLASH_QuestieDB1 = "/QuestieDB"
SLASH_QuestieDB2 = "/qdb"
