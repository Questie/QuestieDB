coroutine.yield = _EmptyDummyFunction -- no need to yield in the cli (TODO: maybe find a less hacky fix)
mod = function(a, b)
  return a % b
end
hooksecurefunc = _EmptyDummyFunction
GetAddOnInfo = function()
  -- return "QuestieDB", "QuestieDB", "desc", true, "INSECURE", false
  return CLI_addonName or "QuestieDB", CLI_addonName or "QuestieDB", "desc", true, "INSECURE", false
end
GetAddOnMetadata = function()
  return "1"
end
GetTime = function()
  return os.time(os.date("!*t")) - 1616930000 -- convert unix time to wow time (actually accurate)
end
IsAddOnLoaded = function() return false, true end
UnitFactionGroup = function()
  return arg[1] or "Horde"
end
UnitClass = function()
  return "Druid", "DRUID", 11
end
UnitLevel = function()
  return 60
end
GetLocale = function()
  return "enUS"
end
GetQuestGreenRange = function()
  return 10
end
UnitName = function()
  return "QuestieNPC"
end

---@diagnostic disable-next-line: lowercase-global
wipe = function(t)
  for k in pairs(t) do
    t[k] = nil
  end
  return t
end

function Round(value)
  if value < 0.0 then
    return math.ceil(value - .5);
  end
  return math.floor(value + .5);
end

local startTime = os.clock()
function debugprofilestart()
  startTime = os.clock()
end

function debugprofilestop()
  return (os.clock() - startTime) * 1000
end

---@param delimiter string
---@param str string
---@param pieces? number
---@return string[] chunks
function strsplittable(delimiter, str, pieces)
  local t = {}
  local i = 1
  for s in string.gmatch(str, "([^" .. delimiter .. "]+)") do
    t[i] = s
    i = i + 1
    if pieces and i > pieces then
      break
    end
  end
  return t
end
