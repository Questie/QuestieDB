-- generator/facts.lua
--
-- Checks entity-fact fields (ADR 0017) on corrected data before anything is stored.
--
-- These fields hold enum IDs that only mean something through `Enum.serviceKeys` and friends.
-- A misspelled constant in a Correction evaluates to nil and silently shortens the list, and an
-- unknown number would ship as a service no consumer recognises, so Generation stops instead.

local constants = dofile("src/corrections/enum/constants.lua")

local facts = {}

---@param enum table<string, integer> Named constants.
---@return table<integer, string> names Value -> name.
local function invert(enum)
  local names = {}
  for name, value in pairs(enum) do names[value] = name end
  return names
end

local serviceNames = invert(constants.serviceKeys)

--- A list must be a gapless array of known IDs with no repeats. `pairs` rather than `ipairs`,
--- so a hole left by a nil constant is seen instead of ending the walk early.
---@param list any
---@param known table<integer, string>
---@return string? problem
local function listProblem(list, known)
  if type(list) ~= "table" then return "is not a list" end
  local count, seen = 0, {}
  for index, value in pairs(list) do
    if type(index) ~= "number" or index < 1 or index % 1 ~= 0 then
      return "has a non-array key " .. tostring(index)
    end
    if not known[value] then return "holds unknown ID " .. tostring(value) end
    if seen[value] then return "repeats " .. known[value] end
    seen[value] = true
    count = count + 1
  end
  if count ~= #list then return "has a gap, usually a misspelled constant" end
  return nil
end

--- Collect every fact-field problem in the loaded, corrected entity data.
---@param loaded table entityTypeName -> { meta, entities }
---@return string[] problems Sorted, one line per offending field.
function facts.problems(loaded)
  local problems = {}
  for typeName, entry in pairs(loaded) do
    local keys = entry.meta.keys
    local services, requiredFaction = keys.services, keys.requiredFaction
    if services or requiredFaction then
      for id, row in pairs(entry.entities) do
        if type(id) == "number" and type(row) == "table" then
          local list = services and row[services]
          if list ~= nil then
            local problem = listProblem(list, serviceNames)
            if problem then
              problems[#problems + 1] = ("%s %d: services %s"):format(typeName, id, problem)
            end
          end
          local faction = requiredFaction and row[requiredFaction]
          if faction ~= nil and faction ~= "A" and faction ~= "H" then
            problems[#problems + 1] = ("%s %d: requiredFaction must be \"A\" or \"H\", got %s")
              :format(typeName, id, tostring(faction))
          end
        end
      end
    end
  end
  table.sort(problems)
  return problems
end

--- Stop Generation when a fact field is malformed.
---@param loaded table entityTypeName -> { meta, entities }
function facts.assertValid(loaded)
  local problems = facts.problems(loaded)
  if #problems == 0 then return end
  local shown = {}
  for index = 1, math.min(#problems, 20) do shown[index] = "  " .. problems[index] end
  error(("Entity fact fields are malformed (%d problems):\n%s"):format(#problems, table.concat(shown, "\n")), 0)
end

return facts
