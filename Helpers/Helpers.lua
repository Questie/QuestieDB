---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@type Database
local Database = LibQuestieDB.Database

-- Event registration
-- Usage:
-- Register   an event: ReturnedObject["EVENT_NAME"] = func
-- Unregister an event: ReturnedObject["EVENT_NAME"] = nil
---@return table<string, function>
function LibQuestieDB.EventRegistrator()
  ---@type table<string, function>
  local RegisteredEvents = {}
  local function OnEvent(_, event, ...)
    RegisteredEvents[event](...)
  end

  -- Create the event frame and register the OnEvent handler
  local eventFrame = Database.CreateFrame("Frame")
  eventFrame:SetScript("OnEvent", OnEvent)

  ---@type table<string, function>
  return setmetatable({}, {
    __index = function(_, event)
      return RegisteredEvents[event]
    end,
    __newindex = function(_, event, func)
      if RegisteredEvents[event] and func == nil then
        print("Unregistering", event)
        eventFrame:UnregisterEvent(event)
        RegisteredEvents[event] = nil
      else
        print("Registering", event)
        eventFrame:RegisterEvent(event)
        RegisteredEvents[event] = func
      end
    end,
  })
end

--- Return a string with the first letter capitalized
---@param str string
---@return string
function LibQuestieDB.Capitalized(str)
  local lower = str:lower()
  local capitalized = lower:gsub("^%l", string.upper)
  return capitalized
end

--- Creates a read-only table that throws an error when trying to modify it
---@return table
function LibQuestieDB.CreateReadOnlyEmptyTable()
  return setmetatable({}, {
    __newindex = function()
      error("Attempt to modify read-only table")
    end,
  })
end

--- Colorize a string with a color code
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@param ... string
function LibQuestieDB.ColorizePrint(color, ...)
  assert(type(color) == "string", "Color must be a string")

  local c;

  if color == "red" then
    c = "|cFFff0000";
  elseif color == "gray" then
    c = "|cFFa6a6a6";
  elseif color == "purple" then
    c = "|cFFB900FF";
  elseif color == "blue" then
    c = "|cB900FFFF";
  elseif color == "lightBlue" then
    c = "|cB900FFFF";
  elseif color == "reputationBlue" then
    c = "|cFF8080ff";
  elseif color == "yellow" then
    c = "|cFFffff00";
  elseif color == "orange" then
    c = "|cFFFF6F22";
  elseif color == "green" then
    c = "|cFF00ff00";
  elseif color == "white" then
    c = "|cFFffffff";
  elseif color == "gold" then
    c = "|cFFffd100" -- this is the default game color
  elseif not c then
    c = "|cFF" .. color
  end

  print(c, ...)
end
