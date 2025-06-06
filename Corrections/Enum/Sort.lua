---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------
---@class Enum
local Enum = LibQuestieDB.Enum

--- Adds the ability to override the sort keys for quest corrections
---@class OverrideEnumSortKeys
local sortKeysOverride = {
  -- Example:
  --   PROVING_GROUNDS_TEST = -1337,
  --   ...
  -- Insert overrides below:
  -- Dummy Ids for professions (Source: https://github.com/Questie/Questie/blob/7c787addf6a52cbe9ff279152c5558ffb1bb0746/Modules/QuestieProfessions.lua#L216)
  MINING = -667,     -- Dummy Id
  ENCHANTING = -668, -- Dummy Id
  SKINNING = -666,   -- Dummy Id
}

--- These are the values for the 'zoneOrSort' field
--- The table is used when creating corrections for quests
---@class EnumSortKeys:OverrideEnumSortKeys
Enum.sortKeys = {
  -- This table is auto-generated from the CSV file
  -- Do not edit this table directly
  -- Instead, edit the override table above

  EPIC = -1,
  HALLOWS_END = -21,
  SEASONAL = -22,
  CATACLYSM = -23,
  HERBALISM = -24,
  BATTLEGROUND = -25,
  DAY_OF_THE_DEAD = -41,
  WARLOCK = -61,
  WARRIOR = -81,
  SHAMAN = -82,
  FISHING = -101,
  BLACKSMITHING = -121,
  PALADIN = -141,
  MAGE = -161,
  ROGUE = -162,
  ALCHEMY = -181,
  LEATHERWORKING = -182,
  ENGINEERING = -201,
  TREASURE_MAP = -221,
  TOURNAMENT = -241,
  HUNTER = -261,
  PRIEST = -262,
  DRUID = -263,
  TAILORING = -264,
  SPECIAL = -284,
  COOKING = -304,
  FIRST_AID = -324,
  LEGENDARY = -344,
  DARKMOON_FAIRE = -364,
  AHNQIRAJ_WAR = -365,
  LUNAR_FESTIVAL = -366,
  REPUTATION = -367,
  INVASION = -368,
  MIDSUMMER = -369,
  BREWFEST = -370,
  INSCRIPTION = -371,
  DEATH_KNIGHT = -372,
  JEWELCRAFTING = -373,
  NOBLEGARDEN = -374,
  PILGRIMS_BOUNTY = -375,
  LOVE_IS_IN_THE_AIR = -376,
  ARCHAEOLOGY = -377,
  CHILDRENS_WEEK = -378,
  FIRELANDS_INVASION = -379,
  THE_ZANDALARI = -380,
  ELEMENTAL_BONDS = -381,
  PANDAREN_BREWMASTERS = -391,
  SCENARIO = -392,
  BATTLE_PETS = -394,
  MONK = -395,
  LANDFALL = -396,
  PANDAREN_CAMPAIGN = -397,
  RIDING = -398,
  BRAWLERS_GUILD = -399,
  PROVING_GROUNDS = -400,

  -- This table is auto-generated from the CSV file
  -- Do not edit this table directly
  -- Instead, edit the override table above
}

-- Add the override keys to the sortKeys table
for k, v in pairs(sortKeysOverride) do
  Enum.sortKeys[k] = v
end
