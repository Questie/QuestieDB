---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class L10nMeta
local L10nMeta = {}

-- Add L10nMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.L10nMeta = L10nMeta


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
