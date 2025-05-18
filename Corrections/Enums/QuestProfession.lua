---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------
---@class Corrections
local Corrections = LibQuestieDB.Corrections

--*---- Create Module --------
---@class QuestCorrection
local QuestCorrection = {}

-- Add QuestCorrection
Corrections.QuestCorrection = QuestCorrection

--- Adds the ability to override the profession keys for quest corrections
---@class OverrideQuestProfessionKeys
local professionKeysOverride = {
  -- Example:
  --   FIRST_AID_TEST = 129,
  --   ...
  -- Insert overrides below:

}

---The table is used when creating corrections for quests
---@class QuestProfessionKeys:OverrideQuestProfessionKeys
QuestCorrection.professionKeys = {
  -- This table is auto-generated from the CSV file
  -- Do not edit this table directly
  -- Instead, edit the override table above

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

  -- This table is auto-generated from the CSV file
  -- Do not edit this table directly
  -- Instead, edit the override table above
}

-- specializations use spellID, professions use skillID
-- Source: (https://github.com/Questie/Questie/blob/7c787addf6a52cbe9ff279152c5558ffb1bb0746/Modules/QuestieProfessions.lua#L235-L235)
---@class QuestSpecializationKeys
QuestCorrection.specializationKeys = {
  ALCHEMY = QuestCorrection.professionKeys.ALCHEMY,
  ALCHEMY_ELIXIR = 28677,
  ALCHEMY_POTION = 28675,
  ALCHEMY_TRANSMUTATION = 28672,
  BLACKSMITHING = QuestCorrection.professionKeys.BLACKSMITHING,
  BLACKSMITHING_ARMOR = 9788,
  BLACKSMITHING_WEAPON = 9787,
  BLACKSMITHING_WEAPON_AXE = 17041,
  BLACKSMITHING_WEAPON_HAMMER = 17040,
  BLACKSMITHING_WEAPON_SWORD = 17039,
  ENGINEERING = QuestCorrection.professionKeys.ENGINEERING,
  ENGINEERING_GNOMISH = 20219,
  ENGINEERING_GOBLIN = 20222,
  LEATHERWORKING = QuestCorrection.professionKeys.LEATHERWORKING,
  LEATHERWORKING_DRAGONSCALE = 10656,
  LEATHERWORKING_ELEMENTAL = 10658,
  LEATHERWORKING_TRIBAL = 10660,
  TAILORING = QuestCorrection.professionKeys.TAILORING,
  TAILORING_MOONCLOTH = 26798,
  TAILORING_SHADOWEAVE = 26801,
  TAILORING_SPELLFIRE = 26797,
}

-- Add the override keys to the table
for key, value in pairs(professionKeysOverride) do
  QuestCorrection.professionKeys[key] = value
end
