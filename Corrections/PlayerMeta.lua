---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class PlayerMeta
local PlayerMeta = {}

-- Add PlayerMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.PlayerMeta = PlayerMeta

---@enum RaceIDs
PlayerMeta.raceKeys = {
  ALL_ALLIANCE = LibQuestieDB.IsClassic and 77 or 1101,
  ALL_HORDE = LibQuestieDB.IsClassic and 178 or 690,
  NONE = 0,

  HUMAN = 1,
  ORC = 2,
  DWARF = 4,
  NIGHT_ELF = 8,
  UNDEAD = 16,
  TAUREN = 32,
  GNOME = 64,
  TROLL = 128,
  --GOBLIN = 256,
  BLOOD_ELF = 512,
  DRAENEI = 1024,
}

-- Combining these with "and" makes the order matter
-- 1 and 2 ~= 2 and 1
---@enum ClassIDs
PlayerMeta.classKeys = {
  NONE = 0,

  WARRIOR = 1,
  PALADIN = 2,
  HUNTER = 4,
  ROGUE = 8,
  PRIEST = 16,
  DEATH_KNIGHT = 32,
  SHAMAN = 64,
  MAGE = 128,
  WARLOCK = 256,
  DRUID = 1024,
}
