---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class QuestMeta
local QuestMeta = {}

-- Add QuestMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.QuestMeta = QuestMeta


---@class QuestDBKeys @ Contains name of data as keys and their index as value
QuestMeta.questKeys = {
  ['name'] = 1,        -- string
  ['startedBy'] = 2,   -- table
  --['creatureStart'] = 1, -- table {creature(int),...}
  --['objectStart'] = 2, -- table {object(int),...}
  --['itemStart'] = 3, -- table {item(int),...}
  ['finishedBy'] = 3,   -- table
  --['creatureEnd'] = 1, -- table {creature(int),...}
  --['objectEnd'] = 2, -- table {object(int),...}
  ['requiredLevel'] = 4,     -- int
  ['questLevel'] = 5,        -- int
  ['requiredRaces'] = 6,     -- bitmask
  ['requiredClasses'] = 7,   -- bitmask
  ['objectivesText'] = 8,    -- table: {string,...}, Description of the quest. Auto-complete if nil.
  ['triggerEnd'] = 9,        -- table: {text, {[zoneID] = {coordPair,...},...}}
  ['objectives'] = 10,       -- table
  --['creatureObjective'] = 1, -- table {{creature(int), text(string)},...}, If text is nil the default "<Name> slain x/y" is used
  --['objectObjective'] = 2, -- table {{object(int), text(string)},...}
  --['itemObjective'] = 3, -- table {{item(int), text(string)},...}
  --['reputationObjective'] = 4, -- table: {faction(int), value(int)}
  --['killCreditObjective'] = 5, -- table: {{creature(int), ...}, baseCreatureID, baseCreatureText}
  --['spellObjective'] = 6, -- table: {{spell(int), text(string)},...}
  ['sourceItemId'] = 11,             -- int, item provided by quest starter
  ['preQuestGroup'] = 12,            -- table: {quest(int)}
  ['preQuestSingle'] = 13,           -- table: {quest(int)}
  ['childQuests'] = 14,              -- table: {quest(int)}
  ['inGroupWith'] = 15,              -- table: {quest(int)}
  ['exclusiveTo'] = 16,              -- table: {quest(int)}
  ['zoneOrSort'] = 17,               -- int, >0: AreaTable.dbc ID; <0: QuestSort.dbc ID
  ['requiredSkill'] = 18,            -- table: {skill(int), value(int)}
  ['requiredMinRep'] = 19,           -- table: {faction(int), value(int)}
  ['requiredMaxRep'] = 20,           -- table: {faction(int), value(int)}
  ['requiredSourceItems'] = 21,      -- table: {item(int), ...} Items that are not an objective but still needed for the quest.
  ['nextQuestInChain'] = 22,         -- int: if this quest is active/finished, the current quest is not available anymore
  ['questFlags'] = 23,               -- bitmask: see https://github.com/cmangos/issues/wiki/Quest_template#questflags
  ['specialFlags'] = 24,             -- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags
  ['parentQuest'] = 25,              -- int, the ID of the parent quest that needs to be active for the current one to be available. See also 'childQuests' (field 14)
  ['reputationReward'] = 26,         -- table: {{FACTION,VALUE}, ...}, A list of reputation reward for factions
  ['extraObjectives'] = 27,          -- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
  ['requiredSpell'] = 28,            -- int: quest is only available if character has this spellID
  ['requiredSpecialization'] = 29,   -- int: quest is only available if character meets the spec requirements. Use QuestieProfessions.specializationKeys for having a spec, or QuestieProfessions.professionKeys to indicate having the profession with no spec. See QuestieProfessions.lua for more info.
  ['requiredMaxLevel'] = 30,         -- int: quest is only available up to a certain level
}
---@enum QuestFlags
QuestMeta.questFlags = {
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
}

---@enum QuestSortKeys @ These are the values for the 'zoneOrSort' field
QuestMeta.sortKeys = {
  SEASONAL = -22,
  HERBALISM = -24,
  BATTLEGROUND = -25,
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
  HUNTER = -261,
  PRIEST = -262,
  DRUID = -263,
  TAILORING = -264,
  SPECIAL = -284,
  COOKING = -304,
  FIRST_AID = -324,
  DARKMOON_FAIRE = -364,
  LUNAR_FESTIVAL = -366,
  REPUTATION = -367,
  MIDSUMMER = -369,
  BREWFEST = -370,
  INSCRIPTION = -371,
  DEATHKNIGHT = -372,
  JEWELCRAFTING = -373,
  NOBLEGARDEN = -374,
  PILGRIMS_BOUNTY = -375,
  LOVE_IS_IN_THE_AIR = -376,
}

---@enum ProfessionEnum
QuestMeta.professionKeys = {
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
  INSCRIPTION = 773,
  RIDING = 762,
}

---@enum ProfessionSpecializationEnum
QuestMeta.specializationKeys = { -- specializations use spellID, professions use skillID
  ALCHEMY = QuestMeta.professionKeys.ALCHEMY,
  ALCHEMY_ELIXIR = 28677,
  ALCHEMY_POTION = 28675,
  ALCHEMY_TRANSMUTATION = 28672,
  BLACKSMITHING = QuestMeta.professionKeys.BLACKSMITHING,
  BLACKSMITHING_ARMOR = 9788,
  BLACKSMITHING_WEAPON = 9787,
  BLACKSMITHING_WEAPON_AXE = 17041,
  BLACKSMITHING_WEAPON_HAMMER = 17040,
  BLACKSMITHING_WEAPON_SWORD = 17039,
  ENGINEERING = QuestMeta.professionKeys.ENGINEERING,
  ENGINEERING_GNOMISH = 20219,
  ENGINEERING_GOBLIN = 20222,
  LEATHERWORKING = QuestMeta.professionKeys.LEATHERWORKING,
  LEATHERWORKING_DRAGONSCALE = 10656,
  LEATHERWORKING_ELEMENTAL = 10658,
  LEATHERWORKING_TRIBAL = 10660,
  TAILORING = QuestMeta.professionKeys.TAILORING,
  TAILORING_MOONCLOTH = 26798,
  TAILORING_SHADOWEAVE = 26801,
  TAILORING_SPELLFIRE = 26797,
}

-- Used for dumping the database
QuestMeta.dumpFuncs = {
  ['name'] = DumpFunctions.dump,
  ['startedBy'] = DumpFunctions.dumpAsArray,
  ['finishedBy'] = DumpFunctions.dumpAsArray,
  ['requiredLevel'] = DumpFunctions.dump,
  ['questLevel'] = DumpFunctions.dump,
  ['requiredRaces'] = DumpFunctions.dump,
  ['requiredClasses'] = DumpFunctions.dump,
  ['objectivesText'] = DumpFunctions.dumpAsArray,
  ['triggerEnd'] = DumpFunctions.dumpTriggerEnd,
  ['objectives'] = DumpFunctions.dumpAsArray,
  ['sourceItemId'] = DumpFunctions.dump,
  ['preQuestGroup'] = DumpFunctions.dumpAsArray,
  ['preQuestSingle'] = DumpFunctions.dumpAsArray,
  ['childQuests'] = DumpFunctions.dumpAsArray,
  ['inGroupWith'] = DumpFunctions.dumpAsArray,
  ['exclusiveTo'] = DumpFunctions.dumpAsArray,
  ['zoneOrSort'] = DumpFunctions.dump,
  ['requiredSkill'] = DumpFunctions.dumpAsArray,
  ['requiredMinRep'] = DumpFunctions.dumpAsArray,
  ['requiredMaxRep'] = DumpFunctions.dumpAsArray,
  ['requiredSourceItems'] = DumpFunctions.dumpAsArray,
  ['nextQuestInChain'] = DumpFunctions.dump,
  ['questFlags'] = DumpFunctions.dump,
  ['specialFlags'] = DumpFunctions.dump,
  ['parentQuest'] = DumpFunctions.dump,
  ['reputationReward'] = DumpFunctions.dumpAsArray,
  ['extraObjectives'] = DumpFunctions.dumpExtraObjectives,
  ['requiredSpell'] = DumpFunctions.dump,
  ['requiredSpecialization'] = DumpFunctions.dump,
  ['requiredMaxLevel'] = DumpFunctions.dump,
}
