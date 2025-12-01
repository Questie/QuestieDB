---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@type Database
local Database = LibQuestieDB.Database

-- This is used because during testing we might check how print it outputting
-- We need something that no other addon uses.
LibQuestieDB.ErrorPrint = print

-- Event registration
-- Usage:<br>
-- Register   an event: ReturnedObject["EVENT_NAME"] = func<br>
-- Unregister an event: ReturnedObject["EVENT_NAME"] = nil<br>
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
        -- print("Unregistering", event)
        eventFrame:UnregisterEvent(event)
        RegisteredEvents[event] = nil
      else
        -- print("Registering", event)
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

---Get the color code for a given color name
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@return string
function LibQuestieDB.GetColorCode(color)
  if color == "red" then
    return "|cFFff0000"
  elseif color == "gray" then
    return "|cFFa6a6a6"
  elseif color == "purple" then
    return "|cFFB900FF"
  elseif color == "blue" then
    return "|cB900FFFF"
  elseif color == "lightBlue" then
    return "|cB900FFFF"
  elseif color == "reputationBlue" then
    return "|cFF8080ff"
  elseif color == "yellow" then
    return "|cFFffff00"
  elseif color == "orange" then
    return "|cFFFF6F22"
  elseif color == "green" then
    return "|cFF00ff00"
  elseif color == "white" then
    return "|cFFffffff"
  elseif color == "gold" then
    return "|cFFffd100"
  else
    return "|cFF" .. color
  end
end

---Colorize text with a specified color for UI display
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@param text string
---@return string
function LibQuestieDB.ColorizeText(color, text)
  assert(type(color) == "string", "Color must be a string")
  assert(type(text) == "string", "Text must be a string")
  if Is_CLI then
    return text -- CLI does not support these color codes
  end

  local c = LibQuestieDB.GetColorCode(color)
  if not Is_CLI then
    return c .. text .. "|r"
  else
    return c .. text
  end
end

--- Colorize a string with a color code
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@param ... string
function LibQuestieDB.ColorizePrint(color, ...)
  assert(type(color) == "string", "Color must be a string")

  local c = LibQuestieDB.GetColorCode(color)

  if not Is_CLI then
    print(c, ..., "|r")
  else
    print(c, ...)
  end
end
