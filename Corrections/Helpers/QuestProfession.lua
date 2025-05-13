---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class QuestCorrection
local QuestCorrection = {}

-- Add QuestCorrection
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.QuestCorrection = QuestCorrection

---@enum ProfessionEnum
QuestCorrection.professionKeys = {
  FIRST_AID = 129,
  BLACKSMITHING = 164,
  LEATHERWORKING = 165,
  ALCHEMY = 171,
  HERBALISM = 182,
  COOKING = 185,
  MINING = 186,
  TAILORING = 197,
  ENGINEERING = 202,
  ENCHANTING = 333,
  FISHING = 356,
  SKINNING = 393,
  JEWELCRAFTING = 755,
  RIDING = 762,
  INSCRIPTION = 773,
  ARCHAEOLOGY = 794,
}
