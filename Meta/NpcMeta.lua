---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------

local ZoneMeta = LibQuestieDB.Meta.ZoneMeta
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class NpcMeta
local NpcMeta = {}

-- Add NpcMeta to Meta namespace
---@class Meta
local Meta = LibQuestieDB.Meta
Meta.NpcMeta = NpcMeta

---@class NpcDBKeys @ Contains name of data as keys and their index as value
NpcMeta.npcKeys = {
  ['name'] = 1,               -- string
  ['minLevelHealth'] = 2,     -- int
  ['maxLevelHealth'] = 3,     -- int
  ['minLevel'] = 4,           -- int
  ['maxLevel'] = 5,           -- int
  ['rank'] = 6,               -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
  ['spawns'] = 7,             -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['waypoints'] = 8,          -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['zoneID'] = 9,             -- guess as to where this NPC is most common
  ['questStarts'] = 10,       -- table {questID(int),...}
  ['questEnds'] = 11,         -- table {questID(int),...}
  ['factionID'] = 12,         -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
  ['friendlyToFaction'] = 13, -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
  ['subName'] = 14,           -- string, The title or function of the NPC, e.g. "Weapon Vendor"
  ['npcFlags'] = 15,          -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
  -- For flag values see https://github.com/cmangos/mangos-classic/blob/172c005b0a69e342e908f4589b24a6f18246c95e/src/game/Entities/Unit.h#L536
}

--- Contains the name of data as keys and their index as value for quick lookup
NpcMeta.NameIndexLookupTable = {}
for key, index in pairs(NpcMeta.npcKeys) do
  NpcMeta.NameIndexLookupTable[index] = key
  NpcMeta.NameIndexLookupTable[key] = index
end

-- Contains the type of data as keys and their index as value
NpcMeta.npcTypes = {
  ['name'] = "string",
  ['minLevelHealth'] = "number",
  ['maxLevelHealth'] = "number",
  ['minLevel'] = "number",
  ['maxLevel'] = "number",
  ['rank'] = "number",
  ['spawns'] = "table",
  ['waypoints'] = "table",
  ['zoneID'] = "number",
  ['questStarts'] = "table",
  ['questEnds'] = "table",
  ['factionID'] = "number",
  ['friendlyToFaction'] = "string",
  ['subName'] = "string",
  ['npcFlags'] = "number",
}
-- Add the index keys to itemTypes
for key, index in pairs(NpcMeta.npcKeys) do
  NpcMeta.npcTypes[index] = NpcMeta.npcTypes[key]
end

----@enum NpcFlags
NpcMeta.npcFlags = (LibQuestieDB.IsTBC or LibQuestieDB.IsWotlk) and {
  NONE = 0,
  GOSSIP = 1,
  QUEST_GIVER = 2,
  TRAINER = 16,
  VENDOR = 128,
  REPAIR = 4096,
  FLIGHT_MASTER = 8192,
  SPIRIT_HEALER = 16384,
  SPIRIT_GUIDE = 32768,
  INNKEEPER = 65536,
  BANKER = 131072,
  PETITIONER = 262144,
  TABARD_DESIGNER = 524288,
  BATTLEMASTER = 1048576,
  AUCTIONEER = 2097152,
  STABLEMASTER = 4194304,
} or {
  NONE = 0,
  GOSSIP = 1,
  QUEST_GIVER = 2,
  VENDOR = 4,
  FLIGHT_MASTER = 8,
  TRAINER = 16,
  SPIRIT_HEALER = 32,
  SPIRIT_GUIDE = 64,
  INNKEEPER = 128,
  BANKER = 256,
  PETITIONER = 512,
  TABARD_DESIGNER = 1024,
  BATTLEMASTER = 2048,
  AUCTIONEER = 4096,
  STABLEMASTER = 8192,
  REPAIR = 16384,
}

--TODO: This should not really be here...
NpcMeta.waypointPresets = {
  ORGRIMS_HAMMER = { [ZoneMeta.zoneIDs.ICECROWN] = { { { 62.37, 30.60, }, { 61.93, 30.93, }, { 61.48, 31.24, }, { 61.08, 31.55, }, { 60.74, 31.92, }, { 60.46, 32.44, }, { 60.26, 33.11, }, { 60.14, 33.85, }, { 60.11, 34.63, }, { 60.17, 35.35, }, { 60.31, 36.01, }, { 60.56, 36.66, }, { 60.84, 37.33, }, { 61.15, 38.00, }, { 61.44, 38.67, }, { 61.71, 39.28, }, { 62.00, 39.92, }, { 62.31, 40.55, }, { 62.60, 41.20, }, { 62.90, 41.83, }, { 63.05, 42.20, }, { 63.33, 42.85, }, { 63.58, 43.53, }, { 63.85, 44.19, }, { 64.08, 44.86, }, { 64.33, 45.50, }, { 64.45, 45.87, }, { 64.69, 46.56, }, { 64.94, 47.21, }, { 65.16, 47.87, }, { 65.43, 48.51, }, { 65.71, 49.15, }, { 66.03, 49.77, }, { 66.36, 50.46, }, { 66.72, 51.10, }, { 67.07, 51.67, }, { 67.41, 52.08, }, { 67.82, 52.37, }, { 68.31, 52.47, }, { 68.80, 52.38, }, { 69.23, 51.98, }, { 69.45, 51.56, }, { 69.57, 51.13, }, { 69.67, 50.59, }, { 69.73, 49.96, }, { 69.77, 49.26, }, { 69.79, 48.48, }, { 69.80, 47.62, }, { 69.79, 46.68, }, { 69.79, 45.68, }, { 69.78, 44.90, }, { 69.78, 44.25, }, { 69.76, 43.55, }, { 69.75, 42.80, }, { 69.72, 42.01, }, { 69.70, 41.20, }, { 69.67, 40.38, }, { 69.64, 39.54, }, { 69.61, 38.71, }, { 69.58, 37.88, }, { 69.55, 37.07, }, { 69.52, 36.28, }, { 69.49, 35.54, }, { 69.46, 34.83, }, { 69.45, 34.18, }, { 69.42, 33.50, }, { 69.41, 32.46, }, { 69.42, 31.52, }, { 69.45, 30.67, }, { 69.47, 29.92, }, { 69.48, 29.25, }, { 69.46, 28.65, }, { 69.42, 28.12, }, { 69.35, 27.83, }, { 69.11, 27.19, }, { 68.71, 26.77, }, { 68.23, 26.54, }, { 67.71, 26.51, }, { 67.24, 26.55, }, { 66.81, 26.76, }, { 66.35, 27.09, }, { 65.90, 27.52, }, { 65.44, 27.95, }, { 65.01, 28.39, }, { 64.58, 28.73, }, { 64.16, 29.10, }, { 63.74, 29.43, }, { 63.34, 29.79, }, { 62.94, 30.11, }, { 62.65, 30.37, }, { 62.37, 30.60, }, }, }, },
  THE_SKYBREAKER = { [ZoneMeta.zoneIDs.ICECROWN] = { { { 63.59, 52.34, }, { 63.44, 51.88, }, { 63.30, 51.52, }, { 63.15, 51.19, }, { 63.01, 50.85, }, { 62.85, 50.52, }, { 62.68, 50.17, }, { 62.50, 49.78, }, { 62.31, 49.36, }, { 62.09, 48.88, }, { 61.86, 48.33, }, { 61.81, 48.20, }, { 61.67, 47.88, }, { 61.52, 47.52, }, { 61.37, 47.13, }, { 61.19, 46.74, }, { 61.02, 46.32, }, { 60.84, 45.88, }, { 60.65, 45.44, }, { 60.46, 44.99, }, { 60.28, 44.53, }, { 60.09, 44.08, }, { 59.90, 43.63, }, { 59.72, 43.18, }, { 59.54, 42.75, }, { 59.36, 42.34, }, { 59.20, 41.94, }, { 59.04, 41.56, }, { 58.89, 41.22, }, { 58.75, 40.87, }, { 58.52, 40.30, }, { 58.32, 39.77, }, { 58.14, 39.27, }, { 57.97, 38.80, }, { 57.81, 38.39, }, { 57.65, 38.03, }, { 57.49, 37.72, }, { 57.31, 37.50, }, { 57.12, 37.34, }, { 56.87, 37.29, }, { 56.57, 37.39, }, { 56.27, 37.60, }, { 55.97, 37.88, }, { 55.72, 38.23, }, { 55.53, 38.61, }, { 55.43, 38.95, }, { 55.43, 39.09, }, { 55.46, 39.49, }, { 55.52, 39.92, }, { 55.62, 40.39, }, { 55.76, 40.88, }, { 55.89, 41.38, }, { 56.02, 41.85, }, { 56.17, 42.25, }, { 56.33, 42.68, }, { 56.51, 43.13, }, { 56.70, 43.56, }, { 56.88, 43.99, }, { 57.05, 44.39, }, { 57.22, 44.74, }, { 57.42, 45.15, }, { 57.64, 45.52, }, { 57.83, 45.81, }, { 58.03, 46.14, }, { 58.23, 46.56, }, { 58.41, 46.90, }, { 58.60, 47.25, }, { 58.80, 47.62, }, { 59.00, 48.03, }, { 59.19, 48.46, }, { 59.36, 48.84, }, { 59.53, 49.22, }, { 59.69, 49.63, }, { 59.86, 50.04, }, { 60.03, 50.46, }, { 60.19, 50.90, }, { 60.36, 51.32, }, { 60.51, 51.74, }, { 60.65, 52.17, }, { 60.79, 52.59, }, { 60.94, 53.02, }, { 61.07, 53.46, }, { 61.23, 53.89, }, { 61.39, 54.30, }, { 61.55, 54.72, }, { 61.70, 55.18, }, { 61.88, 55.65, }, { 62.05, 56.14, }, { 62.23, 56.58, }, { 62.43, 56.95, }, { 62.65, 57.21, }, { 62.87, 57.30, }, { 62.95, 57.27, }, { 63.22, 57.16, }, { 63.52, 56.97, }, { 63.81, 56.68, }, { 64.07, 56.32, }, { 64.26, 55.91, }, { 64.33, 55.47, }, { 64.30, 55.11, }, { 64.25, 54.72, }, { 64.16, 54.30, }, { 64.04, 53.84, }, { 63.91, 53.36, }, { 63.76, 52.88, }, { 63.59, 52.34, }, }, }, },
  ALLIANCE_GUNSHIP = { [ZoneMeta.zoneIDs.DEEPHOLM] = { { { 61.79, 46.28, }, { 61.68, 45.72, }, { 61.55, 45.10, }, { 61.45, 44.56, }, { 61.34, 43.97, }, { 61.22, 43.46, }, { 61.13, 42.90, }, { 61.06, 42.23, }, { 60.98, 41.63, }, { 60.90, 40.98, }, { 60.84, 40.28, }, { 60.81, 39.59, }, { 60.84, 38.98, }, { 60.99, 38.55, }, { 61.33, 38.23, }, { 61.75, 38.04, }, { 62.21, 38.04, }, { 62.62, 38.33, }, { 62.82, 38.82, }, { 62.95, 39.32, }, { 63.07, 39.93, }, { 63.19, 40.61, }, { 63.30, 41.31, }, { 63.40, 41.98, }, { 63.49, 42.57, }, { 63.60, 43.23, }, { 63.69, 43.90, }, { 63.77, 44.48, }, { 63.85, 44.98, }, { 63.95, 45.61, }, { 64.05, 46.15, }, { 64.22, 46.69, }, { 64.31, 47.26, }, { 64.40, 47.87, }, { 64.47, 48.40, }, { 64.54, 49.02, }, { 64.62, 49.71, }, { 64.69, 50.29, }, { 64.76, 50.96, }, { 64.82, 51.65, }, { 64.84, 52.29, }, { 64.77, 52.81, }, { 64.59, 53.41, }, { 64.29, 53.74, }, { 63.93, 53.82, }, { 63.58, 53.79, }, { 63.15, 53.70, }, { 62.72, 53.51, }, { 62.42, 53.16, }, { 62.32, 52.68, }, { 62.27, 52.08, }, { 62.23, 51.41, }, { 62.20, 50.75, }, { 62.18, 50.12, }, { 62.22, 49.50, }, { 62.23, 48.90, }, { 62.19, 48.31, }, { 62.09, 47.73, }, { 61.97, 47.12, }, { 61.83, 46.50, }, { 61.79, 46.28, }, }, }, },
}

-- Used for dumping the database
NpcMeta.dumpFuncs = {
  ['name'] = DumpFunctions.dump,
  ['minLevelHealth'] = DumpFunctions.dump,
  ['maxLevelHealth'] = DumpFunctions.dump,
  ['minLevel'] = DumpFunctions.dump,
  ['maxLevel'] = DumpFunctions.dump,
  ['rank'] = DumpFunctions.dump,
  ['spawns'] = DumpFunctions.dumpCoordiates,
  ['waypoints'] = DumpFunctions.dumpCoordiates,
  ['zoneID'] = DumpFunctions.dump,
  ['questStarts'] = DumpFunctions.dumpAsArraySorted,
  ['questEnds'] = DumpFunctions.dumpAsArraySorted,
  ['factionID'] = DumpFunctions.dump,
  ['friendlyToFaction'] = DumpFunctions.dump,
  ['subName'] = DumpFunctions.dump,
  ['npcFlags'] = DumpFunctions.dump,
}

-- Localize these variables to clean up the code
do
  -- This combines the values that are going to be converted into a string
  -- The lowest index is the one that will be replaced with the combined string
  local combineValues = {
    [2] = 'minLevelHealth',
    [3] = 'maxLevelHealth',
    [4] = 'minLevel',
    [5] = 'maxLevel',
    [6] = 'rank',
    [9] = 'zoneID',
    [12] = 'factionID',
    [13] = 'friendlyToFaction',
    [15] = 'npcFlags',
  }

  -- Combine all values into one string 0;0;0;0;;
  -- where numbers become 0 if they are nil and strings become empty such as 0;<string>;0
  ---@param tbl table<number, any> @ Table that will be modified
  ---@return table<number, any> @ Returns the table inputted with the combined value
  ---@return string @ Returns the combined value string that was inserted into the table
  function NpcMeta.combine(tbl)
    return DumpFunctions.combine(tbl, combineValues, NpcMeta.npcTypes)
  end

  -- Check if combineValues is empty or not
  if next(combineValues) == nil then
    -- If combineValues is empty, set the combine function to nil
    NpcMeta.combine = nil
  end
end
