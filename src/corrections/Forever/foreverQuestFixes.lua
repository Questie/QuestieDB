---@class ForeverQuestFixes
local ForeverQuestFixes = QuestieLoader:CreateModule("ForeverQuestFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
---@type QuestieProfessions
local QuestieProfessions = QuestieLoader:ImportModule("QuestieProfessions")
---@type QuestieCorrections
local QuestieCorrections = QuestieLoader:ImportModule("QuestieCorrections")
---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverQuestFixes:Load()
    local questKeys = QuestieDB.questKeys
    local zoneIDs = ZoneDB.zoneIDs
    local raceIDs = QuestieDB.raceKeys
    local classIDs = QuestieDB.classKeys
    local sortKeys = QuestieDB.sortKeys
    local specialFlags = QuestieDB.specialFlags
    local profKeys = QuestieProfessions.professionKeys
    local specKeys = QuestieProfessions.specializationKeys
    local factionIDs = QuestieDB.factionIDs
    local rankKeys = QuestieProfessions.rankNames

    return {
        [95805] = { -- Grace of An'she and Mu'sha
            [questKeys.name] = "Grace of An'she and Mu'sha",
            [questKeys.startedBy] = {{2982}},
            [questKeys.finishedBy] = {nil,{660739}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Carry the Smoldering Incense to the shrine of An'she and Mu'sha in the southeastern hills before the incense burns to ash in ten minutes!"},
            [questKeys.zoneOrSort] = 220,
            [questKeys.requiredSourceItems] = {277199},
            [questKeys.objectives] = {nil,nil,{{277199}}},
        },
        [96130] = { -- Chakuyak
            [questKeys.name] = "Chakuyak",
            [questKeys.startedBy] = {{3065}},
            [questKeys.finishedBy] = {{3065}},
            [questKeys.requiredLevel] = 5,
            [questKeys.questLevel] = 8,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Defeat Chakuyak and bring back her pelt."},
            [questKeys.zoneOrSort] = zoneIDs.MULGORE,
            [questKeys.objectives] = {nil,nil,{{270302}}},
        },
        [96659] = { -- The Adventurer
            [questKeys.name] = "The Adventurer",
            [questKeys.startedBy] = {{2981}},
            [questKeys.finishedBy] = {{265810}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Deliver the Supply Bundle to Kaga Wildhoof near Bloodhoof Village."},
            [questKeys.zoneOrSort] = sortKeys.CAMPING,
            [questKeys.requiredSourceItems] = {275019},
            [questKeys.objectives] = nil,
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverQuestFixes:LoadDynamic()
    local questKeys = QuestieDB.questKeys
    local zoneIDs = ZoneDB.zoneIDs
    local raceIDs = QuestieDB.raceKeys
    local classIDs = QuestieDB.classKeys
    local sortKeys = QuestieDB.sortKeys
    local specialFlags = QuestieDB.specialFlags
    local profKeys = QuestieProfessions.professionKeys
    local specKeys = QuestieProfessions.specializationKeys
    local factionIDs = QuestieDB.factionIDs
    local rankKeys = QuestieProfessions.rankNames
    local playerClass = UnitClassBase("player")

    return {
        -- [questId] = { [questKeys.name] = "Corrected name" },
    }
end
