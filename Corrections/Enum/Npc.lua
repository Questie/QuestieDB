---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------
---@class Enum
local Enum = LibQuestieDB.Enum

--- This is the meaning of the npcFlags in the database
--- The table is used when creating corrections for npcs
---@class EnumNpcFlags
Enum.npcFlags = {
  -- Source Era: https://github.com/cmangos/issues/wiki/creature_template_classic#npcflags
  -- Source Tbc: https://github.com/cmangos/issues/wiki/creature_template_tbc#npcflags
  -- Source Wrath: https://github.com/cmangos/issues/wiki/creature_template#npcflags
  NONE = 0,
  GOSSIP = 1,
  QUEST_GIVER = 2,
  VENDOR = LibQuestieDB.IsClassic and 4 or 128,
  FLIGHT_MASTER = LibQuestieDB.IsClassic and 8 or 8192,
  TRAINER = 16,
  SPIRIT_HEALER = LibQuestieDB.IsClassic and 32 or 16384,
  SPIRIT_GUIDE = LibQuestieDB.IsClassic and 64 or 32768,
  INNKEEPER = LibQuestieDB.IsClassic and 128 or 65536,
  BANKER = LibQuestieDB.IsClassic and 256 or 131072,
  PETITIONER = LibQuestieDB.IsClassic and 512 or 262144,
  TABARD_DESIGNER = LibQuestieDB.IsClassic and 1024 or 524288,
  BATTLEMASTER = LibQuestieDB.IsClassic and 2048 or 1048576,
  AUCTIONEER = LibQuestieDB.IsClassic and 4096 or 2097152,
  STABLEMASTER = LibQuestieDB.IsClassic and 8192 or 4194304,
  REPAIR = LibQuestieDB.IsClassic and 16384 or 4096,
  BARBER = (LibQuestieDB.IsWotlk or LibQuestieDB.IsCata) and 16777216 or nil,
  ARCANE_REFORGER = LibQuestieDB.IsCata and 134217728 or nil,
  TRANSMOGRIFIER = LibQuestieDB.IsCata and 268435456 or nil,
}
