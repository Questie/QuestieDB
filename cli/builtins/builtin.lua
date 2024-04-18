-- no need to yield in the cli (TODO: maybe find a less hacky fix)
coroutine.yield = _EmptyDummyFunction

mod = function(a, b)
  return a % b
end

hooksecurefunc = _EmptyDummyFunction

---[Documentation](https://warcraft.wiki.gg/wiki/API_GetAddOnInfo)
GetAddOnInfo = function()
  -- return "QuestieDB", "QuestieDB", "desc", true, "INSECURE", false
  return CLI_addonName or "QuestieDB", CLI_addonName or "QuestieDB", "desc", true, "INSECURE", false
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_GetAddOnMetadata)
GetAddOnMetadata = function()
  return "1"
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_GetTime)
GetTime = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  return os.time(os.date("!*t")) - 1616930000 -- convert unix time to wow time (actually accurate)
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_IsAddOnLoaded)
IsAddOnLoaded = function() return false, true end

---[Documentation](https://warcraft.wiki.gg/wiki/API_UnitFactionGroup)
UnitFactionGroup = function()
  return arg[1] or "Horde"
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_UnitClass)
UnitClass = function()
  return "Druid", "DRUID", 11
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_UnitLevel)
UnitLevel = function()
  return 60
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_GetLocale)
GetLocale = function()
  return "enUS"
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_GetQuestGreenRange)
GetQuestGreenRange = function()
  return 10
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_UnitName)
UnitName = function()
  return "Reebookie"
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
---[Documentation](https://warcraft.wiki.gg/wiki/API_debugprofilestart)
function debugprofilestart()
  startTime = os.clock()
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_debugprofilestop)
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
