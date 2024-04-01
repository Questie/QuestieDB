---@class LibQuestieDB
---@field Corrections Corrections
local LibQuestieDB = select(2, ...)

--- Imports
Database = LibQuestieDB.Database

---@class Corrections
local Corrections = LibQuestieDB.Corrections

--? Lists of functions returning corrections
--? 1. The static lists are meant to be used for pre-compile or debugging
--? 2. The dynamic lists are applied on login for faction specific corrections etc.
---@type table<string|number, fun():table<AllIdTypes, Correction[]>>
Corrections.ItemCorrectionsStatic = {}
---@type table<string|number, fun():table<AllIdTypes, Correction[]>>
Corrections.ItemCorrectionsDynamic = {}

---@type table<string|number, fun():table<AllIdTypes, Correction[]>> @ A list of functions returning NpcCorrections
Corrections.NpcCorrectionsStatic = {}
---@type table<string|number, fun():table<AllIdTypes, Correction[]>>
Corrections.NpcCorrectionsDynamic = {}

---@type table<string|number, fun():table<AllIdTypes, Correction[]>> @ A list of functions returning ObjectCorrections
Corrections.ObjectCorrectionsStatic = {}
---@type table<string|number, fun():table<AllIdTypes, Correction[]>>
Corrections.ObjectCorrectionsDynamic = {}

---@type table<string|number, fun():table<AllIdTypes, Correction[]>> @ A list of functions returning QuestCorrections
Corrections.QuestCorrectionsStatic = {}
---@type table<string|number, fun():table<AllIdTypes, Correction[]>>
Corrections.QuestCorrectionsDynamic = {}

---@param datatype "item"|"npc"|"object"|"quest"
---@param name string @ Optional name for the correction functio
---@param func fun(): table<AllIdTypes, Correction[]>>n
function Corrections.RegisterCorrectionDynamic(datatype, name, func)
  assert(datatype == "item" or datatype == "npc" or datatype == "object" or datatype == "quest", "Invalid type", datatype)
  assert(type(func) == "function", "Invalid function", func)
  assert(type(name) == "string" or type(name) == "number" or name == nil, "Invalid name", name)
  if datatype == "item" then
    Corrections.ItemCorrectionsDynamic[name or #Corrections.ItemCorrectionsStatic + 1] = func
  elseif datatype == "npc" then
    Corrections.NpcCorrectionsDynamic[name or #Corrections.NpcCorrectionsStatic + 1] = func
  elseif datatype == "object" then
    Corrections.ObjectCorrectionsDynamic[name or #Corrections.ObjectCorrectionsStatic + 1] = func
  elseif datatype == "quest" then
    Corrections.QuestCorrectionsDynamic[name or #Corrections.QuestCorrectionsStatic + 1] = func
  end
end

---@param datatype "item"|"npc"|"object"|"quest" @ The type of correction
---@param name string @ Optional name for the correction functio
---@param func fun(): table<AllIdTypes, Correction[]>> @ Function returning a table of corrections (Dependency Injection-ish)
function Corrections.RegisterCorrectionStatic(datatype, name, func)
  assert(datatype == "item" or datatype == "npc" or datatype == "object" or datatype == "quest", "Invalid type", datatype)
  assert(type(func) == "function", "Invalid function", func)
  assert(type(name) == "string" or type(name) == "number" or name == nil, "Invalid name", name)
  if datatype == "item" then
    Corrections.ItemCorrectionsStatic[name or #Corrections.ItemCorrectionsStatic + 1] = func
  elseif datatype == "npc" then
    Corrections.NpcCorrectionsStatic[name or #Corrections.NpcCorrectionsStatic + 1] = func
  elseif datatype == "object" then
    Corrections.ObjectCorrectionsStatic[name or #Corrections.ObjectCorrectionsStatic + 1] = func
  elseif datatype == "quest" then
    Corrections.QuestCorrectionsStatic[name or #Corrections.QuestCorrectionsStatic + 1] = func
  end
end

do
  --- Returns a list of corrections for the given type, keyed by Name or Index, useful for getting a specific correction
  ---@param type "item"|"npc"|"object"|"quest"
  ---@param includeStatic boolean @ If true, the static corrections will be included
  ---@param includeDynamic boolean? @ If true, the dynamic corrections will be included
  ---@return Correction[]
  function Corrections.GetCorrections(type, includeStatic, includeDynamic)
    if includeDynamic == nil then
      includeDynamic = true
    end
    -- It looks strange to return the static nil first, but we ALWAYS want dynamic overrides to trump static ones
    -- So we do it this way because then a pairs() would start with the static ones and then the dynamic ones
    if type == "item" then
      return {
        includeStatic and Corrections.ItemCorrectionsStatic or nil,
        includeDynamic and Corrections.ItemCorrectionsDynamic or nil,
      }
    elseif type == "npc" then
      return {
        includeStatic and Corrections.NpcCorrectionsStatic or nil,
        includeDynamic and Corrections.NpcCorrectionsDynamic or nil,
      }
    elseif type == "object" then
      return {
        includeStatic and Corrections.ObjectCorrectionsStatic or nil,
        includeDynamic and Corrections.ObjectCorrectionsDynamic or nil,
      }
    elseif type == "quest" then
      return {
        includeStatic and Corrections.QuestCorrectionsStatic or nil,
        includeDynamic and Corrections.QuestCorrectionsDynamic or nil,
      }
    elseif type == "l10n" then
      return {}
    end
    error("Invalid type")
  end
end
