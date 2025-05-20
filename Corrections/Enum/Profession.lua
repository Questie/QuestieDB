---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------
---@class Enum
local Enum = LibQuestieDB.Enum

--- Adds the ability to override the profession keys for quest enum
---@class OverrideEnumProfessionKeys
local professionKeysOverride = {
  -- Example:
  --   FIRST_AID_TEST = 129,
  --   ...
  -- Insert overrides below:

}

--- Adds the ability to override the specialization keys for quest enum
---@class OverrideEnumSpecializationKeys
local specializationKeysOverride = {
  -- Example:
  --   ALCHEMY_MEGA_POTION = 1337,
  --   ...
  -- Insert overrides below:

}

---The table is used when creating enum for quests
---@class EnumProfessionKeys:OverrideEnumProfessionKeys
Enum.professionKeys = {
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
---@class EnumSpecializationKeys
Enum.specializationKeys = {
  ALCHEMY = Enum.professionKeys.ALCHEMY,
  ALCHEMY_ELIXIR = 28677,
  ALCHEMY_POTION = 28675,
  ALCHEMY_TRANSMUTATION = 28672,
  BLACKSMITHING = Enum.professionKeys.BLACKSMITHING,
  BLACKSMITHING_ARMOR = 9788,
  BLACKSMITHING_WEAPON = 9787,
  BLACKSMITHING_WEAPON_AXE = 17041,
  BLACKSMITHING_WEAPON_HAMMER = 17040,
  BLACKSMITHING_WEAPON_SWORD = 17039,
  ENGINEERING = Enum.professionKeys.ENGINEERING,
  ENGINEERING_GNOMISH = 20219,
  ENGINEERING_GOBLIN = 20222,
  LEATHERWORKING = Enum.professionKeys.LEATHERWORKING,
  LEATHERWORKING_DRAGONSCALE = 10656,
  LEATHERWORKING_ELEMENTAL = 10658,
  LEATHERWORKING_TRIBAL = 10660,
  TAILORING = Enum.professionKeys.TAILORING,
  TAILORING_MOONCLOTH = 26798,
  TAILORING_SHADOWEAVE = 26801,
  TAILORING_SPELLFIRE = 26797,
}

-- Add the override keys to the profession table
for key, value in pairs(professionKeysOverride) do
  Enum.professionKeys[key] = value
end

-- Add the override keys to the specialization table
for key, value in pairs(specializationKeysOverride) do
  Enum.specializationKeys[key] = value
end
