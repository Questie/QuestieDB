-- AUTO GENERATED FILE! DO NOT EDIT!
-- Quest availability expressions converted from server-emulator condition tables.
-- Written with src/corrections/conditionBuilder.lua; the vocabulary is in src/conditions.lua.
---@class QuestieTBCQuestConditions
local QuestieTBCQuestConditions = QuestieLoader:CreateModule("QuestieTBCQuestConditions")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local C = QuestieLoader:ImportModule("ConditionBuilder")

function QuestieTBCQuestConditions:Load()
    local questKeys = QuestieDB.questKeys

    return {
        -- Kurzen's Mystery
        [207] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(203), C.QuestRewarded(204)),
        },
        -- Distracting Jarven
        [308] = {
            [questKeys.conditions] = C.QuestInLog(310),
        },
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
        -- The Glowing Fruit
        [930] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(919), C.QuestRewarded(918)),
        },
        -- Onu is meditating
        [960] = {
            [questKeys.conditions] = C.Not(C.QuestRewarded(949)),
        },
        -- Onu is meditating
        [961] = {
            [questKeys.conditions] = C.Not(C.QuestRewarded(950)),
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
            [questKeys.conditions] = C.All(C.Not(C.HasItemOrBank(6775)), C.QuestNone(1642)),
        },
        -- The Tome of Divinity
        [1645] = {
            [questKeys.conditions] = C.All(C.Not(C.HasItemOrBank(6916)), C.QuestNone(1646)),
        },
        -- The Symbol of Life
        [1789] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(1783), C.QuestInLog(1784)),
        },
        -- The Symbol of Life
        [1790] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(1786), C.QuestInLog(1787)),
        },
        -- Galvan's Finest Pupil
        [2764] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(2763), C.QuestRewarded(2762), C.QuestRewarded(2761)),
        },
        -- Natural Materials
        [3128] = {
            [questKeys.conditions] = C.QuestRewarded(3122),
        },
        -- Did You Lose This?
        [3321] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(2773), C.QuestRewarded(2772), C.QuestRewarded(2771)),
        },
        -- Replacement Phial
        [3375] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestRewarded(2204)), C.Any(C.QuestInLog(2200), C.QuestRewarded(2200)), C.Not(C.HasItemOrBank(7667))),
        },
        -- An Easy Pickup
        [3450] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(3449), C.QuestRewarded(3449)),
        },
        -- Signal for Pickup
        [3483] = {
            [questKeys.conditions] = C.Not(C.QuestRewarded(3461)),
        },
        -- March of the Silithid
        [4493] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(162), C.QuestRewarded(4267)),
        },
        -- March of the Silithid
        [4494] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(32), C.QuestRewarded(7732)),
        },
        -- Bungle in the Jungle
        [4496] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(4493), C.QuestRewarded(4494)),
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
        -- Minion's Scourgestones
        [5402] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Invader's Scourgestones
        [5403] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Corruptor's Scourgestones
        [5404] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Corruptor's Scourgestones
        [5406] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Invader's Scourgestones
        [5407] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Minion's Scourgestones
        [5408] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Corruptor's Scourgestones
        [5508] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Invader's Scourgestones
        [5509] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
        },
        -- Minion's Scourgestones
        [5510] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(5401), C.QuestRewarded(5405), C.QuestRewarded(5503)),
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
        -- The Good News and The Bad News
        [8728] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(8620), C.QuestRewarded(8587), C.QuestRewarded(8578)),
        },
        -- The Might of Kalimdor
        [8742] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(8729), C.QuestRewarded(8741), C.QuestRewarded(8730)),
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
        -- Help Ranger Valanna!
        [9145] = {
            [questKeys.conditions] = C.QuestNone(9143),
        },
        -- The Sanctum of the Sun
        [9151] = {
            [questKeys.conditions] = C.QuestNone(9220),
        },
        -- Tomber's Supplies
        [9152] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(9329), C.QuestRewarded(9327)),
        },
        -- Culinary Crunch
        [9171] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(9329), C.QuestRewarded(9327)),
        },
        -- Ruthless Cunning
        [9927] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10107), C.QuestRewarded(10108)),
        },
        -- Armaments for Deception
        [9928] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10107), C.QuestRewarded(10108)),
        },
        -- Returning the Favor
        [9931] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(9927), C.QuestRewarded(9928)),
        },
        -- Body of Evidence
        [9932] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(9927), C.QuestRewarded(9928)),
        },
        -- Message to Telaar
        [9933] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(9931), C.QuestRewarded(9932)),
        },
        -- Message to Garadar
        [9934] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(9931), C.QuestRewarded(9932)),
        },
        -- What's Wrong at Cenarion Thicket?
        [9957] = {
            [questKeys.conditions] = C.QuestNone(9968),
        },
        -- What's Wrong at Cenarion Thicket?
        [9960] = {
            [questKeys.conditions] = C.QuestNone(9968),
        },
        -- What's Wrong at Cenarion Thicket?
        [9961] = {
            [questKeys.conditions] = C.QuestNone(9968),
        },
        -- Divination: Gorefiend's Armor
        [10634] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10633), C.QuestRewarded(10644)),
        },
        -- Divination: Gorefiend's Cloak
        [10635] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10633), C.QuestRewarded(10644)),
        },
        -- Divination: Gorefiend's Truncheon
        [10636] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10633), C.QuestRewarded(10644)),
        },
        -- Teron Gorefiend, I am...
        [10639] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10635), C.QuestRewarded(10634), C.QuestRewarded(10636)),
        },
        -- Against the Legion
        [10641] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10689), C.QuestRewarded(10640)),
        },
        -- Teron Gorefiend, I am...
        [10645] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10635), C.QuestRewarded(10634), C.QuestRewarded(10636)),
        },
        -- Against the Illidari
        [10668] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10689), C.QuestRewarded(10640)),
        },
        -- Against All Odds
        [10669] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10689), C.QuestRewarded(10640)),
        },
        -- Surrender to the Horde
        [10862] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10863)), C.Not(C.QuestInLog(10908)), C.QuestNone(10847)),
        },
        -- Secrets of the Arakkoa
        [10863] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10862)), C.Not(C.QuestInLog(10908)), C.QuestNone(10847)),
        },
        -- Speak with Rilak the Redeemed
        [10908] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10862)), C.Not(C.QuestInLog(10863)), C.QuestNone(10847)),
        },
        -- The Seat of the Naaru
        [10956] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10950), C.QuestRewarded(10954), C.QuestRewarded(10952)),
        },
        -- Time to Visit the Caverns
        [10962] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10950), C.QuestRewarded(10954), C.QuestRewarded(10952)),
        },
        -- Time to Visit the Caverns
        [10963] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10945), C.QuestRewarded(10953), C.QuestRewarded(10951)),
        },
        -- Speak with the Ogre
        [10984] = {
            [questKeys.conditions] = C.All(C.QuestNone(10989), C.QuestNone(10983), C.QuestNone(11057)),
        },
        -- Mog'dorg the Wizened
        [10989] = {
            [questKeys.conditions] = C.Not(C.QuestInLog(10984)),
        },
        -- Grulloc Has Two Skulls
        [10995] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10989), C.QuestRewarded(10983), C.QuestRewarded(11057)),
        },
        -- Maggoc's Treasure Chest
        [10996] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10989), C.QuestRewarded(10983), C.QuestRewarded(11057)),
        },
        -- Even Gronn Have Standards
        [10997] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10989), C.QuestRewarded(10983), C.QuestRewarded(11057)),
        },
        -- Speak with Mog'dorg
        [11022] = {
            [questKeys.conditions] = C.QuestNone(11009),
        },
        -- Bomb Them Again!
        [11023] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11010), C.QuestRewarded(11102)),
        },
        -- Archmage No More
        [11031] = {
            [questKeys.conditions] = C.HasItem(29287),
        },
        -- Protector No More
        [11032] = {
            [questKeys.conditions] = C.HasItem(29279),
        },
        -- Assassin No More
        [11033] = {
            [questKeys.conditions] = C.HasItem(29283),
        },
        -- Restorer No More
        [11034] = {
            [questKeys.conditions] = C.HasItem(29290),
        },
        -- The Trouble Below
        [11057] = {
            [questKeys.conditions] = C.Not(C.QuestInLog(10984)),
        },
        -- Wrangle Some Aether Rays!
        [11065] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11010), C.QuestRewarded(11102)),
        },
        -- Assault on Bash'ir Landing!
        [11119] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11010), C.QuestRewarded(11102)),
        },
        -- Agamath, the First Gate
        [11551] = {
            [questKeys.conditions] = C.EventActive(316),
        },
        -- Rohendor, the Second Gate
        [11552] = {
            [questKeys.conditions] = C.EventActive(317),
        },
        -- Archonisus, the Final Gate
        [11553] = {
            [questKeys.conditions] = C.EventActive(318),
        },
        -- Gaining the Advantage
        [11875] = {
            [questKeys.conditions] = C.Any(C.KnowsSpell(29354), C.KnowsSpell(28695), C.KnowsSpell(32678)),
        },
        -- Striking Back
        [11917] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(28), C.IsLevel(22)),
        },
        -- Striking Back
        [11947] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(38), C.IsLevel(29)),
        },
        -- Striking Back
        [11948] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(48), C.IsLevel(39)),
        },
        -- Striking Back
        [11952] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(55), C.IsLevel(49)),
        },
        -- Striking Back
        [11953] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(63), C.IsLevel(56)),
        },
        -- Striking Back
        [11954] = {
            [questKeys.conditions] = C.IsLevel(64),
        },
        -- The Spinner of Summer Tales
        [11971] = {
            [questKeys.conditions] = C.EventActive(1),
        },
        -- Now, When I Grow Up...
        [11975] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10945), C.QuestRewarded(10953), C.QuestRewarded(10951)),
        },
    }
end
