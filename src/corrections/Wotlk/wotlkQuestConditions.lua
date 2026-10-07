-- AUTO GENERATED FILE! DO NOT EDIT!
-- Quest availability expressions converted from server-emulator condition tables.
-- Written with src/corrections/conditionBuilder.lua; the vocabulary is in src/conditions.lua.
---@class QuestieWotlkQuestConditions
local QuestieWotlkQuestConditions = QuestieLoader:CreateModule("QuestieWotlkQuestConditions")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local C = QuestieLoader:ImportModule("ConditionBuilder")

function QuestieWotlkQuestConditions:Load()
    local questKeys = QuestieDB.questKeys
    local factionIDs = QuestieDB.factionIDs

    return {
        -- Kurzen's Mystery
        [207] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(203), C.QuestRewarded(204)),
        },
        -- Distracting Jarven
        [308] = {
            [questKeys.conditions] = C.QuestInLog(310),
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
        -- Underworld Loam
        [10667] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10666), C.QuestRewarded(10665)),
        },
        -- Against the Illidari
        [10668] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10689), C.QuestRewarded(10640)),
        },
        -- Against All Odds
        [10669] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(10689), C.QuestRewarded(10640)),
        },
        -- Tear of the Earthmother
        [10670] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10666), C.QuestRewarded(10665)),
        },
        -- Bane of the Illidari
        [10676] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10670), C.QuestRewarded(10667)),
        },
        -- Surrender to the Horde
        [10862] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10863)), C.Not(C.QuestInLog(10908)), C.QuestNone(10847)),
        },
        -- Secrets of the Arakkoa
        [10863] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10862)), C.Not(C.QuestInLog(10908)), C.QuestNone(10847)),
        },
        -- The Mark of Vashj
        [10900] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10885), C.QuestRewarded(10884), C.QuestRewarded(10886)),
        },
        -- Speak with Rilak the Redeemed
        [10908] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(10862)), C.Not(C.QuestInLog(10863)), C.QuestNone(10847)),
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
        -- The Enigmatic Frost Nymphs
        [11302] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11269), C.QuestRewarded(11329), C.QuestRewarded(11284), C.QuestRewarded(11292)),
        },
        -- Spawn of the Twisted Glade
        [11316] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(11315), C.QuestRewarded(11314)),
        },
        -- Seeds of the Blacksouled Keepers
        [11319] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(11315), C.QuestRewarded(11314)),
        },
        -- The Book of Runes
        [11346] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11269), C.QuestRewarded(11329), C.QuestRewarded(11284), C.QuestRewarded(11292)),
        },
        -- March of the Giants
        [11355] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11269), C.QuestRewarded(11329), C.QuestRewarded(11284), C.QuestRewarded(11292)),
        },
        -- Keeper Witherleaf
        [11428] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(11319), C.QuestRewarded(11316)),
        },
        -- Outpost Over Yonder...
        [11478] = {
            [questKeys.conditions] = C.QuestInLog(11485),
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
        -- Hellscream's Vigil
        [11585] = {
            [questKeys.conditions] = C.QuestNone(10212),
        },
        -- Hellscream's Vigil
        [11586] = {
            [questKeys.conditions] = C.QuestRewarded(10212),
        },
        -- The Defense of Warsong Hold
        [11595] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(7783), C.Any(C.QuestRewarded(11586), C.QuestRewarded(11585))),
        },
        -- The Defense of Warsong Hold
        [11596] = {
            [questKeys.conditions] = C.All(C.Not(C.HasAchievement(416)), C.QuestNone(7783), C.Any(C.QuestRewarded(11586), C.QuestRewarded(11585))),
        },
        -- The Defense of Warsong Hold
        [11597] = {
            [questKeys.conditions] = C.All(C.HasAchievement(416), C.QuestNone(7783), C.Any(C.QuestRewarded(11586), C.QuestRewarded(11585))),
        },
        -- Patience is a Virtue that We Don't Need
        [11606] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11597), C.QuestRewarded(11596), C.QuestRewarded(11595)),
        },
        -- Taken by the Scourge
        [11611] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11597), C.QuestRewarded(11596), C.QuestRewarded(11595)),
        },
        -- Seek Out Karuk!
        [11662] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(11661), C.QuestRewarded(11656)),
        },
        -- Gaining the Advantage
        [11875] = {
            [questKeys.conditions] = C.Any(C.KnowsSpell(29354), C.KnowsSpell(28695), C.KnowsSpell(32678)),
        },
        -- Hellscream's Champion
        [11916] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(11705), C.QuestRewarded(11652), C.QuestRewarded(11722)),
        },
        -- Striking Back
        [11917] = {
            [questKeys.conditions] = C.HasAura(25688),
        },
        -- Striking Back
        [11947] = {
            [questKeys.conditions] = C.All(C.QuestInLog(11296), C.Not(C.QuestComplete(11296))),
        },
        -- Striking Back
        [11948] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(48), C.Not(C.All(C.QuestInLog(11296), C.Not(C.QuestComplete(11296))))),
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
        -- Your Presence is Required at Agmar's Hammer
        [11996] = {
            [questKeys.conditions] = C.QuestNone(12008),
        },
        -- Rifle the Bodies
        [11999] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(11996), C.QuestRewarded(12034)),
        },
        -- Message from the West
        [12033] = {
            [questKeys.conditions] = C.QuestRewarded(11916),
        },
        -- Victory Nears...
        [12034] = {
            [questKeys.conditions] = C.QuestRewarded(12008),
        },
        -- Black Blood of Yogg-Saron
        [12039] = {
            [questKeys.conditions] = C.QuestRewarded(12034),
        },
        -- Lumber Hack
        [12050] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12047), C.QuestRewarded(12046)),
        },
        -- Harp on This!
        [12052] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12047), C.QuestRewarded(12046)),
        },
        -- Marked for Death: High Cultist Zangus
        [12056] = {
            [questKeys.conditions] = C.QuestRewarded(12034),
        },
        -- Strength of Icemist
        [12063] = {
            [questKeys.conditions] = C.QuestRewarded(12036),
        },
        -- Worm Wrangler
        [12078] = {
            [questKeys.conditions] = C.QuestRewarded(12077),
        },
        -- Stomping Grounds
        [12079] = {
            [questKeys.conditions] = C.QuestRewarded(12075),
        },
        -- Really Big Worm
        [12080] = {
            [questKeys.conditions] = C.QuestRewarded(12077),
        },
        -- Strengthen the Ancients
        [12092] = {
            [questKeys.conditions] = C.QuestRewarded(12065),
        },
        -- To Dragon's Fall
        [12095] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12091), C.QuestRewarded(12090), C.QuestRewarded(12089)),
        },
        -- Strengthen the Ancients
        [12096] = {
            [questKeys.conditions] = C.QuestRewarded(12066),
        },
        -- Containing the Rot
        [12100] = {
            [questKeys.conditions] = C.QuestRewarded(12034),
        },
        -- Stiff Negotiations
        [12112] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12052), C.QuestRewarded(12050)),
        },
        -- Travel to Moa'ki Harbor
        [12117] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(12118)), C.Not(C.QuestRewarded(12118))),
        },
        -- Travel to Moa'ki Harbor
        [12118] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(12117)), C.Not(C.QuestRewarded(12117))),
        },
        -- The Power to Destroy
        [12132] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12127), C.QuestRewarded(12126), C.QuestRewarded(12125)),
        },
        -- Of Traitors and Treason
        [12171] = {
            [questKeys.conditions] = C.All(C.Any(C.Not(C.QuestInLog(12297)), C.Not(C.QuestRewarded(12297))), C.QuestRewarded(12157)),
        },
        -- To Venomspite!
        [12182] = {
            [questKeys.conditions] = C.QuestNone(12182),
        },
        -- Imbeciles Abound!
        [12189] = {
            [questKeys.conditions] = C.QuestNone(12182),
        },
        -- Vordrassil's Fall
        [12207] = {
            [questKeys.conditions] = C.QuestRewarded(12413),
        },
        -- Good Troll Hunting
        [12208] = {
            [questKeys.conditions] = C.QuestRewarded(12412),
        },
        -- Troll Season!
        [12210] = {
            [questKeys.conditions] = C.QuestRewarded(12212),
        },
        -- The Darkness Beneath
        [12213] = {
            [questKeys.conditions] = C.QuestRewarded(12413),
        },
        -- The Kor'kron Vanguard!
        [12224] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12072), C.QuestRewarded(12140), C.QuestRewarded(12221)),
        },
        -- A Possible Link
        [12229] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12207), C.QuestRewarded(12213)),
        },
        -- The Bear God's Offspring
        [12231] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12207), C.QuestRewarded(12213)),
        },
        -- Naxxramas and the Fall of Wintergarde
        [12235] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(12298), C.QuestRewarded(12174)),
        },
        -- Ursoc, the Bear God
        [12236] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12242), C.QuestRewarded(12241)),
        },
        -- Destroy the Sapling
        [12241] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12231), C.QuestRewarded(12229)),
        },
        -- Vordrassil's Seeds
        [12242] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12231), C.QuestRewarded(12229)),
        },
        -- The Flamebinders' Secrets
        [12256] = {
            [questKeys.conditions] = C.QuestRewarded(12468),
        },
        -- The Fate of the Dead
        [12258] = {
            [questKeys.conditions] = C.QuestRewarded(12251),
        },
        -- The Thane of Voldrune
        [12259] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12257), C.QuestRewarded(12256)),
        },
        -- No Place to Run
        [12261] = {
            [questKeys.conditions] = C.QuestRewarded(12447),
        },
        -- No One to Save You
        [12262] = {
            [questKeys.conditions] = C.QuestRewarded(12447),
        },
        -- The Best of Intentions
        [12263] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12262), C.QuestRewarded(12261)),
        },
        -- Culling the Damned
        [12264] = {
            [questKeys.conditions] = C.QuestRewarded(12263),
        },
        -- Defiling the Defilers
        [12265] = {
            [questKeys.conditions] = C.QuestRewarded(12263),
        },
        -- The Bleeding Ore
        [12272] = {
            [questKeys.conditions] = C.QuestRewarded(12275),
        },
        -- Of Traitors and Treason
        [12297] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestRewarded(12171)), C.All(C.Any(C.Not(C.QuestInLog(12297)), C.Not(C.QuestRewarded(12297))), C.QuestRewarded(12157))),
        },
        -- My Enemy's Friend
        [12412] = {
            [questKeys.conditions] = C.QuestRewarded(12259),
        },
        -- The Conquest Pit: Bear Wrestling!
        [12427] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12178), C.QuestRewarded(12422), C.QuestRewarded(12413)),
        },
        -- Eyes Above
        [12453] = {
            [questKeys.conditions] = C.QuestRewarded(12412),
        },
        -- Breaking Off A Piece
        [12462] = {
            [questKeys.conditions] = C.QuestRewarded(12326),
        },
        -- Return to Sender
        [12469] = {
            [questKeys.conditions] = C.QuestNone(12044),
        },
        -- The High Executor Needs You
        [12488] = {
            [questKeys.conditions] = C.QuestNone(12487),
        },
        -- Return To Angrathar
        [12499] = {
            [questKeys.conditions] = C.QuestRewarded(12498),
        },
        -- Return To Angrathar
        [12500] = {
            [questKeys.conditions] = C.QuestRewarded(12498),
        },
        -- Troll Patrol: High Standards
        [12502] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Troll Patrol: Intestinal Fortitude
        [12509] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Troll Patrol: Whatdya Want, a Medal?
        [12519] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- The Wasp Hunter's Apprentice
        [12533] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12529), C.QuestRewarded(12530)),
        },
        -- The Sapphire Queen
        [12534] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12529), C.QuestRewarded(12530)),
        },
        -- A Rough Ride
        [12536] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12535), C.QuestRewarded(12531)),
        },
        -- Hoofing It
        [12539] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12538), C.QuestRewarded(12537)),
        },
        -- Troll Patrol: The Alchemist's Apprentice
        [12541] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Dreadsaber Mastery: Becoming a Predator
        [12549] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12525), C.QuestRewarded(12523)),
        },
        -- An Issue of Trust
        [12561] = {
            [questKeys.conditions] = C.KnowsSpell(54197),
        },
        -- Troll Patrol: Something for the Pain
        [12564] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Troll Patrol: Done to Death
        [12568] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Back So Soon?
        [12574] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12573), C.QuestRewarded(12572)),
        },
        -- Home Time!
        [12577] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12576), C.QuestRewarded(12575)),
        },
        -- A Hero's Burden
        [12581] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12580), C.QuestRewarded(12579)),
        },
        -- Troll Patrol: Creature Comforts
        [12585] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Troll Patrol: Can You Dig It?
        [12588] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Kick, What Kick?
        [12589] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12525), C.QuestRewarded(12523)),
        },
        -- Troll Patrol: Throwing Down
        [12591] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- Troll Patrol: Couldn't Care Less
        [12594] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(12563), C.QuestInLog(12501), C.QuestInLog(12587)),
        },
        -- In Search of Bigger Game
        [12595] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12556), C.QuestRewarded(12569), C.QuestRewarded(12558)),
        },
        -- Sharpening Your Talons
        [12603] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12556), C.QuestRewarded(12569), C.QuestRewarded(12558)),
        },
        -- Congratulations!
        [12604] = {
            [questKeys.conditions] = C.All(C.HasAura(51573), C.Any(C.QuestRewarded(12563), C.QuestRewarded(12501), C.QuestRewarded(12587))),
        },
        -- Securing the Bait
        [12605] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12556), C.QuestRewarded(12569), C.QuestRewarded(12558)),
        },
        -- A Mammoth Undertaking
        [12607] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12605), C.QuestRewarded(12603)),
        },
        -- Some Make Lemonade, Some Make Liquor
        [12634] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12549), C.QuestRewarded(12520)),
        },
        -- My Pet Roc
        [12658] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12605), C.QuestRewarded(12603)),
        },
        -- Reunited
        [12663] = {
            [questKeys.conditions] = C.QuestRewarded(12238),
        },
        -- Dark Horizon
        [12664] = {
            [questKeys.conditions] = C.QuestNone(12238),
        },
        -- Reagent Agent
        [12681] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12605), C.QuestRewarded(12603)),
        },
        -- Burning to Help
        [12683] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12556), C.QuestRewarded(12569), C.QuestRewarded(12558)),
        },
        -- Return of the Lich Hunter
        [12692] = {
            [questKeys.conditions] = C.HasRep(factionIDs.FRENZYHEART_TRIBE, C.standing.HONORED),
        },
        -- Return of the Friendly Dryskin
        [12695] = {
            [questKeys.conditions] = C.HasRep(factionIDs.THE_ORACLES, C.standing.HONORED),
        },
        -- Behind Scarlet Lines
        [12723] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12717), C.QuestRewarded(12719), C.QuestRewarded(12722)),
        },
        -- The Magical Kingdom of Dalaran
        [12791] = {
            [questKeys.conditions] = C.QuestNone(12796),
        },
        -- The Magical Kingdom of Dalaran
        [12794] = {
            [questKeys.conditions] = C.QuestNone(12796),
        },
        -- Taking a Stand
        [12795] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(12503)), C.Not(C.QuestRewarded(12503))),
        },
        -- The Magical Kingdom of Dalaran
        [12796] = {
            [questKeys.conditions] = C.Any(C.QuestNone(12794), C.QuestNone(12791)),
        },
        -- Force of Nature
        [12803] = {
            [questKeys.conditions] = C.KnowsSpell(54197),
        },
        -- A Steak Fit for a Hunter
        [12804] = {
            [questKeys.conditions] = C.QuestRewarded(12520),
        },
        -- From Their Corpses, Rise!
        [12813] = {
            [questKeys.conditions] = C.QuestRewarded(12807),
        },
        -- No Fly Zone
        [12815] = {
            [questKeys.conditions] = C.QuestRewarded(12814),
        },
        -- Intelligence Gathering
        [12838] = {
            [questKeys.conditions] = C.QuestRewarded(12807),
        },
        -- The Amphitheater of Anguish: Yggdras!
        [12932] = {
            [questKeys.conditions] = C.Not(C.QuestRewarded(9977)),
        },
        -- The Amphitheater of Anguish: Magnataur!
        [12933] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(12954), C.QuestRewarded(12932)),
        },
        -- The Amphitheater of Anguish: Yggdras!
        [12954] = {
            [questKeys.conditions] = C.QuestRewarded(9977),
        },
        -- The Champion's Call!
        [12974] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestRewarded(12954)), C.Not(C.QuestInLog(12954)), C.Not(C.QuestRewarded(12932)), C.Not(C.QuestInLog(12932))),
        },
        -- If There Are Survivors...
        [13044] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13040), C.QuestRewarded(13039), C.QuestRewarded(13008)),
        },
        -- Reading the Bones
        [13093] = {
            [questKeys.conditions] = C.QuestRewarded(13092),
        },
        -- Blackwatch
        [13106] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(13117)), C.Not(C.QuestRewarded(13117))),
        },
        -- The Restless Dead
        [13110] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13105), C.QuestRewarded(13104)),
        },
        -- The Purging Of Scourgeholme
        [13118] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13105), C.QuestRewarded(13104)),
        },
        -- The Scourgestone
        [13122] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13105), C.QuestRewarded(13104)),
        },
        -- The Air Stands Still
        [13125] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13118), C.QuestRewarded(13122)),
        },
        -- The Stone That Started A Revolution
        [13130] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13105), C.QuestRewarded(13104)),
        },
        -- It Could Kill Us All
        [13135] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13105), C.QuestRewarded(13104)),
        },
        -- Into The Frozen Heart Of Northrend
        [13139] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13135), C.QuestRewarded(13110), C.QuestRewarded(13130), C.QuestRewarded(13125)),
        },
        -- Killing Two Scourge With One Skeleton
        [13144] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13152), C.QuestRewarded(13211)),
        },
        -- A Visit to the Doctor
        [13152] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13138), C.QuestRewarded(13140), C.QuestRewarded(13134)),
        },
        -- Vereth the Cunning
        [13155] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13174), C.QuestRewarded(13172)),
        },
        -- The Rider of the Unholy
        [13161] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13160), C.QuestRewarded(13147), C.QuestRewarded(13146)),
        },
        -- The Rider of Frost
        [13162] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13160), C.QuestRewarded(13147), C.QuestRewarded(13146)),
        },
        -- The Rider of Blood
        [13163] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13160), C.QuestRewarded(13147), C.QuestRewarded(13146)),
        },
        -- The Fate of Bloodbane
        [13164] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13163), C.QuestRewarded(13162), C.QuestRewarded(13161)),
        },
        -- Seeds of Chaos
        [13172] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13171), C.QuestRewarded(13170), C.QuestRewarded(13169)),
        },
        -- Amidst the Confusion
        [13174] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13171), C.QuestRewarded(13170), C.QuestRewarded(13169)),
        },
        -- By Fire Be Purged
        [13211] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13138), C.QuestRewarded(13140), C.QuestRewarded(13134)),
        },
        -- The Broken Front
        [13228] = {
            [questKeys.conditions] = C.QuestRewarded(13224),
        },
        -- Avenge Me!
        [13230] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(13228), C.QuestRewarded(13228)),
        },
        -- The Broken Front
        [13231] = {
            [questKeys.conditions] = C.QuestRewarded(13225),
        },
        -- Finish Me!
        [13232] = {
            [questKeys.conditions] = C.Any(C.QuestInLog(13231), C.QuestRewarded(13231)),
        },
        -- No Mercy!
        [13233] = {
            [questKeys.conditions] = C.QuestRewarded(13231),
        },
        -- Make Them Pay!
        [13234] = {
            [questKeys.conditions] = C.QuestRewarded(13228),
        },
        -- Good For Something?
        [13238] = {
            [questKeys.conditions] = C.QuestRewarded(13228),
        },
        -- Opportunity
        [13258] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(12899), C.QuestRewarded(13224)),
        },
        -- Takes One to Know One
        [13260] = {
            [questKeys.conditions] = C.QuestRewarded(13228),
        },
        -- Volatility
        [13261] = {
            [questKeys.conditions] = C.QuestRewarded(13239),
        },
        -- That's Abominable!
        [13264] = {
            [questKeys.conditions] = C.QuestRewarded(13237),
        },
        -- That's Abominable!
        [13276] = {
            [questKeys.conditions] = C.QuestRewarded(13264),
        },
        -- Against the Giants
        [13277] = {
            [questKeys.conditions] = C.QuestRewarded(13237),
        },
        -- Coprous the Defiled
        [13278] = {
            [questKeys.conditions] = C.QuestRewarded(13277),
        },
        -- Neutralizing the Plague
        [13281] = {
            [questKeys.conditions] = C.QuestRewarded(13279),
        },
        -- Assault by Ground
        [13284] = {
            [questKeys.conditions] = C.QuestRewarded(13341),
        },
        -- ...All the Help We Can Get.
        [13286] = {
            [questKeys.conditions] = C.QuestRewarded(13231),
        },
        -- That's Abominable!
        [13288] = {
            [questKeys.conditions] = C.QuestRewarded(13287),
        },
        -- That's Abominable!
        [13289] = {
            [questKeys.conditions] = C.QuestRewarded(13288),
        },
        -- Your Attention, Please
        [13290] = {
            [questKeys.conditions] = C.QuestRewarded(13231),
        },
        -- The Solution Solution
        [13292] = {
            [questKeys.conditions] = C.QuestRewarded(13291),
        },
        -- Get to Ymirheim!
        [13293] = {
            [questKeys.conditions] = C.QuestRewarded(13224),
        },
        -- Against the Giants
        [13294] = {
            [questKeys.conditions] = C.QuestRewarded(13287),
        },
        -- Get to Ymirheim!
        [13296] = {
            [questKeys.conditions] = C.QuestRewarded(13225),
        },
        -- Neutralizing the Plague
        [13297] = {
            [questKeys.conditions] = C.QuestRewarded(13295),
        },
        -- Coprous the Defiled
        [13298] = {
            [questKeys.conditions] = C.QuestRewarded(13294),
        },
        -- Slaves to Saronite
        [13300] = {
            [questKeys.conditions] = C.QuestRewarded(13225),
        },
        -- Assault by Ground
        [13301] = {
            [questKeys.conditions] = C.QuestRewarded(13340),
        },
        -- Slaves to Saronite
        [13302] = {
            [questKeys.conditions] = C.QuestRewarded(13224),
        },
        -- Raise the Barricades
        [13306] = {
            [questKeys.conditions] = C.QuestRewarded(13366),
        },
        -- Bloodspattered Banners
        [13307] = {
            [questKeys.conditions] = C.QuestRewarded(13306),
        },
        -- Mind Tricks
        [13308] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13225), C.QuestRewarded(13224)),
        },
        -- Assault by Air
        [13309] = {
            [questKeys.conditions] = C.QuestRewarded(13341),
        },
        -- Assault by Air
        [13310] = {
            [questKeys.conditions] = C.QuestRewarded(13340),
        },
        -- The Ironwall Rampart
        [13312] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13367), C.QuestRewarded(13306)),
        },
        -- Blinding the Eyes in the Sky
        [13313] = {
            [questKeys.conditions] = C.QuestRewarded(13306),
        },
        -- Get the Message
        [13314] = {
            [questKeys.conditions] = C.QuestRewarded(13332),
        },
        -- Sneak Preview
        [13315] = {
            [questKeys.conditions] = C.QuestRewarded(13288),
        },
        -- The Guardians of Corp'rethar
        [13316] = {
            [questKeys.conditions] = C.QuestRewarded(13329),
        },
        -- Drag and Drop
        [13318] = {
            [questKeys.conditions] = C.QuestRewarded(13315),
        },
        -- Chain of Command
        [13319] = {
            [questKeys.conditions] = C.QuestRewarded(13315),
        },
        -- Cannot Reproduce
        [13320] = {
            [questKeys.conditions] = C.QuestRewarded(13315),
        },
        -- Retest Now
        [13322] = {
            [questKeys.conditions] = C.QuestRewarded(13321),
        },
        -- Drag and Drop
        [13323] = {
            [questKeys.conditions] = C.QuestInLog(13145),
        },
        -- Shatter the Shards
        [13328] = {
            [questKeys.conditions] = C.QuestRewarded(13329),
        },
        -- Before the Gate of Horror
        [13329] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13312), C.QuestRewarded(13307)),
        },
        -- Blood of the Chosen
        [13330] = {
            [questKeys.conditions] = C.QuestRewarded(13224),
        },
        -- Keeping the Alliance Blind
        [13331] = {
            [questKeys.conditions] = C.QuestRewarded(13313),
        },
        -- Raise the Barricades
        [13332] = {
            [questKeys.conditions] = C.QuestRewarded(13345),
        },
        -- Capture More Dispatches
        [13333] = {
            [questKeys.conditions] = C.QuestRewarded(13314),
        },
        -- Bloodspattered Banners
        [13334] = {
            [questKeys.conditions] = C.QuestRewarded(13332),
        },
        -- Before the Gate of Horror
        [13335] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13337), C.QuestRewarded(13334)),
        },
        -- Blood of the Chosen
        [13336] = {
            [questKeys.conditions] = C.QuestRewarded(13225),
        },
        -- The Ironwall Rampart
        [13337] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13346), C.QuestRewarded(13332)),
        },
        -- The Guardians of Corp'rethar
        [13338] = {
            [questKeys.conditions] = C.QuestRewarded(13335),
        },
        -- Shatter the Shards
        [13339] = {
            [questKeys.conditions] = C.QuestRewarded(13335),
        },
        -- Joining the Assault
        [13340] = {
            [questKeys.conditions] = C.QuestRewarded(13224),
        },
        -- Joining the Assault
        [13341] = {
            [questKeys.conditions] = C.QuestRewarded(13225),
        },
        -- Not a Bug
        [13342] = {
            [questKeys.conditions] = C.QuestInLog(13145),
        },
        -- Not a Bug
        [13344] = {
            [questKeys.conditions] = C.QuestRewarded(13342),
        },
        -- Need More Info
        [13345] = {
            [questKeys.conditions] = C.QuestInLog(13145),
        },
        -- No Rest For The Wicked
        [13346] = {
            [questKeys.conditions] = C.QuestRewarded(13345),
        },
        -- No Rest For The Wicked
        [13350] = {
            [questKeys.conditions] = C.QuestRewarded(13346),
        },
        -- Sneak Preview
        [13351] = {
            [questKeys.conditions] = C.QuestRewarded(13264),
        },
        -- Drag and Drop
        [13352] = {
            [questKeys.conditions] = C.QuestRewarded(13351),
        },
        -- Drag and Drop
        [13353] = {
            [questKeys.conditions] = C.QuestRewarded(13352),
        },
        -- Chain of Command
        [13354] = {
            [questKeys.conditions] = C.QuestRewarded(13351),
        },
        -- Cannot Reproduce
        [13355] = {
            [questKeys.conditions] = C.QuestRewarded(13351),
        },
        -- Retest Now
        [13357] = {
            [questKeys.conditions] = C.QuestRewarded(13356),
        },
        -- Not a Bug
        [13358] = {
            [questKeys.conditions] = C.QuestRewarded(13352),
        },
        -- Where Dragons Fell
        [13359] = {
            [questKeys.conditions] = C.QuestRewarded(13348),
        },
        -- Time for Answers
        [13360] = {
            [questKeys.conditions] = C.QuestRewarded(13359),
        },
        -- Argent Aid
        [13363] = {
            [questKeys.conditions] = C.QuestRewarded(13362),
        },
        -- Not a Bug
        [13365] = {
            [questKeys.conditions] = C.QuestRewarded(13358),
        },
        -- Need More Info
        [13366] = {
            [questKeys.conditions] = C.QuestRewarded(13352),
        },
        -- No Rest For The Wicked
        [13367] = {
            [questKeys.conditions] = C.QuestRewarded(13366),
        },
        -- No Rest For The Wicked
        [13368] = {
            [questKeys.conditions] = C.QuestRewarded(13367),
        },
        -- Total Ohmage: The Valley of Lost Hope!
        [13376] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13373), C.Not(C.QuestInLog(13406))),
        },
        -- Green Technology
        [13379] = {
            [questKeys.conditions] = C.QuestRewarded(13239),
        },
        -- Putting the Hertz: The Valley of Lost Hope
        [13382] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13380), C.Not(C.QuestInLog(13404))),
        },
        -- Killohertz
        [13383] = {
            [questKeys.conditions] = C.QuestRewarded(13291),
        },
        -- Exploiting an Opening
        [13386] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13225), C.QuestRewarded(12898)),
        },
        -- Where Dragons Fell
        [13398] = {
            [questKeys.conditions] = C.QuestRewarded(13396),
        },
        -- Time for Answers
        [13399] = {
            [questKeys.conditions] = C.QuestRewarded(13398),
        },
        -- Tirion's Help
        [13402] = {
            [questKeys.conditions] = C.QuestRewarded(13401),
        },
        -- Static Shock Troops: the Bombardment
        [13404] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13380), C.Not(C.QuestInLog(13382))),
        },
        -- Riding the Wavelength: The Bombardment
        [13406] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13373), C.Not(C.QuestInLog(13376))),
        },
        -- Trial of the Naaru: Magtheridon
        [13430] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(10885), C.QuestRewarded(10884), C.QuestRewarded(10886)),
        },
        -- Let's Get Out of Here!
        [13481] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(13229)), C.Not(C.QuestRewarded(13229))),
        },
        -- Let's Get Out of Here
        [13482] = {
            [questKeys.conditions] = C.Any(C.Not(C.QuestInLog(13221)), C.Not(C.QuestRewarded(13221))),
        },
        -- A Valiant's Field Training
        [13592] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- Valiant Of Stormwind
        [13593] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13706)), C.Not(C.QuestInLog(13705)), C.Not(C.QuestInLog(13704)), C.Not(C.QuestInLog(13703)), C.Not(C.QuestRewarded(13686))),
        },
        -- A Worthy Weapon
        [13600] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- A Blade Fit For A Champion
        [13603] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- The Edge Of Winter
        [13616] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- The Black Knight of Westfall?
        [13633] = {
            [questKeys.conditions] = C.QuestRewarded(13667),
        },
        -- The Black Knight of Silverpine?
        [13634] = {
            [questKeys.conditions] = C.QuestRewarded(13668),
        },
        -- The Grand Melee
        [13665] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- The Valiant's Charge
        [13697] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13687), C.Any(C.QuestRewarded(13707), C.QuestRewarded(13691)), C.IsTeam("Horde")),
        },
        -- Valiant Of Ironforge
        [13703] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13706)), C.Not(C.QuestInLog(13705)), C.Not(C.QuestInLog(13704)), C.Not(C.QuestInLog(13593)), C.Not(C.QuestRewarded(13686))),
        },
        -- Valiant Of Gnomeregan
        [13704] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13706)), C.Not(C.QuestInLog(13705)), C.Not(C.QuestInLog(13703)), C.Not(C.QuestInLog(13593)), C.Not(C.QuestRewarded(13686))),
        },
        -- Valiant Of The Exodar
        [13705] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13706)), C.Not(C.QuestInLog(13704)), C.Not(C.QuestInLog(13703)), C.Not(C.QuestInLog(13593)), C.Not(C.QuestRewarded(13686))),
        },
        -- Valiant Of Darnassus
        [13706] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13705)), C.Not(C.QuestInLog(13704)), C.Not(C.QuestInLog(13703)), C.Not(C.QuestInLog(13593)), C.Not(C.QuestRewarded(13686))),
        },
        -- Valiant Of Orgrimmar
        [13707] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13711)), C.Not(C.QuestInLog(13710)), C.Not(C.QuestInLog(13709)), C.Not(C.QuestInLog(13708)), C.Not(C.QuestRewarded(13687))),
        },
        -- Valiant Of Sen'jin
        [13708] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13711)), C.Not(C.QuestInLog(13710)), C.Not(C.QuestInLog(13709)), C.Not(C.QuestInLog(13707)), C.Not(C.QuestRewarded(13687))),
        },
        -- Valiant Of Thunder Bluff
        [13709] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13711)), C.Not(C.QuestInLog(13710)), C.Not(C.QuestInLog(13708)), C.Not(C.QuestInLog(13707)), C.Not(C.QuestRewarded(13687))),
        },
        -- Valiant Of Undercity
        [13710] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13711)), C.Not(C.QuestInLog(13709)), C.Not(C.QuestInLog(13708)), C.Not(C.QuestInLog(13707)), C.Not(C.QuestRewarded(13687))),
        },
        -- Valiant Of Silvermoon
        [13711] = {
            [questKeys.conditions] = C.All(C.Not(C.QuestInLog(13710)), C.Not(C.QuestInLog(13709)), C.Not(C.QuestInLog(13708)), C.Not(C.QuestInLog(13707)), C.Not(C.QuestRewarded(13687))),
        },
        -- The Valiant's Charge
        [13714] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13686), C.Any(C.QuestRewarded(13703), C.QuestRewarded(13685)), C.IsTeam("Alliance")),
        },
        -- The Valiant's Charge
        [13715] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13686), C.Any(C.QuestRewarded(13704), C.QuestRewarded(13688)), C.IsTeam("Alliance")),
        },
        -- The Valiant's Charge
        [13716] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13686), C.Any(C.QuestRewarded(13705), C.QuestRewarded(13690)), C.IsTeam("Alliance")),
        },
        -- The Valiant's Charge
        [13717] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13686), C.Any(C.QuestRewarded(13706), C.QuestRewarded(13689)), C.IsTeam("Alliance")),
        },
        -- The Valiant's Charge
        [13718] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13686), C.Any(C.QuestRewarded(13593), C.QuestRewarded(13684)), C.IsTeam("Alliance")),
        },
        -- The Valiant's Charge
        [13719] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13687), C.Any(C.QuestRewarded(13708), C.QuestRewarded(13693)), C.IsTeam("Horde")),
        },
        -- The Valiant's Charge
        [13720] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13687), C.Any(C.QuestRewarded(13709), C.QuestRewarded(13694)), C.IsTeam("Horde")),
        },
        -- The Valiant's Charge
        [13721] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13687), C.Any(C.QuestRewarded(13710), C.QuestRewarded(13695)), C.IsTeam("Horde")),
        },
        -- The Valiant's Charge
        [13722] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(13687), C.Any(C.QuestRewarded(13711), C.QuestRewarded(13696)), C.IsTeam("Horde")),
        },
        -- A Blade Fit For A Champion
        [13741] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- A Worthy Weapon
        [13742] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- The Edge Of Winter
        [13743] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- A Valiant's Field Training
        [13744] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- The Grand Melee
        [13745] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- A Blade Fit For A Champion
        [13746] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- A Worthy Weapon
        [13747] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- The Edge Of Winter
        [13748] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- A Valiant's Field Training
        [13749] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- The Grand Melee
        [13750] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- A Blade Fit For A Champion
        [13752] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- A Worthy Weapon
        [13753] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- The Edge Of Winter
        [13754] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- A Valiant's Field Training
        [13755] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- The Grand Melee
        [13756] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- A Blade Fit For A Champion
        [13757] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- A Worthy Weapon
        [13758] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- The Edge Of Winter
        [13759] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- A Valiant's Field Training
        [13760] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- The Grand Melee
        [13761] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- A Blade Fit For A Champion
        [13762] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- A Worthy Weapon
        [13763] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- The Edge Of Winter
        [13764] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- A Valiant's Field Training
        [13765] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- The Grand Melee
        [13767] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- A Blade Fit For A Champion
        [13768] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- A Worthy Weapon
        [13769] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- The Edge Of Winter
        [13770] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- A Valiant's Field Training
        [13771] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- The Grand Melee
        [13772] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- A Blade Fit For A Champion
        [13773] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- A Worthy Weapon
        [13774] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- The Edge Of Winter
        [13775] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- A Valiant's Field Training
        [13776] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- The Grand Melee
        [13777] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- A Blade Fit For A Champion
        [13778] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- A Worthy Weapon
        [13779] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- The Edge Of Winter
        [13780] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- A Valiant's Field Training
        [13781] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- The Grand Melee
        [13782] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- A Blade Fit For A Champion
        [13783] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- A Worthy Weapon
        [13784] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- The Edge Of Winter
        [13785] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- A Valiant's Field Training
        [13786] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- The Grand Melee
        [13787] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- Taking Battle To The Enemy
        [13789] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Among the Champions
        [13790] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Taking Battle To The Enemy
        [13791] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Among the Champions
        [13793] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Taking Battle To The Enemy
        [13810] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Among the Champions
        [13811] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Taking Battle To The Enemy
        [13813] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Among the Champions
        [13814] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Contributin' To The Cause
        [13846] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- At The Enemy's Gates
        [13847] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13593), C.IsRace(1100)), C.All(C.Not(C.QuestRewarded(13699)), C.QuestRewarded(13684), C.IsRace(1))),
        },
        -- At The Enemy's Gates
        [13851] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13703), C.IsRace(1097)), C.All(C.Not(C.QuestRewarded(13713)), C.QuestRewarded(13685), C.IsRace(4))),
        },
        -- At The Enemy's Gates
        [13852] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13704), C.IsRace(1037)), C.All(C.Not(C.QuestRewarded(13723)), C.QuestRewarded(13688), C.IsRace(64))),
        },
        -- At The Enemy's Gates
        [13854] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13705), C.IsRace(77)), C.All(C.Not(C.QuestRewarded(13724)), C.QuestRewarded(13690), C.IsRace(1024))),
        },
        -- At The Enemy's Gates
        [13855] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13706), C.IsRace(1093)), C.All(C.Not(C.QuestRewarded(13725)), C.QuestRewarded(13689), C.IsRace(8))),
        },
        -- At The Enemy's Gates
        [13856] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13707), C.IsRace(688)), C.All(C.Not(C.QuestRewarded(13726)), C.QuestRewarded(13691), C.IsRace(2))),
        },
        -- At The Enemy's Gates
        [13857] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13708), C.IsRace(562)), C.All(C.Not(C.QuestRewarded(13727)), C.QuestRewarded(13693), C.IsRace(128))),
        },
        -- At The Enemy's Gates
        [13858] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13709), C.IsRace(658)), C.All(C.Not(C.QuestRewarded(13728)), C.QuestRewarded(13694), C.IsRace(32))),
        },
        -- At The Enemy's Gates
        [13859] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13711), C.IsRace(178)), C.All(C.Not(C.QuestRewarded(13731)), C.QuestRewarded(13696), C.IsRace(512))),
        },
        -- At The Enemy's Gates
        [13860] = {
            [questKeys.conditions] = C.Any(C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13710), C.IsRace(674)), C.All(C.Not(C.QuestRewarded(13729)), C.QuestRewarded(13695), C.IsRace(16))),
        },
        -- Battle Before The Citadel
        [13861] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Battle Before The Citadel
        [13862] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Battle Before The Citadel
        [13863] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Battle Before The Citadel
        [13864] = {
            [questKeys.conditions] = C.Any(C.QuestRewarded(13725), C.QuestRewarded(13731), C.QuestRewarded(13729), C.QuestRewarded(13726), C.QuestRewarded(13699), C.QuestRewarded(13713), C.QuestRewarded(13723), C.QuestRewarded(13724), C.QuestRewarded(13728), C.QuestRewarded(13727)),
        },
        -- Drottinn Hrothgar
        [14101] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- Mistcaller Yngvar
        [14102] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- Ornolf The Scarred
        [14104] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- Deathspeaker Kharos
        [14105] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- The Fate Of The Fallen
        [14107] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- Get Kraken!
        [14108] = {
            [questKeys.conditions] = C.Any(C.HasAchievement(2816), C.HasAchievement(2817)),
        },
        -- The Call to Command
        [14349] = {
            [questKeys.conditions] = C.All(C.QuestRewarded(6136), C.QuestRewarded(6135)),
        },
        -- Crushing the Crown
        [24638] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(13), C.IsLevel(5)),
        },
        -- Crushing the Crown
        [24645] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(22), C.IsLevel(14)),
        },
        -- Crushing the Crown
        [24647] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(31), C.IsLevel(23)),
        },
        -- Crushing the Crown
        [24648] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(40), C.IsLevel(32)),
        },
        -- Crushing the Crown
        [24649] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(50), C.IsLevel(41)),
        },
        -- Crushing the Crown
        [24650] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(60), C.IsLevel(51)),
        },
        -- Crushing the Crown
        [24651] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(70), C.IsLevel(61)),
        },
        -- Crushing the Crown
        [24652] = {
            [questKeys.conditions] = C.IsLevel(71),
        },
        -- Crushing the Crown
        [24658] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(13), C.IsLevel(5)),
        },
        -- Crushing the Crown
        [24659] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(22), C.IsLevel(14)),
        },
        -- Crushing the Crown
        [24660] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(31), C.IsLevel(23)),
        },
        -- Crushing the Crown
        [24662] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(40), C.IsLevel(32)),
        },
        -- Crushing the Crown
        [24663] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(50), C.IsLevel(41)),
        },
        -- Crushing the Crown
        [24664] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(60), C.IsLevel(51)),
        },
        -- Crushing the Crown
        [24665] = {
            [questKeys.conditions] = C.All(C.IsLevelBelow(70), C.IsLevel(61)),
        },
        -- Crushing the Crown
        [24666] = {
            [questKeys.conditions] = C.IsLevel(71),
        },
    }
end
