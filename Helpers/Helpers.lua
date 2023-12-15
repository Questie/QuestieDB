---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

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
  local eventFrame = CreateFrame("Frame")
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

--- Colorize a string with a color code
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@param ... string
function LibQuestieDB.ColorizePrint(color, ...)
  local c = "|cFF" .. color;

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
    c = "|cFFffd100"     -- this is the default game font
  end

  print(c, ...)
end
