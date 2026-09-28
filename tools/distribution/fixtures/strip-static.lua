-- Native mixed provider fixture using the real Wotlk Object manifest declarations.
local _, LibQuestieDB = ...
local providers = {}
LibQuestieDB.CorrectionProviders.wotlkObjectFixes = providers
local objectKeys = LibQuestieDB.Meta.Object.keys
LibQuestieDB.ObjectiveFirst.objectObjectiveFirst[123] = true

---@return string
local function sharedName()
  return UnitFactionGroup("player") .. UnitClassBase("player")
end

---@return table
function providers.Load()
  return { [123] = { [objectKeys.name] = "STATIC_BODY_SENTINEL" } }
end

---@return table
function providers.LoadFactionFixes()
  local name = sharedName()
  -- STRIP_NEGATIVE_CONTROL
  return { [123] = { [objectKeys.name] = name } }
end
