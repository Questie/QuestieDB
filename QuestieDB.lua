------------------------------------------------------
--   ____                  _   _      _____  ____
--  / __ \                | | (_)    |  __ \|  _ \
-- | |  | |_   _  ___  ___| |_ _  ___| |  | | |_) |
-- | |  | | | | |/ _ \/ __| __| |/ _ \ |  | |  _ <
-- | |__| | |_| |  __/\__ \ |_| |  __/ |__| | |_) |
--  \___\_\\__,_|\___||___/\__|_|\___|_____/|____/
------------------------------------------------------


--*  |||||||||||||||||||||||||||||| *--
---* See file Library.lua for API *---
--*  |||||||||||||||||||||||||||||| *--


------------------------------------------------------
--- The main private namespace for QuestieDB
---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--! Global variable for debugging
--! Only available when debug mode is enabled
_GLibQuestieDB = nil


--- Imports
local Npc = LibQuestieDB.Npc
local Object = LibQuestieDB.Object
local Quest = LibQuestieDB.Quest
local Item = LibQuestieDB.Item
local l10n = LibQuestieDB.l10n


-- Event registration
LibQuestieDB.RegisteredEvents = LibQuestieDB.EventRegistrator()

--! Start the addon
--* Initialize the database
do
  ---@type FunctionContainer
  local timer
  local function bucketLoaded()
    --? We give it 0.2 seconds to allow other code to run first
    --? We listen to the ADDON_LOADED event to allow all other addons to load first
    --? As we are a library, we need to wait for the other addons to load allowing them to register
    --? overrides and similar things
    C_Timer.After(0.2, function()
      if Database.debugEnabled then
        print("All Addons loaded")
        LibQuestieDB.ColorizePrint("lightBlue", "QuestieDB: Debug mode enabled")
        _GLibQuestieDB = LibQuestieDB
      end
      -- Starts the addon
      LibQuestieDB.Database.Init()
    end)
    LibQuestieDB.RegisteredEvents["ADDON_LOADED"] = nil
  end
  LibQuestieDB.RegisteredEvents["ADDON_LOADED"] = function(addonName)
    if timer then
      timer:Cancel()
    end
    timer = C_Timer.NewTimer(1, bucketLoaded)
  end
end


-- Register slash command
SlashCmdList["QuestieDB"] = function(args)
  if args == "ui" then
    local category = LibQuestieDB.QuestieDBSettings.category
    Settings.OpenToCategory(category.ID)
    return
  elseif args == "test" then
    LibQuestieDB.ColorizePrint("yellow", "Running data tests")
    if LibQuestieDB.Database.debugEnabled then
      LibQuestieDB.ColorizePrint("yellow", "Running l10n tests (deDE)")
      LibQuestieDB.ColorizePrint("orange", "The first test initializes frames so it take more time than other functions")
      l10n.SetLocale("deDE")
      l10n.RunGetTest(true)
      l10n.SetLocale(GetLocale())
    else
      LibQuestieDB.ColorizePrint("red", "l10n tests skipped (debug mode not enabled)")
      LibQuestieDB.ColorizePrint("red", "Please enable debug otherwise the l10n tests can't run properly")
    end
    Npc.RunGetTest(true)
    Object.RunGetTest(true)
    Quest.RunGetTest(true)
    Item.RunGetTest(true)
    LibQuestieDB.ColorizePrint("yellow", "--- Testing Done ---")
  elseif args == "t" then
    local floor = math.floor
    debugprofilestart()
    for i = 1, 1000000 do
      ---@diagnostic disable-next-line: unused-local
      local mid = floor((i + (i + 0.5)) / 2)
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
      local mid = floor((i + (i + 0.5)) / 2)
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
  collectgarbage()
end

SLASH_QuestieDB1 = "/QuestieDB"
SLASH_QuestieDB2 = "/qdb"
