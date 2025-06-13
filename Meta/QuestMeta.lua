---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Meta.DumpFunctions

---@class QuestMeta
local QuestMeta = {}

---@class Meta
local Meta = LibQuestieDB.Meta
Meta.QuestMeta = QuestMeta

---@class QuestDBKeys @ Contains name of data as keys and their index as value
QuestMeta.questKeys = {
  ['name'] = 1,      -- string
  ['startedBy'] = 2, -- table
  --['creatureStart'] = 1, -- table {creature(int),...}
  --['objectStart'] = 2, -- table {object(int),...}
  --['itemStart'] = 3, -- table {item(int),...}
  ['finishedBy'] = 3, -- table
  --['creatureEnd'] = 1, -- table {creature(int),...}
  --['objectEnd'] = 2, -- table {object(int),...}
  ['requiredLevel'] = 4,   -- int
  ['questLevel'] = 5,      -- int
  ['requiredRaces'] = 6,   -- bitmask
  ['requiredClasses'] = 7, -- bitmask
  ['objectivesText'] = 8,  -- table: {string,...}, Description of the quest. Auto-complete if nil.
  ['triggerEnd'] = 9,      -- table: {text, {[zoneID] = {coordPair,...},...}}
  ['objectives'] = 10,     -- table
  --['creatureObjective'] = 1, -- table {{creature(int), text(string)},...}, If text is nil the default "<Name> slain x/y" is used
  --['objectObjective'] = 2, -- table {{object(int), text(string)},...}
  --['itemObjective'] = 3, -- table {{item(int), text(string)},...}
  --['reputationObjective'] = 4, -- table: {faction(int), value(int)}
  --['killCreditObjective'] = 5, -- table: {{creature(int), ...}, baseCreatureID, baseCreatureText}
  --['spellObjective'] = 6, -- table: {{spell(int), text(string)},...}
  ['sourceItemId'] = 11,           -- int, item provided by quest starter
  ['preQuestGroup'] = 12,          -- table: {quest(int)}
  ['preQuestSingle'] = 13,         -- table: {quest(int)}
  ['childQuests'] = 14,            -- table: {quest(int)}
  ['inGroupWith'] = 15,            -- table: {quest(int)}
  ['exclusiveTo'] = 16,            -- table: {quest(int)}
  ['zoneOrSort'] = 17,             -- int, >0: AreaTable.dbc ID; <0: QuestSort.dbc ID
  ['requiredSkill'] = 18,          -- table: {skill(int), value(int)}
  ['requiredMinRep'] = 19,         -- table: {faction(int), value(int)}
  ['requiredMaxRep'] = 20,         -- table: {faction(int), value(int)}
  ['requiredSourceItems'] = 21,    -- table: {item(int), ...} Items that are not an objective but still needed for the quest.
  ['nextQuestInChain'] = 22,       -- int: if this quest is active/finished, the current quest is not available anymore
  ['questFlags'] = 23,             -- bitmask: see https://github.com/cmangos/issues/wiki/Quest_template#questflags
  ['specialFlags'] = 24,           -- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags
  ['parentQuest'] = 25,            -- int, the ID of the parent quest that needs to be active for the current one to be available. See also 'childQuests' (field 14)
  ['reputationReward'] = 26,       -- table: {{FACTION,VALUE}, ...}, A list of reputation reward for factions
  ['extraObjectives'] = 27,        -- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
  ['requiredSpell'] = 28,          -- int: quest is only available if character has this spellID
  ['requiredSpecialization'] = 29, -- int: quest is only available if character meets the spec requirements. Use QuestieProfessions.specializationKeys for having a spec, or QuestieProfessions.professionKeys to indicate having the profession with no spec. See QuestieProfessions.lua for more info.
  ['requiredMaxLevel'] = 30,       -- int: quest is only available up to a certain level
  ['orderedObjectives'] = 31,      -- table: {objectiveTypeKey, objectiveInstanceIndex, orderIndex} pairs defining display order of objectives.
}

---@enum QuestObjectiveKeys
QuestMeta.objectiveKeys = {
  CREATURE   = 1,  -- Creature Objective
  OBJECT     = 2,  -- Object Objective
  ITEM       = 3,  -- Item Objective
  REPUTATION = 4,  -- Reputation Objective
  KILLCREDIT = 5,  -- Kill Credit Objective
  SPELL      = 6,  -- Spell Objective
}

--- Contains the name of data as keys and their index as value for quick lookup
QuestMeta.NameIndexLookupTable = {}
for key, index in pairs(QuestMeta.questKeys) do
  QuestMeta.NameIndexLookupTable[index] = key
  QuestMeta.NameIndexLookupTable[key] = index
end

-- Contains the type of data as keys and their index as value
QuestMeta.questTypes = {
  ['name'] = "string",
  ['startedBy'] = "table",
  --['creatureStart'] = "table",
  --['objectStart'] = "table",
  --['itemStart'] = "table",
  ['finishedBy'] = "table",
  --['creatureEnd'] = "table",
  --['objectEnd'] = "table",
  ['requiredLevel'] = "number",
  ['questLevel'] = "number",
  ['requiredRaces'] = "number",
  ['requiredClasses'] = "number",
  ['objectivesText'] = "table",
  ['triggerEnd'] = "table",
  ['objectives'] = "table",
  --['creatureObjective'] = "table",
  --['objectObjective'] = "table",
  --['itemObjective'] = "table",
  --['reputationObjective'] = "table",
  --['killCreditObjective'] = "table",
  --['spellObjective'] = "table",
  ['sourceItemId'] = "number",
  ['preQuestGroup'] = "table",
  ['preQuestSingle'] = "table",
  ['childQuests'] = "table",
  ['inGroupWith'] = "table",
  ['exclusiveTo'] = "table",
  ['zoneOrSort'] = "number",
  ['requiredSkill'] = "table",
  ['requiredMinRep'] = "table",
  ['requiredMaxRep'] = "table",
  ['requiredSourceItems'] = "table",
  ['nextQuestInChain'] = "number",
  ['questFlags'] = "number",
  ['specialFlags'] = "number",
  ['parentQuest'] = "number",
  ['reputationReward'] = "table",
  ['extraObjectives'] = "table",
  ['requiredSpell'] = "number",
  ['requiredSpecialization'] = "number",
  ['requiredMaxLevel'] = "number",
  ['orderedObjectives'] = "table",
}
-- Add the index keys to questTypes
for key, index in pairs(QuestMeta.questKeys) do
  QuestMeta.questTypes[index] = QuestMeta.questTypes[key]
end


-- ---@enum QuestFlags
-- QuestMeta.questFlags = {
--   NONE = 0,
--   STAY_ALIVE = 1,
--   PARTY_ACCEPT = 2,
--   EXPLORATION = 4,
--   SHARABLE = 8,
--   UNUSED1 = 16,
--   EPIC = 32,
--   RAID = 64,
--   UNUSED2 = 128,
--   UNKNOWN = 256,
--   HIDDEN_REWARDS = 512,
--   AUTO_REWARDED = 1024,
--   DAILY = 4096,
--   WEEKLY = 32768,
-- }

-- -- TODO: Should this really be here?
-- ---@enum Factions
-- QuestMeta.factionIDs = {
--   UNDERCITY = 68,
--   DARNASSUS = 69,
--   DARKMOON_FAIRE = 909,
--   EXODAR = 930,
--   THE_KALUAK = 1073,
--   KIRIN_TOR = 1090,
-- }

-- ---@enum QuestSortKeys @ These are the values for the 'zoneOrSort' field
-- QuestMeta.sortKeys = {
--   SEASONAL = -22,
--   HERBALISM = -24,
--   BATTLEGROUND = -25,
--   WARLOCK = -61,
--   WARRIOR = -81,
--   SHAMAN = -82,
--   FISHING = -101,
--   BLACKSMITHING = -121,
--   PALADIN = -141,
--   MAGE = -161,
--   ROGUE = -162,
--   ALCHEMY = -181,
--   LEATHERWORKING = -182,
--   ENGINEERING = -201,
--   HUNTER = -261,
--   PRIEST = -262,
--   DRUID = -263,
--   TAILORING = -264,
--   SPECIAL = -284,
--   COOKING = -304,
--   FIRST_AID = -324,
--   DARKMOON_FAIRE = -364,
--   LUNAR_FESTIVAL = -366,
--   REPUTATION = -367,
--   MIDSUMMER = -369,
--   BREWFEST = -370,
--   INSCRIPTION = -371,
--   DEATHKNIGHT = -372,
--   JEWELCRAFTING = -373,
--   NOBLEGARDEN = -374,
--   PILGRIMS_BOUNTY = -375,
--   LOVE_IS_IN_THE_AIR = -376,
-- }

-- ---@enum ProfessionEnum
-- QuestMeta.professionKeys = {
--   FIRST_AID = 129,
--   BLACKSMITHING = 164,
--   LEATHERWORKING = 165,
--   ALCHEMY = 171,
--   HERBALISM = 182,
--   COOKING = 185,
--   MINING = 186,
--   TAILORING = 197,
--   ENGINEERING = 202,
--   ENCHANTING = 333,
--   FISHING = 356,
--   SKINNING = 393,
--   JEWELCRAFTING = 755,
--   INSCRIPTION = 773,
--   RIDING = 762,
-- }

-- ---@enum ProfessionSpecializationEnum
-- QuestMeta.specializationKeys = { -- specializations use spellID, professions use skillID
--   ALCHEMY = QuestMeta.professionKeys.ALCHEMY,
--   ALCHEMY_ELIXIR = 28677,
--   ALCHEMY_POTION = 28675,
--   ALCHEMY_TRANSMUTATION = 28672,
--   BLACKSMITHING = QuestMeta.professionKeys.BLACKSMITHING,
--   BLACKSMITHING_ARMOR = 9788,
--   BLACKSMITHING_WEAPON = 9787,
--   BLACKSMITHING_WEAPON_AXE = 17041,
--   BLACKSMITHING_WEAPON_HAMMER = 17040,
--   BLACKSMITHING_WEAPON_SWORD = 17039,
--   ENGINEERING = QuestMeta.professionKeys.ENGINEERING,
--   ENGINEERING_GNOMISH = 20219,
--   ENGINEERING_GOBLIN = 20222,
--   LEATHERWORKING = QuestMeta.professionKeys.LEATHERWORKING,
--   LEATHERWORKING_DRAGONSCALE = 10656,
--   LEATHERWORKING_ELEMENTAL = 10658,
--   LEATHERWORKING_TRIBAL = 10660,
--   TAILORING = QuestMeta.professionKeys.TAILORING,
--   TAILORING_MOONCLOTH = 26798,
--   TAILORING_SHADOWEAVE = 26801,
--   TAILORING_SPELLFIRE = 26797,
-- }

-- Used for dumping the database
QuestMeta.dumpFuncs = {
  ['name'] = DumpFunctions.dump,
  ['startedBy'] = DumpFunctions.dumpAsArraySortSubTables,
  ['finishedBy'] = DumpFunctions.dumpAsArraySortSubTables,
  ['requiredLevel'] = DumpFunctions.dump,
  ['questLevel'] = DumpFunctions.dump,
  ['requiredRaces'] = DumpFunctions.dump,
  ['requiredClasses'] = DumpFunctions.dump,
  ['objectivesText'] = DumpFunctions.dumpAsArray,
  ['triggerEnd'] = DumpFunctions.dumpTriggerEnd,
  ['objectives'] = DumpFunctions.dumpAsArray,
  ['sourceItemId'] = DumpFunctions.dump,
  ['preQuestGroup'] = DumpFunctions.dumpAsArraySorted,
  ['preQuestSingle'] = DumpFunctions.dumpAsArraySorted,
  ['childQuests'] = DumpFunctions.dumpAsArraySorted,
  ['inGroupWith'] = DumpFunctions.dumpAsArraySorted,
  ['exclusiveTo'] = DumpFunctions.dumpAsArraySorted,
  ['zoneOrSort'] = DumpFunctions.dump,
  ['requiredSkill'] = DumpFunctions.dumpAsArray,
  ['requiredMinRep'] = DumpFunctions.dumpAsArray,
  ['requiredMaxRep'] = DumpFunctions.dumpAsArray,
  ['requiredSourceItems'] = DumpFunctions.dumpAsArraySorted,
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

-- Localize these variables to clean up the code
do
  -- This combines the values that are going to be converted into a string
  -- The lowest index is the one that will be replaced with the combined string
  local combineValues = {}

  -- Combine all values into one string 0;0;0;0;;
  -- where numbers become 0 if they are nil and strings become empty such as 0;<string>;0
  ---@param tbl table<number, any> @ Table that will be modified
  ---@return table<number, any> @ Returns the table inputted with the combined value
  ---@return string @ Returns the combined value string that was inserted into the table
  function QuestMeta.combine(tbl)
    return DumpFunctions.combine(tbl, combineValues, QuestMeta.questTypes)
  end

  -- Check if combineValues is empty or not
  if next(combineValues) == nil then
    -- If combineValues is empty, set the combine function to nil
    QuestMeta.combine = nil
  end
end
