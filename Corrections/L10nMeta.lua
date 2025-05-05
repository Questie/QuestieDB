---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class L10nMeta
---@field magicalSpecialCharacter "‡"
local L10nMeta = {}

-- Add L10nMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.L10nMeta = L10nMeta

-- This is a special character used to split stringdata
L10nMeta.magicalSpecialCharacter = "‡"

---@class L10nLocales
L10nMeta.locales = {
  -- "enUS", -- [1]
  "ptBR", -- [2]
  "ruRU", -- [3]
  "deDE", -- [4]
  "koKR", -- [5]
  "esES", -- [6]
  "esMX", -- [7]
  "frFR", -- [8]
  "zhCN", -- [9]
  "zhTW", -- [10]
  -- "itIT", -- [11] -- This does not work, as Questie today does not support itIT
}


---@class L10nDBKeys @ Contains name of data as keys and their index as value
L10nMeta.l10nKeys = {
  ['item'] = 1,
  ['npc'] = 2,
  ['object'] = 3,
  ['quest'] = 4,
}

--- Contains the name of data as keys and their index as value for quick lookup
L10nMeta.NameIndexLookupTable = {}
for key, index in pairs(L10nMeta.l10nKeys) do
  L10nMeta.NameIndexLookupTable[index] = key
  L10nMeta.NameIndexLookupTable[key] = index
end

-- Contains the type of data as keys and their index as value
L10nMeta.l10nTypes = {
  ['item'] = "string",
  ['npc'] = "string",
  ['object'] = "string",
  ['quest'] = "string",
}
-- Add the index keys to l10nTypes
for key, index in pairs(L10nMeta.l10nKeys) do
  L10nMeta.l10nTypes[index] = L10nMeta.l10nTypes[key]
end

L10nMeta.dumpFuncs = {
  ['item'] = DumpFunctions.dump,
  ['npc'] = DumpFunctions.dump,
  ['object'] = DumpFunctions.dump,
  ['quest'] = DumpFunctions.dump,
}

do
  local tInsert = table.insert
  local f = string.format
  local indent = string.rep
  local function anyValue(table)
    for _, v in pairs(table) do
      if v ~= nil and v ~= "" then
        return true
      end
    end
    return false
  end

  ---@param index integer
  ---@param skipIndex table<integer>? If this is set, the index will be skipped in the output
  local function shouldSkip(index, skipIndex)
    if skipIndex then
      for _, skip in ipairs(skipIndex) do
        if index == skip then
          return true
        end
      end
    end
    return false
  end

  ---@param entityType string Will write the entitytype in a comment, not used for anything else (e.g., "Item", "Npc", "Object", "Quest")
  ---@param val table<string>|string !IMPORTANT! always insert empty strings instead of nils
  ---@param skipIndex table<integer>? If this is set, the index will be skipped in the output
  ---@return string The string that will be inserted into the database
  local function dumpl10n(entityType, val, skipIndex)
    local indentation = "  "
    local capitalizedEntityType = entityType:sub(1, 1):upper() .. entityType:sub(2)

    -- String handling
    if type(val) == "string" and val ~= "" then
      -- If the values are a string, just return it
      return f("%s-- %s\n%s'%s',\n", indentation, capitalizedEntityType, indentation, val)
    end

    -- Table handling
    local lines = {}
    if type(val) == "table" and anyValue(val) then
      tInsert(lines, f("%s{ -- %s\n", indentation, capitalizedEntityType))
      for i = 1, #val do
        local value = val[i]
        if value ~= nil and value ~= "" and not shouldSkip(i, skipIndex) then
          -- Escape single quotes in the joined string
          tInsert(lines, f("%s'%s',\n", indent(indentation, 2), value))
        else
          -- If the joined string is nil, add a placeholder
          tInsert(lines, f("%snil,\n", indent(indentation, 2)))
        end
      end
      tInsert(lines, f("%s},\n", indentation))
    else
      -- If data for this entity type doesn't exist for this ID, add nil placeholder
      tInsert(lines, f("%snil,\n", indentation))
    end
    return table.concat(lines)
  end
  -- These dump funcs are used for the l10nData.lua-table
  L10nMeta.lua_tableDumpFuncs = {
    ['item'] = function(val)
      return dumpl10n("item", val)
    end,
    ['npc'] = function(val)
      return dumpl10n("npc", val)
    end,
    ['object'] = function(val)
      return dumpl10n("object", val)
    end,
    ['quest'] = function(val)
      -- ? Here we skip the questText as it is not used in Questie
      -- ? Just remove the { 2, } from the table to enable again.
      return dumpl10n("quest", val, { 2, })
    end,
  }
end
