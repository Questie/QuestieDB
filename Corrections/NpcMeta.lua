---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local ZoneMeta = LibQuestieDB.Corrections.ZoneMeta
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class NpcMeta
local NpcMeta = {}

-- Add NpcMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.NpcMeta = NpcMeta

---@class NpcDBKeys @ Contains name of data as keys and their index as value
NpcMeta.npcKeys = {
  ['name'] = 1,                 -- string
  ['minLevelHealth'] = 2,       -- int
  ['maxLevelHealth'] = 3,       -- int
  ['minLevel'] = 4,             -- int
  ['maxLevel'] = 5,             -- int
  ['rank'] = 6,                 -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
  ['spawns'] = 7,               -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['waypoints'] = 8,            -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['zoneID'] = 9,               -- guess as to where this NPC is most common
  ['questStarts'] = 10,         -- table {questID(int),...}
  ['questEnds'] = 11,           -- table {questID(int),...}
  ['factionID'] = 12,           -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
  ['friendlyToFaction'] = 13,   -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
  ['subName'] = 14,             -- string, The title or function of the NPC, e.g. "Weapon Vendor"
  ['npcFlags'] = 15,            -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
  -- For flag values see https://github.com/cmangos/mangos-classic/blob/172c005b0a69e342e908f4589b24a6f18246c95e/src/game/Entities/Unit.h#L536
}


-- NpcMeta.npcKeysReversed = {}
-- for key, id in pairs(NpcMeta.npcKeys) do
--   NpcMeta.npcKeysReversed[id] = key
-- end

---@enum NpcFlags
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
  REPAIR = 16384
}


--TODO: This should not really be here...
NpcMeta.waypointPresets = {
  ORGRIMS_HAMMER = {
    [ZoneMeta.zoneIDs.ICECROWN] = { { { 62.37, 30.60 }, { 61.93, 30.93 }, { 61.48, 31.24 }, { 61.08, 31.55 },
      { 60.74, 31.92 }, { 60.46, 32.44 }, { 60.26, 33.11 }, { 60.14, 33.85 }, { 60.11, 34.63 }, { 60.17, 35.35 },
      { 60.31, 36.01 }, { 60.56, 36.66 }, { 60.84, 37.33 }, { 61.15, 38.00 }, { 61.44, 38.67 }, { 61.71, 39.28 },
      { 62.00, 39.92 }, { 62.31, 40.55 }, { 62.60, 41.20 }, { 62.90, 41.83 }, { 63.05, 42.20 }, { 63.33, 42.85 },
      { 63.58, 43.53 }, { 63.85, 44.19 }, { 64.08, 44.86 }, { 64.33, 45.50 }, { 64.45, 45.87 }, { 64.69, 46.56 },
      { 64.94, 47.21 }, { 65.16, 47.87 }, { 65.43, 48.51 }, { 65.71, 49.15 }, { 66.03, 49.77 }, { 66.36, 50.46 },
      { 66.72, 51.10 }, { 67.07, 51.67 }, { 67.41, 52.08 }, { 67.82, 52.37 }, { 68.31, 52.47 }, { 68.80, 52.38 },
      { 69.23, 51.98 }, { 69.45, 51.56 }, { 69.57, 51.13 }, { 69.67, 50.59 }, { 69.73, 49.96 }, { 69.77, 49.26 },
      { 69.79, 48.48 }, { 69.80, 47.62 }, { 69.79, 46.68 }, { 69.79, 45.68 }, { 69.78, 44.90 }, { 69.78, 44.25 },
      { 69.76, 43.55 }, { 69.75, 42.80 }, { 69.72, 42.01 }, { 69.70, 41.20 }, { 69.67, 40.38 }, { 69.64, 39.54 },
      { 69.61, 38.71 }, { 69.58, 37.88 }, { 69.55, 37.07 }, { 69.52, 36.28 }, { 69.49, 35.54 }, { 69.46, 34.83 },
      { 69.45, 34.18 }, { 69.42, 33.50 }, { 69.41, 32.46 }, { 69.42, 31.52 }, { 69.45, 30.67 }, { 69.47, 29.92 },
      { 69.48, 29.25 }, { 69.46, 28.65 }, { 69.42, 28.12 }, { 69.35, 27.83 }, { 69.11, 27.19 }, { 68.71, 26.77 },
      { 68.23, 26.54 }, { 67.71, 26.51 }, { 67.24, 26.55 }, { 66.81, 26.76 }, { 66.35, 27.09 }, { 65.90, 27.52 },
      { 65.44, 27.95 }, { 65.01, 28.39 }, { 64.58, 28.73 }, { 64.16, 29.10 }, { 63.74, 29.43 }, { 63.34, 29.79 },
      { 62.94, 30.11 }, { 62.65, 30.37 }, { 62.37, 30.60 } } }
  },
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
  ['questStarts'] = DumpFunctions.dumpAsArray,
  ['questEnds'] = DumpFunctions.dumpAsArray,
  ['factionID'] = DumpFunctions.dump,
  ['friendlyToFaction'] = DumpFunctions.dump,
  ['subName'] = DumpFunctions.dump,
  ['npcFlags'] = DumpFunctions.dump,
}
