-- AUTO GENERATED FILE! DO NOT EDIT!
-- Quest availability expressions converted from server-emulator condition tables.
-- Written with src/corrections/conditionBuilder.lua; the vocabulary is in src/conditions.lua.
---@class QuestieClassicQuestConditions
local QuestieClassicQuestConditions = QuestieLoader:CreateModule("QuestieClassicQuestConditions")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local C = QuestieLoader:ImportModule("ConditionBuilder")

function QuestieClassicQuestConditions:Load()
    local questKeys = QuestieDB.questKeys

    return {
        -- Jaina's Autograph
        [558] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(1687), C.QuestRewarded(1558), C.QuestRewarded(1479)),
        },
        -- You Scream, I Scream...
        [915] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(911), C.QuestRewarded(910), C.QuestRewarded(1800)),
        },
        -- Cairne's Hoofprint
        [925] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(911), C.QuestRewarded(910), C.QuestRewarded(1800)),
        },
        -- Zamek's Distraction
        [1191] = {
            [questKeys.conditions] = C.Any(C.QuestAvailable(1194), C.QuestInLog(1190)),
        },
        -- Unfinished Gordok Business
        [1318] = {
            [questKeys.conditions] = C.HasAura(22799),
        },
        -- The Tome of Divinity
        [1641] = {
            [questKeys.conditions] = C.QuestNone(1642),
        },
        -- The Tome of Divinity
        [1645] = {
            [questKeys.conditions] = C.QuestNone(1646),
        },
        -- The Symbol of Life
        [1789] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(1783), C.QuestInLog(1784)),
        },
        -- The Symbol of Life
        [1790] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(1786), C.QuestInLog(1787)),
        },
        -- Natural Materials
        [3128] = {
            [questKeys.conditions] = C.QuestRewarded(3122),
        },
        -- Replacement Phial
        [3375] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestRewarded(2204)), C.Any(C.QuestInLog(2200), C.QuestRewarded(2200)), C.Not(C.HasItemOrBank(7667))),
        },
        -- An Easy Pickup
        [3450] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(3449), C.QuestRewarded(3449)),
        },
        -- You Scream, I Scream...
        [4822] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(1687), C.QuestRewarded(1558), C.QuestRewarded(1479)),
        },
        -- The Completed Orb of Dar'Orahil
        [4964] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(4963), C.QuestRewarded(4976)),
        },
        -- The Completed Orb of Noh'Orahil
        [4975] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(4962), C.QuestRewarded(4976)),
        },
        -- Duskwing, Oh How I Hate Thee...
        [6135] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(6042), C.QuestRewarded(6022), C.QuestRewarded(6133)),
        },
        -- The Corpulent One
        [6136] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(6042), C.QuestRewarded(6022), C.QuestRewarded(6133)),
        },
        -- The Call to Command
        [6144] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(6136), C.QuestRewarded(6135)),
        },
        -- Ramstein
        [6163] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(6136), C.QuestRewarded(6135)),
        },
        -- Libram of Rapidity
        [7483] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(7482), C.QuestRewarded(7481)),
        },
        -- Libram of Focus
        [7484] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(7482), C.QuestRewarded(7481)),
        },
        -- Libram of Protection
        [7485] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(7482), C.QuestRewarded(7481)),
        },
        -- Unfinished Gordok Business
        [7703] = {
            [questKeys.conditions] = C.HasAura(22799),
        },
        -- The Changing of Paths - Protector No More
        [8764] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(8761), C.QuestRewarded(8751), C.QuestRewarded(8756)),
        },
        -- The Changing of Paths - Invoker No More
        [8765] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(8761), C.QuestRewarded(8751), C.QuestRewarded(8756)),
        },
        -- The Changing of Paths - Conqueror No More
        [8766] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(8761), C.QuestRewarded(8751), C.QuestRewarded(8756)),
        },
    }
end
