---@class LibQuestieDB
---@field Corrections Corrections
local LibQuestieDB = select(2, ...)

---@class Corrections
local Corrections = LibQuestieDB.Corrections

--- Imports
Database = LibQuestieDB.Database

-- Localized functions
local f = string.format
local tSort = table.sort
local pairs = pairs
local ipairs = ipairs

--? Lists of functions returning corrections
--? 1. The static lists are meant to be used for pre-compile or debugging
--? 2. The dynamic lists are applied on login for faction specific corrections etc.

-- ? Item
---@type table<number, CorrectionObject> @ A list of objects returning ItemCorrections
Corrections.ItemCorrectionsStatic = {}
---@type table<number, CorrectionObject> @ A list of objects returning ItemCorrections
Corrections.ItemCorrectionsDynamic = {}

-- ? Npc
---@type table<number, CorrectionObject> @ A list of objects returning NpcCorrections
Corrections.NpcCorrectionsStatic = {}
---@type table<number, CorrectionObject>
Corrections.NpcCorrectionsDynamic = {}

-- ? Object
---@type table<number, CorrectionObject> @ A list of functions returning ObjectCorrections
Corrections.ObjectCorrectionsStatic = {}
---@type table<number, CorrectionObject> @ A list of functions returning ObjectCorrections
Corrections.ObjectCorrectionsDynamic = {}

-- ? Quest
---@type table<number, CorrectionObject> @ A list of functions returning QuestCorrections
Corrections.QuestCorrectionsStatic = {}
---@type table<number, CorrectionObject> @ A list of functions returning QuestCorrections
Corrections.QuestCorrectionsDynamic = {}

---@param datatype "item"|"npc"|"object"|"quest"
---@param name string @ Optional name for the correction functio
---@param func fun(): table<AllIdTypes, Correction[]>>
---@param loadOrder number? @ The order in which the correction should be applied
function Corrections.RegisterCorrectionDynamic(datatype, name, func, loadOrder)
  assert(datatype == "item" or datatype == "npc" or datatype == "object" or datatype == "quest", "Invalid type", datatype)
  assert(type(func) == "function", "Invalid function", func)
  assert(type(name) == "string" or type(name) == "number" or name == nil, "Invalid name", name)

  -- Capitalize datatype
  local capitalizedDatatype = LibQuestieDB.Capitalized(datatype) .. "CorrectionsDynamic"

  -- Check if loadOrder is specified
  if loadOrder ~= nil then
    -- Check if loadOrder is a number
    assert(type(loadOrder) == "number", "Invalid loadOrder", loadOrder)

    -- Check if loadOrder already exists
    -- If it does, increment until we find an empty slot
    if Corrections[capitalizedDatatype][loadOrder] then
      local oldLoadOrder = loadOrder
      while Corrections[capitalizedDatatype][loadOrder] do
        loadOrder = loadOrder + 1
      end
      LibQuestieDB.ColorizePrint("yellow", f("Warning: Order index %d already exists for corrections %s, changed to index %d.", oldLoadOrder, name, loadOrder))
    end

    -- Set correction function at specified index
    Corrections[capitalizedDatatype][loadOrder] = {
      name = name,
      func = func,
      loadOrder = loadOrder,
    }
  else
    -- Add to end by default
    local implicitLoadOrder = #Corrections[capitalizedDatatype] + 1
    Corrections[capitalizedDatatype][implicitLoadOrder] = {
      name = name,
      func = func,
      loadOrder = implicitLoadOrder,
    }
  end
end

---@param datatype "item"|"npc"|"object"|"quest" @ The type of correction
---@param name string @ Optional name for the correction functio
---@param func fun(): table<AllIdTypes, Correction[]>> @ Function returning a table of corrections (Dependency Injection-ish)
---@param loadOrder number? @ The order in which the correction should be applied
function Corrections.RegisterCorrectionStatic(datatype, name, func, loadOrder)
  assert(datatype == "item" or datatype == "npc" or datatype == "object" or datatype == "quest", "Invalid type", datatype)
  assert(type(func) == "function", "Invalid function", func)
  assert(type(name) == "string" or type(name) == "number" or name == nil, "Invalid name", name)

  -- Capitalize datatype
  local capitalizedDatatype = LibQuestieDB.Capitalized(datatype) .. "CorrectionsStatic"

  -- Check if loadOrder is specified
  if loadOrder ~= nil then
    -- Check if loadOrder is a number
    assert(type(loadOrder) == "number", "Invalid loadOrder", loadOrder)

    -- Check if loadOrder already exists
    -- If it does, increment until we find an empty slot
    if Corrections[capitalizedDatatype][loadOrder] then
      local oldLoadOrder = loadOrder
      while Corrections[capitalizedDatatype][loadOrder] do
        loadOrder = loadOrder + 1
      end
      LibQuestieDB.ColorizePrint("yellow", f("Warning: Order index %d already exists for corrections %s, changed to index %d.", oldLoadOrder, name, loadOrder))
    end

    -- Set correction function at specified index
    Corrections[capitalizedDatatype][loadOrder] = {
      name = name,
      func = func,
      loadOrder = loadOrder,
    }
  else
    -- Add to end by default
    local implicitLoadOrder = #Corrections[capitalizedDatatype] + 1
    Corrections[capitalizedDatatype][implicitLoadOrder] = {
      name = name,
      func = func,
      loadOrder = implicitLoadOrder,
    }
  end
end

do
  local staticDynamicLoadOrder = { "static", "dynamic", }
  --- Returns a list of corrections for the given type, keyed by Name or Index, useful for getting a specific correction
  ---@param type "item"|"npc"|"object"|"quest"
  ---@param includeStatic boolean @ If true, the static corrections will be included
  ---@param includeDynamic boolean? @ If true, the dynamic corrections will be included
  ---@return {static: table<number, CorrectionObject>, dynamic: table<number, CorrectionObject>}
  ---@return { [1]: "static", [2]: "dynamic" } @ The load order of the corrections
  function Corrections.GetCorrections(type, includeStatic, includeDynamic)
    if includeDynamic == nil then
      includeDynamic = true
    end

    local capitalizedTypeStatic = LibQuestieDB.Capitalized(type) .. "CorrectionsStatic"
    local capitalizedTypeDynamic = LibQuestieDB.Capitalized(type) .. "CorrectionsDynamic"

    local staticCorrections
    if includeStatic and Corrections[capitalizedTypeStatic] then
      ---@param i number Load order
      ---@param correctionObject CorrectionObject
      for i, correctionObject in ipairs(Corrections.SortCorrectionsByLoadOrder(Corrections[capitalizedTypeStatic])) do
        if not staticCorrections then
          staticCorrections = {}
        end
        staticCorrections[i] = correctionObject
      end
    end

    local dynamicCorrections
    if includeDynamic and Corrections[capitalizedTypeDynamic] then
      ---@param i number Load order
      ---@param correctionObject CorrectionObject
      for i, correctionObject in ipairs(Corrections.SortCorrectionsByLoadOrder(Corrections[capitalizedTypeDynamic])) do
        if not dynamicCorrections then
          dynamicCorrections = {}
        end
        dynamicCorrections[i] = correctionObject
      end
    end
    -- TODO: How do i remove this and keep the possiblity to load new corrections?
    -- Corrections[capitalizedTypeStatic] = nil
    -- Corrections[capitalizedTypeDynamic] = nil
    return {
      dynamic = dynamicCorrections,
      static = staticCorrections,
    }, staticDynamicLoadOrder
  end

  --- A function to sort corrections by load order to work around the fact that lua tables are unordered
  ---@package
  ---@param unsortedCorrections table<number, CorrectionObject> @ Unsorted corrections, index is loadOrder which can be any number
  ---@return table<number, CorrectionObject> sortedCorrections @ Index in this table is always 1..n
  function Corrections.SortCorrectionsByLoadOrder(unsortedCorrections)
    -- Create tables to map between sparse loadOrder and dense indices
    local indexToLoadOrder = {}
    local loadOrderToIndex = {}

    -- Iterate over unsortedCorrections to build mapping
    local index = 1
    for loadOrder, correctionObject in pairs(unsortedCorrections) do
      indexToLoadOrder[index] = loadOrder
      loadOrderToIndex[loadOrder] = correctionObject
      index = index + 1
    end

    -- Sort index table to get correct order
    tSort(indexToLoadOrder)

    -- Create sorted corrections table using mapping
    local sortedCorrections = {}
    for i, loadOrder in ipairs(indexToLoadOrder) do
      sortedCorrections[i] = loadOrderToIndex[loadOrder]
    end

    return sortedCorrections
  end
end
