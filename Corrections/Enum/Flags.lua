---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Extend Module --------

---@class Enum
local Enum = LibQuestieDB.Enum

-- * ---- NPC --------

---@enum NpcFlags
LibQuestieDB.npcFlags = {
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

-- * ---- Quest --------

-- bitmask: see https://github.com/cmangos/issues/wiki/Quest_template#questflags
---@enum QuestFlags
Enum.questFlags = {
  NONE = 0,
  STAY_ALIVE = 1,
  PARTY_ACCEPT = 2,
  EXPLORATION = 4,
  SHARABLE = 8,
  UNUSED1 = 16,
  EPIC = 32,
  RAID = 64,
  UNUSED2 = 128,
  UNKNOWN = 256,
  HIDDEN_REWARDS = 512,
  AUTO_REWARDED = 1024,
  DAILY = 4096,
  WEEKLY = 32768,
}

-- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags
---@enum SpecialFlags
Enum.specialFlags = {
  NONE = 0,
  REPEATABLE = 1,
}
