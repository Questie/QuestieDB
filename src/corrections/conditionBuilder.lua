-- src/corrections/conditionBuilder.lua
--
-- Builds Quest Condition expressions in correction files, so the expression is checked when the
-- file loads and flavor enums resolve like any other correction value:
--
--   local C = QuestieLoader:ImportModule("ConditionBuilder")
--   [questKeys.conditions] = C.All(C.IsTeam("Alliance"), C.Not(C.QuestRewarded(1518))),
--
-- Each call returns the canonical expression string that src/conditions.lua evaluates, here
-- `IsTeam("Alliance") and not QuestRewarded(1518)`. Unknown functions, wrong argument types,
-- and strings not produced by the builder raise an error instead of evaluating permissively.

local _, LibQuestieDB = ...

local builder = {}

local FACTION_TAGS = { Alliance = true, Horde = true, Neutral = true }

local function isInteger(value)
  return type(value) == "number" and value % 1 == 0 and value > -math.huge and value < math.huge
end

-- Argument kinds; a trailing `?` in the vocabulary marks an optional argument.
local ARGUMENTS = {
  id = function(value) return isInteger(value) and value > 0 end,
  count = function(value) return isInteger(value) and value > 0 end,
  mask = function(value) return isInteger(value) and value >= 0 end,
  rank = function(value) return isInteger(value) and value >= 0 and value <= 7 end,
  level = function(value) return isInteger(value) and value > 0 end,
  integer = isInteger,
  tag = function(value) return FACTION_TAGS[value] == true end,
}

--- Every condition function and its arguments. src/conditions.lua implements exactly these.
builder.vocabulary = {
  QuestRewarded = { "id" }, QuestInLog = { "id" }, QuestComplete = { "id" }, QuestNone = { "id" },
  QuestAvailable = { "id" },
  HasAura = { "id" }, HasItem = { "id", "count?" }, HasItemOrBank = { "id", "count?" },
  HasItemEquipped = { "id" },
  HasSkill = { "id", "level?" }, KnowsSpell = { "id" },
  HasRep = { "id", "rank" }, RepBelow = { "id", "rank" },
  IsTeam = { "tag" }, IsRace = { "mask" }, IsClass = { "mask" }, IsRaceClass = { "mask", "mask" },
  IsLevel = { "level" }, IsLevelExact = { "level" }, IsLevelBelow = { "level" },
  HasAchievement = { "id" },
  EventActive = { "id" }, HolidayActive = { "id" }, WorldState = { "id", "integer" },
}

-- Expressions this builder produced, and whether each needs parentheses inside `and`/`or`.
local compound = {}

local function format(value)
  if type(value) == "string" then return ("%q"):format(value) end
  -- %d truncates above 32 bits on some clients; race masks reach bit 33.
  return ("%.0f"):format(value)
end

for name, arguments in pairs(builder.vocabulary) do
  builder[name] = function(...)
    local count = select("#", ...)
    local parts = {}
    for index, kind in ipairs(arguments) do
      local value = select(index, ...)
      local optional = kind:sub(-1) == "?"
      kind = optional and kind:sub(1, -2) or kind
      if value == nil and optional then break end
      if not ARGUMENTS[kind](value) then
        error(("%s argument %d must be a valid %s, got %s"):format(name, index, kind, tostring(value)), 2)
      end
      parts[index] = format(value)
    end
    if count > #arguments then
      error(("%s takes at most %d arguments, got %d"):format(name, #arguments, count), 2)
    end
    local expression = name .. "(" .. table.concat(parts, ", ") .. ")"
    compound[expression] = false
    return expression
  end
end

local function operand(name, value, index)
  if compound[value] == nil then
    error(("%s argument %d must be a condition from this builder, got %s"):format(name, index, tostring(value)), 3)
  end
  return compound[value] and "(" .. value .. ")" or value
end

local function join(name, operator, ...)
  local count = select("#", ...)
  if count < 2 then error(name .. " needs at least two conditions", 3) end
  local parts = {}
  for index = 1, count do parts[index] = operand(name, select(index, ...), index) end
  local expression = table.concat(parts, " " .. operator .. " ")
  compound[expression] = true
  return expression
end

---Every condition holds.
---@param ... string Conditions from this builder.
---@return string expression
function builder.All(...) return join("All", "and", ...) end

---At least one condition holds.
---@param ... string Conditions from this builder.
---@return string expression
function builder.Any(...) return join("Any", "or", ...) end

---The condition does not hold.
---@param condition string A condition from this builder.
---@return string expression
function builder.Not(condition)
  local expression = "not " .. operand("Not", condition, 1)
  compound[expression] = false
  return expression
end

LibQuestieDB.ConditionBuilder = builder

return builder
