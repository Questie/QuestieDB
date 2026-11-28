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

QuestieCorrections.itemObjectiveFirst[92682] = true
QuestieCorrections.killCreditObjectiveFirst[94489] = true
QuestieCorrections.objectObjectiveFirst[95885] = true
QuestieCorrections.itemObjectiveFirst[97277] = true
QuestieCorrections.itemObjectiveFirst[97485] = true
QuestieCorrections.killCreditObjectiveFirst[98386] = true

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
    local questFlags = QuestieDB.questFlags

    return {
        [19] = { -- Tharil'zun
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {20,98387},
            [questKeys.nextQuestInChain] = 0,
        },
        [20] = { -- Blackrock Menace
            [questKeys.nextQuestInChain] = 0,
        },
        [76] = { -- The Jasperlode Mine
            [questKeys.triggerEnd] = {"Scout through the Jasperlode Mine", {[zoneIDs.ELWYNN_FOREST] = {{61.93,53.16}}}},
        },
        [89] = { -- The Everstill Bridge
            [questKeys.nextQuestInChain] = 98386,
        },
        [99] = { -- Arugal's Folly
            [questKeys.nextQuestInChain] = 98298,
        },
        [115] = { -- Shadow Magic
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {20,98387},
        },
        [151] = { -- Poor Old Blanchy
            [questKeys.startedBy_remove] = {nil,{696264}},
        },
        [169] = { -- WANTED: Gath'Ilzogg
            [questKeys.name] = "WANTED: Gath'Ilzogg",
        },
        [176] = { -- WANTED: "Hogger"
            [questKeys.name] = "WANTED: \"Hogger\"",
        },
        [180] = { -- WANTED: Lieutenant Fangore
            [questKeys.name] = "WANTED: Lieutenant Fangore",
        },
        [205] = { -- Troll Witchery
            [questKeys.nextQuestInChain] = 95786,
        },
        [263] = { -- In Defense of the King's Lands
            [questKeys.nextQuestInChain] = 0,
        },
        [273] = { -- Resupplying the Excavation
            [questKeys.objectives] = {nil,nil,nil,nil,{{{1379,2057},15885,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [275] = { -- Blisters on The Land
            [questKeys.nextQuestInChain] = 98283,
        },
        [286] = { -- Return the Statuette
            [questKeys.nextQuestInChain] = 98189, -- unverified: only the Wowhead series places 98189 after this quest
        },
        [287] = { -- Frostmane Hold
            [questKeys.triggerEnd] = {"Fully explore Frostmane Hold",{[zoneIDs.DUN_MOROGH]={{21.2,54}}}},
            [questKeys.disabledByQuest] = 420,
            [questKeys.nextQuestInChain] = 0,
        },
        [291] = { -- The Reports
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {287,98323},
        },
        [299] = { -- Uncovering the Past
            [questKeys.nextQuestInChain] = 98216,
        },
        [305] = { -- In Search of The Excavation Team
            [questKeys.breadcrumbs] = {98461},
        },
        [324] = { -- The Lost Ingots
            [questKeys.exclusiveTo] = {526},
        },
        [334] = { -- Package for Thurman
            [questKeys.disabledByQuest] = 333,
        },
        [339] = { -- Chapter I
            [questKeys.preQuestSingle] = {},
        },
        [340] = { -- Chapter II
            [questKeys.preQuestSingle] = {},
        },
        [341] = { -- Chapter III
            [questKeys.preQuestSingle] = {},
        },
        [342] = { -- Chapter IV
            [questKeys.preQuestSingle] = {},
        },
        [356] = { -- Rear Guard Patrol
            [questKeys.nextQuestInChain] = 99156,
        },
        [376] = { -- The Damned
            [questKeys.nextQuestInChain] = 0,
        },
        [379] = { -- Slake That Thirst
            [questKeys.nextQuestInChain] = 0,
        },
        [398] = { -- WANTED: Maggot Eye
            [questKeys.name] = "WANTED: Maggot Eye",
        },
        [410] = { -- The Dormant Shade
            [questKeys.exclusiveTo] = {},
        },
        [420] = { -- Senir's Observations
            [questKeys.finishedBy_remove] = {{265813}},
        },
        [425] = { -- Ivar the Foul
            [questKeys.preQuestSingle] = {91921},
        },
        [430] = { -- Return to Quinn
            [questKeys.nextQuestInChain] = 91920,
        },
        [431] = { -- Candles of Beckoning
            [questKeys.exclusiveTo] = {},
        },
        [465] = { -- Nek'rosh's Gambit
            [questKeys.nextQuestInChain] = 0,
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {464,98221},
        },
        [469] = { -- Daily Delivery
            [questKeys.breadcrumbForQuestId] = 484,
        },
        [479] = { -- Ambermill Investigations
            [questKeys.nextQuestInChain] = 0,
        },
        [480] = { -- The Weaver
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {479,95981},
        },
        [484] = { -- Young Crocolisk Skins
            [questKeys.breadcrumbs] = {469},
        },
        [490] = { -- Bounty: Gnarlpine Furbolg
            [questKeys.name] = "Bounty: Gnarlpine Furbolg",
            [questKeys.startedBy] = {{2155}},
            [questKeys.finishedBy] = {{2155}},
            [questKeys.requiredLevel] = 5,
            [questKeys.questLevel] = 8,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.objectivesText] = {"Shayla Nightbreeze on the road outside of Darnassus wants you to bring her 15 Gnarlpine Fangs."},
            [questKeys.objectives] = {nil,nil,{{5220}}},
            [questKeys.zoneOrSort] = zoneIDs.TELDRASSIL,
            [questKeys.questFlags] = 8,
            [questKeys.reputationReward] = {{factionIDs.DARNASSUS, 100}},
        },
        [526] = { -- Lightforge Ingots
            [questKeys.preQuestSingle] = {321},
            [questKeys.exclusiveTo] = {324},
            [questKeys.nextQuestInChain] = 322,
        },
        [536] = { -- Down the Coast
            [questKeys.breadcrumbs] = {98219},
        },
        [544] = { -- Prison Break In
            [questKeys.nextQuestInChain] = 0,
        },
        [545] = { -- Dalaran Patrols
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {544,93680},
            [questKeys.zoneOrSort] = zoneIDs.ALTERAC_MOUNTAINS,
            [questKeys.nextQuestInChain] = 92434,
        },
        [555] = { -- Soothing Turtle Bisque
            [questKeys.exclusiveTo] = {7321},
        },
        [569] = { -- The Defense of Grom'gol
            [questKeys.nextQuestInChain] = 97386,
        },
        [583] = { -- Welcome to the Jungle
            [questKeys.nextQuestInChain] = 0,
        },
        [590] = { -- A Rogue's Deal
            [questKeys.objectives] = {{{6784}}},
        },
        [614] = { -- The Captain's Chest
            [questKeys.exclusiveTo] = {8551},
        },
        [615] = { -- The Captain's Cutlass
            [questKeys.preQuestSingle] = {8552},
            [questKeys.exclusiveTo] = {8553},
        },
        [618] = { -- Facing Negolash
            [questKeys.exclusiveTo] = {8554},
        },
        [656] = { -- Summoning the Princess
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Summon Myzrael"), 0, {{"object", 138492}}}},
        },
        [684] = { -- WANTED: Marez Cowl
            [questKeys.name] = "WANTED: Marez Cowl",
        },
        [685] = { -- WANTED: Otto and Falconcrest
            [questKeys.name] = "WANTED: Otto and Falconcrest",
        },
        [760] = { -- Wildmane Cleansing
            [questKeys.nextQuestInChain] = 98435,
        },
        [808] = { -- Minshina's Skull
            [questKeys.disabledByQuest] = 805,
        },
        [823] = { -- Report to Orgnil
            [questKeys.disabledByQuest] = 805,
        },
        [826] = { -- Zalazane
            [questKeys.disabledByQuest] = 805,
        },
        [932] = { -- Twisted Hatred
            [questKeys.nextQuestInChain] = 98403,
        },
        [934] = { -- Crown of the Earth
            [questKeys.exclusiveTo] = {7383},
        },
        [935] = { -- Crown of the Earth
            [questKeys.nextQuestInChain] = 98046,
        },
        [937] = { -- The Enchanted Glade
            [questKeys.nextQuestInChain] = 98392,
        },
        [940] = { -- Teldrassil
            [questKeys.startedBy] = {nil,{673378}},
            [questKeys.preQuestSingle] = {98398},
        },
        [952] = { -- Grove of the Ancients
            [questKeys.zoneOrSort] = zoneIDs.DARKSHORE,
        },
        [971] = { -- Knowledge in the Deeps
            [questKeys.disabledByQuest] = 968,
            [questKeys.requiredLevel] = 18,
        },
        [976] = { -- Supplies to Auberdine
            [questKeys.triggerEnd] = {"Protect Feero Ironhand", {[zoneIDs.ASHENVALE] = {{29.5,16.8}}}},
        },
        [982] = { -- Deep Ocean, Vast Sea
            [questKeys.breadcrumbs_add] = {97894},
        },
        [1045] = { -- Raene's Cleansing
            [questKeys.objectives] = {{{3932}},nil,{{5388}}},
        },
        [1046] = { -- Raene's Cleansing
            [questKeys.objectives] = {nil,nil,{{5462}}},
        },
        [1049] = { -- Compendium of the Fallen
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE - raceIDs.UNDEAD,
        },
        [1079] = { -- Covert Ops - Alpha
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Place the NG-5 Explosives (Blue)"), 0, {{"object", 19591}}}},
        },
        [1080] = { -- Covert Ops - Beta
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Place the NG-5 Explosives (Red)"), 0, {{"object", 19600}}}},
        },
        [1085] = { -- On Guard in Stonetalon
            [questKeys.preQuestSingle] = {},
        },
        [1086] = { -- The Flying Machine Airport
            [questKeys.objectives] = {nil,{{19594}}},
        },
        [1122] = { -- Report Back to Fizzlebub
            [questKeys.nextQuestInChain] = 0,
            [questKeys.preQuestSingle] = {1120,1121},
        },
        [1127] = { -- Fool's Stout
            [questKeys.parentQuest] = 0,
        },
        [1148] = { -- Parts of the Swarm
            [questKeys.preQuestSingle] = {},
            [questKeys.availableStartingWith] = 1147,
        },
        [1149] = { -- Test of Faith
            [questKeys.triggerEnd] = {},
        },
        [1203] = { -- Jarl Needs a Blade
            [questKeys.exclusiveTo] = {81570},
        },
        [1205] = { -- Deadmire
            [questKeys.nextQuestInChain] = 97378,
        },
        [1273] = { -- Questioning Reethe
            [questKeys.objectives] = {{{4980,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [1276] = { -- The Black Shield
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {1273,1323},
        },
        [1369] = { -- Broken Tears
            [questKeys.nextQuestInChain] = 92743,
        },
        [1373] = { -- Ongeku
            [questKeys.nextQuestInChain] = 93034,
        },
        [1389] = { -- Draenethyst Crystals
            [questKeys.nextQuestInChain] = 93464,
        },
        [1432] = { -- Alliance Relations
            [questKeys.nextQuestInChain] = 0,
        },
        [1434] = { -- Befouled by Satyr
            [questKeys.nextQuestInChain] = 0,
        },
        [1486] = { -- Deviate Hides
            [questKeys.startedBy_remove] = {nil,{659159}},
        },
        [1516] = { -- Call of Earth
            [questKeys.exclusiveTo] = {1519,92466},
        },
        [1517] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1516,1519,92466,94373},
            [questKeys.exclusiveTo] = {1520,92467,94374},
        },
        [1518] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1517,1520,92467,94374},
            [questKeys.exclusiveTo] = {1521,92468,94375},
        },
        [1519] = { -- Call of Earth
            [questKeys.exclusiveTo] = {1516,92466},
        },
        [1520] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1516,1519,92466,94373},
            [questKeys.exclusiveTo] = {1517,92467,94374},
        },
        [1521] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1517,1520,92467,94374},
            [questKeys.exclusiveTo] = {1518,92468,94375},
        },
        [1524] = { -- Call of Fire
            [questKeys.exclusiveTo] = {97243},
        },
        [1531] = { -- Call of Air
            [questKeys.exclusiveTo] = {1532,96136},
            [questKeys.nextQuestInChain] = 79360,
        },
        [1532] = { -- Call of Air
            [questKeys.exclusiveTo] = {1531,96136},
            [questKeys.nextQuestInChain] = 79360,
        },
        [1578] = { -- Supplying the Front
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 25},
        },
        [1618] = { -- Gearing Redridge
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 35},
        },
        [1638] = { -- A Warrior's Training
            [questKeys.nextQuestInChain] = 0,
            [questKeys.breadcrumbForQuestId] = 0,
        },
        [1639] = { -- Bartleby the Drunk
            [questKeys.breadcrumbs] = {},
        },
        [1657] = { -- Stinking Up Southshore
            [questKeys.objectives] = {{{15415,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [1661] = { -- The Tome of Nobility
            [questKeys.breadcrumbs] = {4485,4486},
            [questKeys.exclusiveTo] = {},
        },
        [1799] = { -- Fragments of the Orb of Orahil
            [questKeys.nextQuestInChain] = 0,
            [questKeys.preQuestSingle] = {},
        },
        [1842] = { -- Satyr Hooves
            [questKeys.preQuestSingle] = {1848},
        },
        [1883] = { -- Speak with Un'thuwa
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [1918] = { -- The Befouled Element
            [questKeys.availableStartingWith] = 25,
        },
        [2300] = { -- SI:7
            [questKeys.nextQuestInChain] = 0,
        },
        [2519] = { -- The Temple of the Moon
            [questKeys.breadcrumbs] = {98391},
        },
        [2758] = { -- The Origins of Smithing
            [questKeys.exclusiveTo] = {80241},
        },
        [2856] = { -- Wild Leather Vest
            [questKeys.exclusiveTo] = {82656},
        },
        [3450] = { -- An Easy Pickup
            [questKeys.preQuestSingle] = {},
        },
        [3505] = { -- Betrayed
            [questKeys.finishedBy_remove] = {{247449}},
            [questKeys.nextQuestInChain] = 91497,
        },
        [3641] = { -- Show Your Work
            [questKeys.exclusiveTo] = {3638,3639,3643},
        },
        [3643] = { -- Show Your Work
            [questKeys.exclusiveTo] = {3638,3639,3641},
        },
        [3842] = { -- A Short Incubation
            [questKeys.objectivesText] = {"Bring 2 Elixirs of Lesser Fortitude to Quentin in Thousand Needles."},
        },
        [3982] = { -- What Is Going On?
            [questKeys.specialFlags] = specialFlags.NONE,
        },
        [4001] = { -- What Is Going On?
            [questKeys.preQuestSingle] = {3982},
        },
        [4485] = { -- The Tome of Nobility
            [questKeys.nextQuestInChain] = 1661,
            [questKeys.breadcrumbForQuestId] = 1661,
            [questKeys.exclusiveTo] = {4486},
        },
        [4486] = { -- The Tome of Nobility
            [questKeys.nextQuestInChain] = 1661,
            [questKeys.breadcrumbForQuestId] = 1661,
            [questKeys.exclusiveTo] = {4485},
        },
        [4763] = { -- The Blackwood Corrupted
            [questKeys.extraObjectives] = {
                {nil, Questie.ICON_TYPE_OBJECT, l10n("Summon Xabraxxis once you have the required items from the Blackwood Stores."), 0, {{"object", 176705}}},
                {nil, Questie.ICON_TYPE_SLAY, l10n("Kill Xabraxxis"), 0, {{"monster", 10373}}},
            },
        },
        [4921] = { -- Lost in Battle
            [questKeys.nextQuestInChain] = 95774,
        },
        [5147] = { -- WANTED: Arnak Grimtotem
            [questKeys.name] = "WANTED: Arnak Grimtotem",
        },
        [5244] = { -- The Ruins of Kel'Theril
            [questKeys.preQuestGroup] = {},
        },
        [5321] = { -- The Sleeper Has Awakened
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Escort Kerlonian Evershade on the road south to his bag",{[zoneIDs.DARKSHORE] = {{42,90.5}}}},
        },
        [5482] = { -- Doom Weed
            [questKeys.nextQuestInChain] = 99142,
        },
        [5542] = { -- Demon Dogs
            [questKeys.nextQuestInChain] = 0,
        },
        [5543] = { -- Blood Tinged Skies
            [questKeys.nextQuestInChain] = 0,
        },
        [5544] = { -- Carrion Grubbage
            [questKeys.nextQuestInChain] = 0,
        },
        [5635] = { -- Desperate Prayer
            [questKeys.requiredRaces] = raceIDs.DWARF,
        },
        [5637] = { -- Desperate Prayer
            [questKeys.requiredRaces] = raceIDs.DWARF,
        },
        [5638] = { -- Desperate Prayer
            [questKeys.requiredRaces] = raceIDs.DWARF,
        },
        [5639] = { -- Desperate Prayer
            [questKeys.requiredRaces] = raceIDs.DWARF,
        },
        [5640] = { -- Desperate Prayer
            [questKeys.requiredRaces] = raceIDs.DWARF,
        },
        [5644] = { -- Dark Sacrifice
            [questKeys.name] = "Dark Sacrifice",
        },
        [5646] = { -- Dark Sacrifice
            [questKeys.name] = "Dark Sacrifice",
        },
        [5679] = { -- Dark Sacrifice
            [questKeys.name] = "Dark Sacrifice",
        },
        [5713] = { -- One Shot.  One Kill.
            [questKeys.name] = "One Shot.  One Kill.",
        },
        [5725] = { -- The Power to Destroy...
            [questKeys.startedBy_remove] = {nil,{658924}},
        },
        [6063] = { -- Taming the Beast
            [questKeys.exclusiveTo] = {94013},
        },
        [6126] = { -- Lessons Anew
            [questKeys.startedBy_add] = {{262560}},
        },
        [6403] = { -- The Great Masquerade
            [questKeys.exclusiveTo] = {99435},
        },
        [6481] = { -- Earthen Arise
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Summon Goggeroc"), 0, {{"object", 178145}}}},
        },
        [6564] = { -- Allegiance to the Old Gods
            [questKeys.preQuestSingle] = {},
            [questKeys.availableStartingWith] = 6563,
        },
        [6621] = { -- King of the Foulweald
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_SLAY, l10n("Kill Chief Murgut"), 0, {{"monster", 12918}}}},
        },
        [6627] = { -- Test of Lore
            [questKeys.triggerEnd] = {},
            [questKeys.objectives] = {{{4489,nil,Questie.ICON_TYPE_TALK}}},
        },
        [6628] = { -- Test of Lore
            [questKeys.triggerEnd] = {},
            [questKeys.objectives] = {{{4488,nil,Questie.ICON_TYPE_TALK}}},
        },
        [6641] = { -- Vorsha the Lasher
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Put the fire out"), 0, {{"object", 178247}}}},
            [questKeys.objectives] = {{{12940}}},
            [questKeys.triggerEnd] = {},
        },
        [6922] = { -- Baron Aquanis
            [questKeys.availableStartingWith] = 6921,
        },
        [7029] = { -- Vyletongue Corruption
            [questKeys.exclusiveTo] = {7041},
        },
        [7041] = { -- Vyletongue Corruption
            [questKeys.exclusiveTo] = {7029},
        },
        [7064] = { -- Corruption of Earth and Seed
            [questKeys.exclusiveTo] = {7065},
        },
        [7065] = { -- Corruption of Earth and Seed
            [questKeys.exclusiveTo] = {7064},
        },
        [7068] = { -- Shadowshard Fragments
            [questKeys.exclusiveTo] = {7070},
        },
        [7070] = { -- Shadowshard Fragments
            [questKeys.exclusiveTo] = {7068},
        },
        [7321] = { -- Soothing Turtle Bisque
            [questKeys.exclusiveTo] = {555},
        },
        [7383] = { -- Crown of the Earth
            [questKeys.exclusiveTo] = {934},
        },
        [7581] = { -- The Prison's Bindings
            [questKeys.nextQuestInChain] = 0,
        },
        [7582] = { -- The Prison's Casing
            [questKeys.nextQuestInChain] = 0,
        },
        [7790] = { -- River Ends
            [questKeys.name] = "River Ends",
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 8152,
        },
        [8105] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8120,8166,8167,8168,8169,8170,8171},
        },
        [8120] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8166,8167,8168,8169,8170,8171},
        },
        [8152] = { -- Rapid Escape
            [questKeys.name] = "Rapid Escape",
            [questKeys.requiredLevel] = 53,
            [questKeys.preQuestSingle] = {7790},
            [questKeys.nextQuestInChain] = 97986,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [8166] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8167,8168,8169,8170,8171},
        },
        [8167] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8166,8168,8169,8170,8171},
        },
        [8168] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8166,8167,8169,8170,8171},
        },
        [8169] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8166,8167,8168,8170,8171},
        },
        [8170] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8166,8167,8168,8169,8171},
        },
        [8171] = { -- The Battle for Arathi Basin!
            [questKeys.exclusiveTo] = {8105,8120,8166,8167,8168,8169,8170},
        },
        [8234] = { -- Sealed Azure Bag
            [questKeys.preQuestSingle] = {},
        },
        [8249] = { -- Junkboxes Needed
            [questKeys.zoneOrSort] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [8356] = { -- Flexing for Nougat
            [questKeys.objectivesText] = {"Do a flex emote at Innkeeper Allison, and in exchange you'll receive Stormwind Nougat!"},
        },
        [8409] = { -- Ruined Kegs
            [questKeys.requiredLevel] = 30,
        },
        [8414] = { -- Dispelling Evil
            [questKeys.preQuestSingle] = {},
        },
        [8551] = { -- The Captain's Chest
            [questKeys.exclusiveTo] = {614},
        },
        [8553] = { -- The Captain's Cutlass
            [questKeys.exclusiveTo] = {615},
        },
        [8554] = { -- Facing Negolash
            [questKeys.preQuestSingle] = {615,8553},
            [questKeys.exclusiveTo] = {618},
        },
        [60860] = { -- Your Reward has Arrived!
            [questKeys.name] = "Your Reward has Arrived!",
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.exclusiveTo] = {60870},
            [questKeys.zoneOrSort] = sortKeys.SPECIAL,
        },
        [60870] = { -- A Special Gift
            [questKeys.name] = "A Special Gift",
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.exclusiveTo] = {60860},
            [questKeys.zoneOrSort] = sortKeys.SPECIAL,
        },
        [76156] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.TAUREN,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.nextQuestInChain] = 76160,
            [questKeys.objectives] = {nil,nil,{{206157}}},
            [questKeys.sourceItemId] = 206159,
        },
        [76160] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.TAUREN,
            [questKeys.preQuestSingle] = {76156},
            [questKeys.nextQuestInChain] = 76240,
            [questKeys.sourceItemId] = 206176,
            [questKeys.objectives] = {nil,nil,{{206175}}},
            [questKeys.requiredSourceItems] = {206170},
        },
        [76240] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.TAUREN,
            [questKeys.preQuestSingle] = {76160},
            [questKeys.sourceItemId] = 206344,
            [questKeys.objectives] = {nil,nil,{{206345}}},
            [questKeys.requiredSourceItems] = {6291},
        },
        [78088] = { -- A Strange Artifact
            [questKeys.nextQuestInChain] = 78089,
        },
        [78089] = { -- Advice From Stormwind
            [questKeys.preQuestSingle] = {78088},
            [questKeys.nextQuestInChain] = 78090,
        },
        [78090] = { -- A Second Opinion
            [questKeys.preQuestSingle] = {78089},
            [questKeys.nextQuestInChain] = 78091,
        },
        [78091] = { -- Earning Your Salt
            [questKeys.preQuestSingle] = {78090},
            [questKeys.nextQuestInChain] = 78092,
        },
        [78092] = { -- It Must Be Destroyed
            [questKeys.preQuestSingle] = {78091},
            [questKeys.nextQuestInChain] = 78093,
        },
        [78093] = { -- Return to Delgren
            [questKeys.preQuestSingle] = {78092},
        },
        [78124] = { -- Nar'thalas Almanac
            [questKeys.startedBy] = {{211022,211033},{409496}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209843}}},
        },
        [78127] = { -- The Dalaran Digest
            [questKeys.startedBy] = {{211022,211033},{409501}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209844}}},
        },
        [78142] = { -- Bewitchments and Glamours
            [questKeys.startedBy] = {{211022,211033},{409562}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209845}}},
        },
        [78143] = { -- Secrets of the Dreamers
            [questKeys.startedBy] = {{211022,211033},{409692}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209846}}},
        },
        [78145] = { -- Arcanic Systems Manual
            [questKeys.startedBy] = {{211022,211033},{409700}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209847}}},
        },
        [78146] = { -- Goaz Scrolls
            [questKeys.startedBy] = {{211022,211033},{409717}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209848}}},
        },
        [78147] = { -- Crimes Against Anatomy
            [questKeys.startedBy] = {{211022,211033},{409735}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209849}}},
        },
        [78148] = { -- Runes of the Sorcerer-Kings
            [questKeys.startedBy] = {{211022,211033},{409731}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209850}}},
        },
        [78149] = { -- Fury of the Land
            [questKeys.startedBy] = {{211022,211033},{409711}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{209851}}},
        },
        [78150] = { -- Friend of the Library
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78261] = { -- The Horn of Xelthos
            [questKeys.requiredLevel] = 1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.ROGUE,
            [questKeys.nextQuestInChain] = 78307,
            [questKeys.childQuests] = {78270},
        },
        [78270] = { -- Goblin Lockpicks
            [questKeys.questLevel] = 23,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.parentQuest] = 78261,
        },
        [78307] = { -- The Horn of Xelthos
            [questKeys.startedBy] = {nil,{410369}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 23,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.ROGUE,
            [questKeys.preQuestSingle] = {78261},
            [questKeys.nextQuestInChain] = 78676,
        },
        [78676] = { -- The Eye of Bhossca
            [questKeys.preQuestSingle] = {78307},
            [questKeys.nextQuestInChain] = 78699,
        },
        [78699] = { -- The Eye of Bhossca
            [questKeys.startedBy] = {nil,{410369}},
            [questKeys.preQuestSingle] = {78676},
        },
        [78823] = { -- Terror of the Desert Skies
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 78830,
        },
        [78830] = { -- Terror of the Desert Skies
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {78823},
        },
        [79007] = { -- ... and that note you found
            [questKeys.startedBy] = {nil,{415106}},
            [questKeys.finishedBy] = {nil,{415107}},
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
            [questKeys.nextQuestInChain] = 79192,
        },
        [79008] = { -- ... and that note you found
            [questKeys.startedBy] = {nil,{415107}},
            [questKeys.finishedBy] = {nil,{415106,417072}}, -- alliance turns in at both
            [questKeys.zoneOrSort] = zoneIDs.WESTFALL,
            [questKeys.nextQuestInChain] = 79192,
        },
        [79091] = { -- Archmage Antonidas: The Unabridged Autobiography
            [questKeys.startedBy] = {{211022,211033},{386691}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{203754}}},
        },
        [79092] = { -- Archmage Theocritus' Research Journal
            [questKeys.startedBy] = {{211022,211033},{386759}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{203755}}},
        },
        [79093] = { -- Rumi of Gnomeregan: The Collected Works
            [questKeys.startedBy] = {{211022,211033},{408014}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{208860}}},
        },
        [79094] = { -- The Lessons of Ta'zo
            [questKeys.startedBy] = {{211022,211033},{405149}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{207972}}},
        },
        [79095] = { -- The Apothecary's Metaphysical Primer
            [questKeys.startedBy] = {{211022,211033},{405879}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{208185}}},
        },
        [79096] = { -- Ataeric: On Arcane Curiosities
            [questKeys.startedBy] = {{211022,211033},{410299}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{210177}}},
        },
        [79097] = { -- Baxtan: On Destructive Magics
            [questKeys.startedBy] = {{211022,211033},{407566}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 20,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{208800}}},
        },
        [79192] = { -- Stepping Stones
            [questKeys.startedBy] = {nil,{417072,424010}},
            [questKeys.preQuestSingle] = {79007,79008},
            [questKeys.nextQuestInChain] = 79980,
        },
        [79229] = { -- Highway Robbery
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 79235,
        },
        [79235] = { -- On the Lam
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {79229},
            [questKeys.nextQuestInChain] = 79236,
        },
        [79236] = { -- Cherry for Your Thoughts?
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {79235},
            [questKeys.nextQuestInChain] = 79242,
        },
        [79242] = { -- No Honor Among Thieves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {79236},
        },
        [79358] = { -- Storm, Earth, and Fire
            [questKeys.preQuestSingle] = {96264},
            [questKeys.nextQuestInChain] = 96135,
        },
        [79360] = { -- Elemental Aid
            [questKeys.preQuestSingle] = {1531,1532,96136},
            [questKeys.nextQuestInChain] = 79364,
        },
        [79361] = { -- Storm, Earth, and Fire
            [questKeys.preQuestSingle] = {79364},
            [questKeys.nextQuestInChain] = 79366,
        },
        [79364] = { -- Eyes on the Sky
            [questKeys.preQuestSingle] = {79360},
            [questKeys.exclusiveTo] = {98338},
            [questKeys.nextQuestInChain] = 79361,
        },
        [79365] = { -- With Wind Beneath Your Wings
            [questKeys.requiredRaces] = raceIDs.ORC + raceIDs.TAUREN,
        },
        [79366] = { -- Heed My Call
            [questKeys.preQuestSingle] = {79361},
            [questKeys.exclusiveTo] = {96135},
            [questKeys.nextQuestInChain] = 79442,
        },
        [79442] = { -- The Tempest's Weapons
            [questKeys.preQuestSingle] = {79366,96135},
            [questKeys.exclusiveTo] = {96016},
        },
        [79535] = { -- Basilisks: Should Petrification be Feared?
            [questKeys.startedBy] = {{211022,211033},{421526}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{213165}}},
        },
        [79536] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.preQuestSingle] = {78150},
        },
        [79624] = { -- Anyone Can Cook
            [questKeys.nextQuestInChain] = 79677,
        },
        [79677] = { -- A Quick Grocery Run
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {79624},
            [questKeys.nextQuestInChain] = 79678,
        },
        [79678] = { -- Taste Testing
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {79677},
        },
        [79939] = { -- The Broken Hammer
            [questKeys.nextQuestInChain] = 79940,
        },
        [79940] = { -- A Lost Brother
            [questKeys.preQuestSingle] = {79939},
        },
        [79945] = { -- Orders from the Grand Crusader
            [questKeys.nextQuestInChain] = 79946,
        },
        [79946] = { -- A Brother In Need
            [questKeys.preQuestSingle] = {79945},
        },
        [79947] = { -- Geomancy: The Stone-Cold Truth
            [questKeys.startedBy] = {{211022,211033},{423895}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215683}}},
        },
        [79948] = { -- Defensive Magics 101
            [questKeys.startedBy] = {{211022,211033},{423896}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215815}}},
        },
        [79949] = { -- A Web of Lies: Debunking Myths and Legends
            [questKeys.startedBy] = {{211022,211033},{423897}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215816}}},
        },
        [79950] = { -- Demons and You
            [questKeys.startedBy] = {{211022,211033},{423898}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215817}}},
        },
        [79951] = { -- Mummies: A Guide to the Unsavory Undead
            [questKeys.startedBy] = {{211022,211033},{423899}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215820}}},
        },
        [79952] = { -- RwlRwlRwlRwl!
            [questKeys.startedBy] = {{211022,211033},{423900}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215822}}},
        },
        [79953] = { -- A Ludite's Guide to Caring for Your Demonic Pet
            [questKeys.name] = "A Ludite's Guide to Caring for Your Demonic Pet",
            [questKeys.startedBy] = {{211022,211033},{423901}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{215824}}},
        },
        [79974] = { -- Wet Job
            [questKeys.preQuestSingle] = {79980},
            [questKeys.nextQuestInChain] = 79975,
        },
        [79975] = { -- Eagle's Fist
            [questKeys.preQuestSingle] = {79974},
            [questKeys.nextQuestInChain] = 79976,
        },
        [79976] = { -- This Must Be The Place
            [questKeys.preQuestSingle] = {79975},
            [questKeys.zoneOrSort] = 1857,
        },
        [79980] = { -- Scramble
            [questKeys.preQuestSingle] = {79192},
            [questKeys.nextQuestInChain] = 79974,
        },
        [80001] = { -- Rekindle
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [80411] = { -- The Talisman of Kazdor
            [questKeys.preQuestSingle] = {80526},
        },
        [80453] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [80454] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [80455] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [80526] = { -- Fool Me Twice
            [questKeys.nextQuestInChain] = 80411,
        },
        [81570] = { -- Jarl Needs a Blade
            [questKeys.exclusiveTo] = {1203},
        },
        [81885] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [81900] = { -- The Burning Beast
            [questKeys.nextQuestInChain] = 81917,
        },
        [81917] = { -- Chains That Bind
            [questKeys.preQuestSingle] = {81900},
        },
        [81947] = { -- Sanguine Sorcery
            [questKeys.startedBy] = {{211022,211033},{441247}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220345}}},
        },
        [81949] = { -- Legends of the Tidesages
            [questKeys.startedBy] = {{211022,211033},{441248}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220346}}},
        },
        [81951] = { -- The Liminal and the Arcane
            [questKeys.name] = "The Liminal and the Arcane",
            [questKeys.startedBy] = {{211022,211033},{441249}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220347}}},
        },
        [81952] = { -- Everyday Etiquette
            [questKeys.startedBy] = {{211022,211033},{441250}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220348}}},
        },
        [81953] = { -- Stonewrought Design
            [questKeys.startedBy] = {{211022,211033},{441251}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220349}}},
        },
        [81954] = { -- Venomous Journeys
            [questKeys.startedBy] = {{211022,211033},{441252}},
            [questKeys.finishedBy] = {{211022,211033}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220350}}},
        },
        [81955] = { -- A Mind of Metal
            [questKeys.startedBy] = {{211022,211033},{441253}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220352}}},
        },
        [81956] = { -- Conjurer's Codex
            [questKeys.startedBy] = {{211022,211033},{441254}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{220353}}},
        },
        [82062] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [82135] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [82208] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectivesText] = {"You will need to hand in 25 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.preQuestSingle] = {79536},
        },
        [82656] = { -- Wild Leather Vest
            [questKeys.exclusiveTo] = {2856},
        },
        [82657] = { -- Wild Leather Vest
            [questKeys.exclusiveTo] = {2849},
        },
        [84135] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84137] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84138] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84146] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84151] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84153] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84163] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84166] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84171] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84198] = { -- Saving the Best for Last
            [questKeys.requiredLevel] = 58,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.NONE,
        },
        [84211] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84212] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84318] = { -- Oi!
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [84319] = { -- Oh No Ye Don't!
            [questKeys.requiredLevel] = 54,
            [questKeys.preQuestSingle] = {84318},
            [questKeys.zoneOrSort] = sortKeys.PALADIN,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.PALADIN,
        },
        [84330] = { -- A Wee Bit O' Necromancy
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [84332] = { -- A Thane's Gratitude
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [84377] = { -- End of the Dark Horde
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84394] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84395] = { -- Undead Potatoes
            [questKeys.name] = "Undead Potatoes",
            [questKeys.startedBy] = {{5497,7825},{463213}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228132}}},
        },
        [84396] = { -- Magma or Lava?
            [questKeys.name] = "Magma or Lava?",
            [questKeys.startedBy] = {{5497,7825},{463206}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228133}}},
        },
        [84397] = { -- Northern Kalimdor - A Comprehensive Guide
            [questKeys.name] = "Northern Kalimdor - A Comprehensive Guide",
            [questKeys.startedBy] = {{5497,7825},{463209}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228134}}},
        },
        [84398] = { -- A Study of the Light
            [questKeys.name] = "A Study of the Light",
            [questKeys.startedBy] = {{5497,7825},{463207}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228135}}},
        },
        [84399] = { -- Ka-Boom!
            [questKeys.name] = "Ka-Boom!",
            [questKeys.startedBy] = {{5497,7825},{463214}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228136}}},
        },
        [84400] = { -- The Knight and the Lady
            [questKeys.name] = "The Knight and the Lady",
            [questKeys.startedBy] = {{5497,7825},{463208}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228138}}},
        },
        [84401] = { -- Scourge: Undead Menace or Misunderstood?
            [questKeys.name] = "Scourge: Undead Menace or Misunderstood?",
            [questKeys.startedBy] = {{5497,7825},{463212}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228140}}},
        },
        [84402] = { -- Necromancy 101
            [questKeys.name] = "Necromancy 101",
            [questKeys.startedBy] = {{5497,7825},{463211}},
            [questKeys.finishedBy] = {{5497,7825}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {nil,nil,{{228141}}},
        },
        [84414] = { -- Send Me On Me Way
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [86577] = { -- A Sampling of Putrescence
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [86611] = { -- Stag Lord's Bauble
            [questKeys.exclusiveTo] = {86612},
        },
        [86612] = { -- Stag Lord's Bauble
            [questKeys.exclusiveTo] = {86611},
        },
        [86615] = { -- Treaty Obligations
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [86746] = { -- The Legashi Threat
            [questKeys.requiredLevel] = 47,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 86747,
        },
        [86747] = { -- Legashi Horns
            [questKeys.requiredLevel] = 47,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {86746},
        },
        [86752] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86758] = { -- Twisting the Knife
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [86776] = { -- Ingredients for the Forge
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
        },
        [86777] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86791] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86792] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86796] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86797] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86798] = { -- Timbermaw Reinforcements
            [questKeys.requiredLevel] = 47,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [86799] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86804] = { -- An Unlikely Source
            [questKeys.requiredLevel] = 47,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [86812] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86813] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86814] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86925] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86926] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86927] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [87288] = { -- Soft Saber Pelts
            [questKeys.reputationReward] = {{factionIDs.DARNASSUS, 100},{factionIDs.GNOMEREGAN_EXILES, 25},{factionIDs.ALLIANCE, 25},{factionIDs.IRONFORGE, 25},{factionIDs.STORMWIND, 25}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [87295] = { -- Deflective Surface
            [questKeys.requiredLevel] = 46,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [87346] = { -- Chieftain Bloodmaw
            [questKeys.requiredLevel] = 47,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [87494] = { -- Microcrystal Contamination
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [87760] = { -- Holy Diver
            [questKeys.preQuestGroup] = {4722,4723,4725,4727,4728,4730,4731,4732,4733},
        },
        [88757] = { -- Accessories of the Lost
            [questKeys.preQuestSingle] = {87318},
        },
        [88758] = { -- Sentiments of the Lost
            [questKeys.preQuestSingle] = {88757},
        },
        [88809] = { -- Preserving Eldarath
            [questKeys.preQuestSingle] = {88807},
        },
        [88812] = { -- Reclaiming Ravencrest
            [questKeys.preQuestSingle] = {88807},
        },
        [88813] = { -- The Head of the Serpent
            [questKeys.preQuestGroup] = {88809,88812},
        },
        [88821] = { -- Making Contact
            [questKeys.preQuestSingle] = {88807},
            [questKeys.nextQuestInChain] = 88917,
        },
        [88884] = { -- Highborne Tablets
            [questKeys.preQuestSingle] = {88917},
            [questKeys.nextQuestInChain] = 89037,
        },
        [88917] = { -- Slithering Looters
            [questKeys.preQuestSingle] = {88821},
            [questKeys.nextQuestInChain] = 88884,
        },
        [89001] = { -- Home on the Range
            [questKeys.exclusiveTo] = {91488},
        },
        [89013] = { -- Gettin' Buzzed
            [questKeys.preQuestSingle] = {89001,91488},
            [questKeys.exclusiveTo] = {91608},
        },
        [89015] = { -- Deadliest Catch
            [questKeys.preQuestSingle] = {89228,91610},
        },
        [89037] = { -- Murloc Thieves
            [questKeys.preQuestSingle] = {88884},
            [questKeys.nextQuestInChain] = 89038,
        },
        [89038] = { -- A Monumental Task
            [questKeys.preQuestSingle] = {89037},
            [questKeys.nextQuestInChain] = 89053,
        },
        [89053] = { -- Your Final Reward
            [questKeys.preQuestSingle] = {89038},
            [questKeys.nextQuestInChain] = 89470,
        },
        [89228] = { -- Winter Frontier Fishery
            [questKeys.preQuestSingle] = {89001,91488},
            [questKeys.exclusiveTo] = {91610},
        },
        [89470] = { -- Ill Tidings
            [questKeys.preQuestSingle] = {89053},
        },
        [90487] = { -- Ancient Allies
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestGroup] = {93747,95611},
        },
        [90647] = { -- The Staff of the Mountain
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestGroup] = {92317,92335,92500},
        },
        [90750] = { -- More Work?
            [questKeys.requiredLevel] = 54,
            [questKeys.preQuestSingle] = {92449,95026},
            [questKeys.nextQuestInChain] = 95218,
        },
        [90789] = { -- Scalebeard
            [questKeys.requiredLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.MAGE,
        },
        [90854] = { -- Leather for Inclement Weather
            [questKeys.preQuestSingle] = {92449,95026},
        },
        [90865] = { -- Eyes of the Watchers
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [90902] = { -- Rediscovering the Light
            [questKeys.preQuestSingle] = {364},
            [questKeys.objectives] = {{{259377,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [91208] = { -- Coming to Terms
            [questKeys.preQuestSingle] = {90902},
            [questKeys.objectives] = {{{246143}}},
        },
        [91209] = { -- Continue Your Training
            [questKeys.preQuestSingle] = {},
            [questKeys.objectives] = {{{246152,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [91285] = { -- Murlocs at the Gates
            [questKeys.nextQuestInChain] = 91294,
        },
        [91294] = { -- Touring the Grounds
            [questKeys.preQuestSingle] = {91285},
            [questKeys.objectives] = {{{246389,nil,Questie.ICON_TYPE_TALK},{246393,nil,Questie.ICON_TYPE_TALK},{246394,nil,Questie.ICON_TYPE_TALK},{246378,nil,Questie.ICON_TYPE_TALK}}},
        },
        [91316] = { -- Making Repairs
            [questKeys.preQuestSingle] = {91294},
        },
        [91317] = { -- The Tarnished
            [questKeys.preQuestSingle] = {91294},
            [questKeys.objectives] = {nil,nil,{{270435}},nil,{{{259434},259434},{{259433},259433}}},
        },
        [91488] = { -- Home on the Range
            [questKeys.exclusiveTo] = {89001},
        },
        [91497] = { -- Seals of the Sin'dorei
            [questKeys.preQuestSingle] = {3505},
            [questKeys.nextQuestInChain] = 91500,
        },
        [91500] = { -- An Explosive Gambit
            [questKeys.preQuestSingle] = {91497},
            [questKeys.nextQuestInChain] = 91531,
        },
        [91531] = { -- Revenge Exacted
            [questKeys.preQuestSingle] = {91500},
        },
        [91538] = { -- Sin'dorei Tome of Summoning
            [questKeys.preQuestSingle] = {91497},
            [questKeys.nextQuestInChain] = 91547,
        },
        [91547] = { -- Sin'dorei Tome of Summoning
            [questKeys.preQuestSingle] = {91538},
            [questKeys.nextQuestInChain] = 91548,
        },
        [91548] = { -- Vek'zol
            [questKeys.preQuestSingle] = {91547},
        },
        [91564] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91569] = { -- Blue Gold
            [questKeys.nextQuestInChain] = 91685,
        },
        [91608] = { -- Gettin' Buzzed
            [questKeys.preQuestSingle] = {89001,91488},
            [questKeys.exclusiveTo] = {89013},
        },
        [91610] = { -- Winter Frontier Fishery
            [questKeys.preQuestSingle] = {89001,91488},
            [questKeys.exclusiveTo] = {89228},
        },
        [91685] = { -- Ley of the Land
            [questKeys.preQuestSingle] = {91569},
        },
        [91688] = { -- To the Summit of Eternity
            [questKeys.preQuestGroup] = {92449,92591},
            [questKeys.exclusiveTo] = {95248},
        },
        [91696] = { -- Open Season
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {91698},
        },
        [91697] = { -- Meet the Elders
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93831},
        },
        [91698] = { -- Barkskin Breakout
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.nextQuestInChain] = 91696,
        },
        [91723] = { -- Delicate Instruments
            [questKeys.nextQuestInChain] = 91724,
        },
        [91724] = { -- Delicate Instruments
            [questKeys.preQuestSingle] = {91723},
        },
        [91734] = { -- Remote Contact
            [questKeys.exclusiveTo] = {91735,91737},
        },
        [91735] = { -- Remote Contact
            [questKeys.exclusiveTo] = {91734,91737},
        },
        [91736] = { -- Applejack Still
            [questKeys.startedBy] = {nil,{562131}},
            [questKeys.finishedBy] = {nil,{562131}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 1,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91737] = { -- Remote Contact
            [questKeys.exclusiveTo] = {91734,91735},
        },
        [91741] = { -- Nibbled-On Book
            [questKeys.nextQuestInChain] = 92124,
        },
        [91743] = { -- Rascally Rodents
            [questKeys.preQuestSingle] = {92124},
            [questKeys.nextQuestInChain] = 91745,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91745] = { -- Mining Consultant
            [questKeys.preQuestSingle] = {91743},
            [questKeys.nextQuestInChain] = 91752,
        },
        [91751] = { -- Rough Wolf Pelts
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
        },
        [91752] = { -- The Big Picture
            [questKeys.preQuestSingle] = {91745},
            [questKeys.nextQuestInChain] = 91758,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91753] = { -- An Enchanting Lesson
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredSourceItems] = {247883},
        },
        [91754] = { -- Rub Some Dirt In It
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [91755] = { -- Leaves to Ligatures
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91758] = { -- Follow That Kobold!
            [questKeys.preQuestSingle] = {91752},
            [questKeys.nextQuestInChain] = 91772,
        },
        [91770] = { -- Bark Bite
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestGroup] = {91754,91755},
        },
        [91772] = { -- Shhh! We're Hunting Kobolds
            [questKeys.preQuestSingle] = {91758},
            [questKeys.objectives] = {nil,{{563442}}},
            [questKeys.nextQuestInChain] = 91775,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91775] = { -- Book Return
            [questKeys.preQuestSingle] = {91772},
            [questKeys.nextQuestInChain] = 91777,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91777] = { -- Rare Books
            [questKeys.preQuestSingle] = {91775},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91858] = { -- Diplomatic Incident
            [questKeys.nextQuestInChain] = 91859,
        },
        [91859] = { -- A Curious Pair
            [questKeys.preQuestSingle] = {91858},
            [questKeys.nextQuestInChain] = 91860,
        },
        [91860] = { -- A Grim Fate
            [questKeys.preQuestSingle] = {91859},
            [questKeys.nextQuestInChain] = 91861,
            [questKeys.finishedBy] = {nil,{566037}}, -- Charred Remains on Fenris Isle
            [questKeys.objectives] = {nil,{{566037}}},
        },
        [91861] = { -- Into Fenris Keep
            [questKeys.preQuestSingle] = {91860},
            [questKeys.nextQuestInChain] = 91862,
            [questKeys.startedBy] = {nil,{566037}}, -- Charred Remains
        },
        [91862] = { -- Lumina Windsinger
            [questKeys.preQuestSingle] = {91861},
            [questKeys.nextQuestInChain] = 96204,
        },
        [91877] = { -- Demon Hunter's Hunter
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [91881] = { -- The Western Post
            [questKeys.preQuestSingle] = {95316},
            [questKeys.exclusiveTo] = {94782},
        },
        [91882] = { -- The Grand Alliance
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [91883] = { -- Spear of the Skylord
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91899] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91900] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91901] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91902] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91903] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91904] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91905] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91906] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91907] = { -- A Sealed Crate
            [questKeys.name] = "A Sealed Crate",
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91920] = { -- Wild Eyes
            [questKeys.preQuestSingle] = {430},
            [questKeys.nextQuestInChain] = 91921,
        },
        [91921] = { -- Return to Quinn (Again)
            [questKeys.preQuestSingle] = {91920},
            [questKeys.nextQuestInChain] = 425,
        },
        [91923] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91952] = { -- The Source of the Corruption
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92008] = { -- Premiere Parts
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 92009,
        },
        [92009] = { -- Crate Expectations
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92008},
            [questKeys.nextQuestInChain] = 92011,
        },
        [92011] = { -- Rubble Rummage
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92009},
            [questKeys.nextQuestInChain] = 92328,
        },
        [92014] = { -- Fox Hole
            [questKeys.preQuestSingle] = {92015},
        },
        [92015] = { -- Area Denial Skunks
            [questKeys.nextQuestInChain] = 92014,
        },
        [92016] = { -- Rootwork
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92017},
        },
        [92017] = { -- Cleansing Winds
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92020] = { -- Hol'anyee's Big Book of Big Lizards
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92064] = { -- Tree Free
            [questKeys.preQuestSingle] = {92702},
            [questKeys.nextQuestInChain] = 96559,
        },
        [92065] = { -- Blackmaw Reclamation
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92066] = { -- The Twin Bears
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92067] = { -- Feeding Time!
            [questKeys.requiredLevel] = 45,
            [questKeys.questLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92069] = { -- Claws That Rend, Tusks that Gore
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92070] = { -- A Lost Memento
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92094] = { -- Rocket Gnomes
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92100] = { -- Anywhere But Here
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92101] = { -- Lifted by Legacy
            [questKeys.preQuestSingle] = {96550},
        },
        [92102] = { -- Praise
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92109] = { -- My First Alchemy Set
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.nextQuestInChain] = 92110,
            [questKeys.objectives] = {nil,nil,{{3371},{2447},{765}}},
        },
        [92110] = { -- My First Real Potion
            [questKeys.preQuestSingle] = {92109},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
        },
        [92111] = { -- Of Friend and Fur
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93952},
            [questKeys.nextQuestInChain] = 93831,
        },
        [92124] = { -- Book Inventory
            [questKeys.preQuestSingle] = {91741},
            [questKeys.nextQuestInChain] = 91743,
        },
        [92147] = { -- Highfeather Helper
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92169] = { -- Paying Back the Pact
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {90647},
        },
        [92171] = { -- Taking to New Heights
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93773},
            [questKeys.nextQuestInChain] = 92500,
        },
        [92317] = { -- Stolen Life
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96939},
        },
        [92328] = { -- Siegecraft
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92011},
            [questKeys.nextQuestInChain] = 92329,
        },
        [92329] = { -- Drum Up Trouble
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92328},
        },
        [92335] = { -- Ashes of the Legion Ascent
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96964},
        },
        [92343] = { -- Get to the Roots of It
            [questKeys.preQuestSingle] = {92345,92346},
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92344] = { -- Get to the Roots of It
            [questKeys.preQuestSingle] = {92345,92346},
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [92345] = { -- Beneath Nordrassil
            [questKeys.nextQuestInChain] = 92344,
            [questKeys.exclusiveTo] = {92346},
        },
        [92346] = { -- Beneath Nordrassil
            [questKeys.nextQuestInChain] = 92343,
            [questKeys.exclusiveTo] = {92345},
        },
        [92401] = { -- A Frightened Request
            [questKeys.triggerEnd] = {"Investigate the disappearance of Edward Heartweaver in the Ruins of Lordaeron.",{[zoneIDs.RUINS_OF_LORDAERON] = {{-1,-1}}}},
        },
        [92415] = { -- Remember That I Love You
            [questKeys.nextQuestInChain] = 95161,
        },
        [92422] = { -- The Wrath of Rath'mael
            [questKeys.preQuestSingle] = {99156},
        },
        [92432] = { -- An Alarming Request
            [questKeys.nextQuestInChain] = 92458,
        },
        [92434] = { -- Blood in the Streets
            [questKeys.preQuestSingle] = {545},
            [questKeys.nextQuestInChain] = 96984,
            [questKeys.triggerEnd] = {},
            [questKeys.objectives] = {{{269127,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [92446] = { -- Head Scratcher
            [questKeys.preQuestSingle] = {92609},
        },
        [92449] = { -- Blight No More
            [questKeys.exclusiveTo] = {95026},
        },
        [92457] = { -- Starving Arcane
            [questKeys.preQuestSingle] = {92432},
        },
        [92458] = { -- Heart of Disruption
            [questKeys.preQuestSingle] = {92432},
            [questKeys.exclusiveTo] = {96984},
            [questKeys.nextQuestInChain] = 92459,
        },
        [92459] = { -- Friend of the Kirin Tor
            [questKeys.preQuestSingle] = {92458,96984},
        },
        [92460] = { -- Coming of Age
            [questKeys.nextQuestInChain] = 92461,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92461] = { -- Harmony in Balance
            [questKeys.preQuestSingle] = {92460},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92462] = { -- Infestation Investigation
            [questKeys.preQuestSingle] = {92460},
            [questKeys.nextQuestInChain] = 92463,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92463] = { -- The Cirrusfly Queen
            [questKeys.preQuestSingle] = {92462},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92464] = { -- Elemental Unrest
            [questKeys.availableUntilCompleted] = 92465,
        },
        [92465] = { -- Agitators
            [questKeys.objectives] = {{{251160},{251143}}},
            [questKeys.nextQuestInChain] = 92469,
        },
        [92466] = { -- Call of Earth
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.nextQuestInChain] = 92467,
            [questKeys.exclusiveTo] = {1516,1519},
        },
        [92467] = { -- Call of Earth
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {1516,1519,92466},
            [questKeys.nextQuestInChain] = 92468,
            [questKeys.exclusiveTo] = {1517,1520,94374},
        },
        [92468] = { -- Call of Earth
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {92467},
            [questKeys.exclusiveTo] = {1518,1521,94375},
        },
        [92469] = { -- Return to Rorian
            [questKeys.preQuestSingle] = {92465},
        },
        [92470] = { -- Foul Matriarch
            [questKeys.preQuestSingle] = {92471},
            [questKeys.nextQuestInChain] = 92472,
        },
        [92471] = { -- Aetheen of the Gales
            [questKeys.nextQuestInChain] = 92470,
        },
        [92472] = { -- The Next Step
            [questKeys.preQuestSingle] = {92470},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92473] = { -- Aggressive Encroachment
            [questKeys.preQuestSingle] = {92471},
        },
        [92474] = { -- Falling With Style
            [questKeys.objectives] = {nil,nil,nil,nil,nil,{{1259416}}},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [92479] = { -- A Scribbled Letter
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {7},
        },
        [92481] = { -- A Student of the Arcane
            [questKeys.preQuestSingle] = {92461},
        },
        [92482] = { -- The Way of the Hunter
            [questKeys.preQuestSingle] = {92461},
        },
        [92483] = { -- At Home in the Shadows
            [questKeys.preQuestSingle] = {92461},
        },
        [92484] = { -- Embracing the Elements
            [questKeys.preQuestSingle] = {92461},
        },
        [92485] = { -- A Student of Nature
            [questKeys.preQuestSingle] = {92461},
        },
        [92500] = { -- A Bit of the Sky
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92171},
        },
        [92514] = { -- Welcome to Shen'dar Village
            [questKeys.objectives] = {{{251902,nil,Questie.ICON_TYPE_TALK},{254089,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 0,
        },
        [92515] = { -- The Problem With Prideclaws
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92516] = { -- Hippogryph Harrassment
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92519] = { -- Ward Restocking
            [questKeys.preQuestSingle] = {97539},
        },
        [92517] = { -- The Criminal Element
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.nextQuestInChain] = 93036,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92519] = { -- Ward Restocking
            [questKeys.preQuestSingle] = {97539},
        },
        [92528] = { -- Among the Faithful
            [questKeys.preQuestSingle] = {92529},
            [questKeys.objectives] = {{{254128,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.nextQuestInChain] = 92550,
        },
        [92529] = { -- Falaath Village
            [questKeys.preQuestSingle] = {93036},
            [questKeys.nextQuestInChain] = 92528,
        },
        [92532] = { -- The Warrior's Path
            [questKeys.preQuestSingle] = {92461},
        },
        [92533] = { -- Twisted Tools
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92550] = { -- Havoc in the Highlands
            [questKeys.preQuestSingle] = {92528},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92551] = { -- Stolen Supplies
            [questKeys.preQuestSingle] = {92528},
        },
        [92553] = { -- Restocking the Larders
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92579] = { -- To Valanaar
            [questKeys.finishedBy] = {{252383}},
            [questKeys.preQuestGroup] = {92550,93927}, -- 92551 not needed
            [questKeys.nextQuestInChain] = 92700,
        },
        [92593] = { -- Avalanche of Corruption
            [questKeys.preQuestSingle] = {96992},
        },
        [92594] = { -- Kindling, Kinda
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92595] = { -- The Windshapers
            [questKeys.nextQuestInChain] = 94411,
            [questKeys.availableStartingWith] = 92514, -- available even after abandoning 92514, but this is next best thing
            [questKeys.objectives] = {{{251902,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [92596] = { -- The High Order
            [questKeys.nextQuestInChain] = 94413,
            [questKeys.availableStartingWith] = 93461, -- available even after abandoning 93461, but this is next best thing
            [questKeys.objectives] = {{{251903,nil,Questie.ICON_TYPE_TALK}}},
        },
        [92597] = { -- Reading the Ley Lines
            [questKeys.preQuestSingle] = {92461},
            [questKeys.objectives] = {nil,{{460002}}},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE,
        },
        [92598] = { -- The Gift of Skysight
            [questKeys.objectives] = {nil,{{460001}}},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_HORDE,
        },
        [92609] = { -- Feathers in Flight
            [questKeys.exclusiveTo] = {95027},
        },
        [92612] = { -- Aid from Moonglade
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96131},
            [questKeys.nextQuestInChain] = 96209,
        },
        [92640] = { -- Desperate Times
            [questKeys.preQuestSingle] = {94568},
            [questKeys.nextQuestInChain] = 93065,
            [questKeys.objectives] = {{{252383,nil,Questie.ICON_TYPE_TALK},{251968,nil,Questie.ICON_TYPE_TALK},{252475,nil,Questie.ICON_TYPE_TALK}}},
        },
        [92642] = { -- Disrupting Logistics
            [questKeys.preQuestSingle] = {93320},
        },
        [92643] = { -- The Turncoat
            [questKeys.preQuestSingle] = {92881},
            [questKeys.nextQuestInChain] = 92644,
            [questKeys.objectives] = {{{255013,nil,Questie.ICON_TYPE_EVENT},{253372,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [92644] = { -- Unfortunate News
            [questKeys.preQuestSingle] = {92643},
            [questKeys.nextQuestInChain] = 94568,
        },
        [92645] = { -- Breaking the Breaker
            [questKeys.preQuestSingle] = {93320},
        },
        [92646] = { -- Confront Lorthuna
            [questKeys.preQuestSingle] = {93958},
            [questKeys.nextQuestInChain] = 93836,
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Confront Lorthuna", {[zoneIDs.ZEPHRAS_ISLE] = {{74.87,53.02}}}},
            [questKeys.extraObjectives] = {
                {nil, Questie.ICON_TYPE_OBJECT, l10n("Take the portal"), 0, {{"object", 586726}}},
                {nil, Questie.ICON_TYPE_TALK, l10n("Start the fight"), 0, {{"monster", 253849}}},
            },
            [questKeys.exclusiveTo] = {93835},
        },
        [92679] = { -- Blood Tithe
            [questKeys.objectives] = {{{252800,nil,Questie.ICON_TYPE_INTERACT},{252448,nil,Questie.ICON_TYPE_EVENT}}}, -- 2nd objective is Optional
            [questKeys.nextQuestInChain] = 0,
        },
        [92682] = { -- Make Yourself Useful
            [questKeys.preQuestSingle] = {92679},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92683] = { -- Flutterfly Dust
            [questKeys.preQuestSingle] = {92679},
            [questKeys.extraObjectives] = {{nil,Questie.ICON_TYPE_INTERACT,l10n("Use the Flutterfly Swatter"),0,{{"monster",251622}}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92684] = { -- Ornery Ornery Galestriders
            [questKeys.preQuestSingle] = {92679},
        },
        [92685] = { -- The Hills Have Eyes
            [questKeys.preQuestGroup] = {92682,92683,92684},
            [questKeys.nextQuestInChain] = 92693,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92693] = { -- Standing Our Ground
            [questKeys.preQuestSingle] = {92685},
            [questKeys.nextQuestInChain] = 92703,
            [questKeys.objectives] = {{{252800,nil,Questie.ICON_TYPE_TALK},{252863,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92698] = { -- What Is My Purpose?
            [questKeys.preQuestSingle] = {92679},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92699] = { -- The Supreme Magister
            [questKeys.preQuestSingle] = {92701},
        },
        [92700] = { -- The Grand Skyseer
            [questKeys.preQuestSingle] = {92579},
        },
        [92701] = { -- To Valanaar
            [questKeys.preQuestGroup] = {92550,93927}, -- 92551 not needed
            [questKeys.nextQuestInChain] = 92699,
        },
        [92702] = { -- Branch Out
            [questKeys.nextQuestInChain] = 92064,
        },
        [92703] = { -- Deliver the News
            [questKeys.preQuestSingle] = {92693},
        },
        [92706] = { -- WANTED: Bruuz
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92708] = { -- A Grand Adventure
            [questKeys.preQuestSingle] = {92700},
            [questKeys.objectives] = {{{251968,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [92709] = { -- A Grand Adventure
            [questKeys.preQuestSingle] = {92699},
            [questKeys.objectives] = {{{252475,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [92727] = { -- The Missing Scholar
            [questKeys.preQuestSingle] = {92699},
            [questKeys.nextQuestInChain] = 92849,
        },
        [92741] = { -- Unwelcome Visitors
            [questKeys.preQuestSingle] = {92699},
        },
        [92742] = { -- Testing the Wells
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92743] = { -- A Conqueror's Crown
            [questKeys.preQuestSingle] = {1369},
            [questKeys.nextQuestInChain] = 92841,
        },
        [92744] = { -- Murloc Gills
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92745] = { -- The State of the Mines
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestGroup] = {92742,92744},
            [questKeys.nextQuestInChain] = 92747,
        },
        [92747] = { -- Moonbrook Espionage
            [questKeys.preQuestSingle] = {92745},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92748,
        },
        [92748] = { -- Moonbrook Espionage
            [questKeys.preQuestSingle] = {92747},
        },
        [92749] = { -- A Dynamite Plan
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {92748},
        },
        [92750] = { -- Detonation at a Distance
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {92748},
            [questKeys.nextQuestInChain] = 92751,
        },
        [92751] = { -- Detonation at a Distance
            [questKeys.preQuestSingle] = {92750},
        },
        [92752] = { -- Explosive Consultation
            [questKeys.preQuestGroup] = {92749,92751},
            [questKeys.nextQuestInChain] = 92753,
        },
        [92753] = { -- Destruction in Deadmines
            [questKeys.preQuestSingle] = {92752},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {{{253370,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.nextQuestInChain] = 92819,
        },
        [92754] = { -- A New Need for Shadow Protection
            [questKeys.preQuestSingle] = {1369},
        },
        [92755] = { -- Mysterious Mysticism
            [questKeys.preQuestSingle] = {1370},
        },
        [92811] = { -- Economic Warfare
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93226,94872},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.reputationReward] = {{factionIDs.MAGRAM_CLAN_CENTAUR,750},{factionIDs.GELKIS_CLAN_CENTAUR,-3750}},
        },
        [92812] = { -- Economic Warfare
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93227,94873},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.reputationReward] = {{factionIDs.GELKIS_CLAN_CENTAUR,750},{factionIDs.MAGRAM_CLAN_CENTAUR,-3750}},
        },
        [92814] = { -- I Need a Tailor
            [questKeys.preQuestSingle] = {1370},
        },
        [92817] = { -- Leather Technique
            [questKeys.preQuestSingle] = {1370},
        },
        [92818] = { -- Big, No, MASSIVE Iron Axes
            [questKeys.preQuestSingle] = {1369},
        },
        [92819] = { -- Destruction in Deadmines
            [questKeys.preQuestSingle] = {92753},
            [questKeys.objectives] = {nil,{{581792}}},
        },
        [92833] = { -- Ve'han's Fall
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92169},
        },
        [92834] = { -- Avenged Tenfold
            [questKeys.preQuestSingle] = {92840},
        },
        [92840] = { -- Catching Wind
            [questKeys.preQuestSingle] = {99260},
            [questKeys.objectives] = {nil,{{697118}}},
            [questKeys.nextQuestInChain] = 0,
        },
        [92841] = { -- Valley of Bones
            [questKeys.preQuestSingle] = {92743},
            [questKeys.nextQuestInChain] = 92844,
        },
        [92842] = { -- A Cousin Abroad
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.exclusiveTo] = {97319},
        },
        [92844] = { -- Mountain of Bones
            [questKeys.preQuestSingle] = {92841},
        },
        [92846] = { -- Outcast Necromancers
            [questKeys.preQuestSingle] = {92841},
        },
        [92847] = { -- Corrupting Tears
            [questKeys.preQuestGroup] = {92844,92846},
            [questKeys.nextQuestInChain] = 92873,
        },
        [92849] = { -- The Missing Scholar
            [questKeys.preQuestSingle] = {92727},
            [questKeys.nextQuestInChain] = 92850,
            [questKeys.objectives] = {{{253002,nil,Questie.ICON_TYPE_INTERACT}},{{581820}}},
        },
        [92850] = { -- The Missing Scholar
            [questKeys.finishedBy] = {{253285}},
            [questKeys.preQuestSingle] = {92849},
            [questKeys.nextQuestInChain] = 99260,
        },
        [92858] = { -- WANTED: Ohk'zi
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92859] = { -- Shroud of the Winter Wilds
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92860] = { -- In Service of Zephras
            [questKeys.preQuestSingle] = {92840},
            [questKeys.nextQuestInChain] = 93320,
        },
        [92871] = { -- In Service of Zephras
            [questKeys.preQuestSingle] = {93746},
            [questKeys.nextQuestInChain] = 93320,
        },
        [92873] = { -- Proof of Concept
            [questKeys.preQuestSingle] = {92847},
            [questKeys.nextQuestInChain] = 92894,
        },
        [92880] = { -- Return to Valanaar
            [questKeys.preQuestGroup] = {92642,92645},
            [questKeys.nextQuestInChain] = 92881,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92881] = { -- The High Elder's Request
            [questKeys.preQuestSingle] = {92880},
            [questKeys.nextQuestInChain] = 92643,
        },
        [92893] = { -- No Mercy for the Weak
            [questKeys.preQuestSingle] = {92873},
        },
        [92894] = { -- Bone Raising
            [questKeys.preQuestSingle] = {92873},
        },
        [92909] = { -- Harvesting the Harvesters
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92910] = { -- Harvesting the Harvesters
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92911,
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
        },
        [92911] = { -- Harvesting the Harvesters
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {92910},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.objectives] = {nil,nil,{{255007},{4363},{4405}}},
        },
        [92914] = { -- Strange Pylons
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.nextQuestInChain] = 96010,
        },
        [92947] = { -- Making Our Move
            [questKeys.preQuestSingle] = {93065},
            [questKeys.nextQuestInChain] = 93958,
            [questKeys.objectives] = {{{252762},{252763},{252765},{253576,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92959] = { -- The Dying Ancients
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {91770},
        },
        [92960] = { -- Siphoned Ephemeral Essence
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 96003,
        },
        [93016] = { -- A Brief History Lesson
            [questKeys.requiredLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96018},
            [questKeys.nextQuestInChain] = 93394,
        },
        [93034] = { -- Valley of Bones
            [questKeys.preQuestSingle] = {1373},
            [questKeys.nextQuestInChain] = 93035,
        },
        [93035] = { -- Ravaging Ravagers
            [questKeys.preQuestSingle] = {93034},
        },
        [93036] = { -- Infiltrating the Cult
            [questKeys.preQuestSingle] = {92517},
            [questKeys.nextQuestInChain] = 92529,
        },
        [93037] = { -- Outing Outcasts
            [questKeys.preQuestSingle] = {93034},
        },
        [93041] = { -- Facing the Truth
            [questKeys.preQuestGroup] = {93035,93037},
            [questKeys.nextQuestInChain] = 93044,
        },
        [93044] = { -- A Cleansing Cry
            [questKeys.preQuestSingle] = {93041},
            [questKeys.nextQuestInChain] = 93045,
        },
        [93045] = { -- Test Your Theory
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {93044},
        },
        [93058] = { -- Saving Our Own
            [questKeys.preQuestSingle] = {93045},
        },
        [93062] = { -- Bone Burying
            [questKeys.preQuestSingle] = {93045},
        },
        [93065] = { -- Prepare for Battle
            [questKeys.preQuestSingle] = {92640},
            [questKeys.nextQuestInChain] = 92947,
            [questKeys.objectives] = {{{253844,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [93066] = { -- Bristleback Retreat
            [questKeys.preQuestGroup] = {92893,92894},
            [questKeys.nextQuestInChain] = 93072,
        },
        [93072] = { -- Long-Term Solutions
            [questKeys.preQuestSingle] = {93066},
        },
        [93089] = { -- What Comes Next
            [questKeys.preQuestSingle] = {94369},
            [questKeys.nextQuestInChain] = 94946,
        },
        [93090] = { -- What Comes Next
            [questKeys.preQuestSingle] = {93836},
            [questKeys.nextQuestInChain] = 95349,
        },
        [93122] = { -- Checking Things Out
            [questKeys.preQuestGroup] = {93058,93062},
            [questKeys.nextQuestInChain] = 93128,
        },
        [93127] = { -- Summit Sentries
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93407},
        },
        [93128] = { -- Khan Jehn
            [questKeys.preQuestSingle] = {93122},
        },
        [93129] = { -- Threat of Starvation
            [questKeys.preQuestSingle] = {93066},
        },
        [93159] = { -- The Strange Hermit
            [questKeys.objectives] = {{{251684,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93160] = { -- The Forest's Bounty
            [questKeys.preQuestSingle] = {93159},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93161] = { -- The Ancient Hilt
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = -1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.ZEPHRAS_ISLE,
            [questKeys.nextQuestInChain] = 97029,
        },
        [93162] = { -- Head of the Obliterator
            [questKeys.requiredLevel] = 40,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93165] = { -- Mercy Falls on Deaf Ears
            [questKeys.preQuestSingle] = {94484,94493},
            [questKeys.nextQuestInChain] = 93459,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93172] = { -- Free the Hollows
            [questKeys.preQuestSingle] = {93159},
            [questKeys.objectives] = {{{251676}}},
        },
        [93176] = { -- My Little Friends
            [questKeys.objectives] = {nil,nil,{{213566,nil,Questie.ICON_TYPE_INTERACT},{213568,nil,Questie.ICON_TYPE_INTERACT},{213567,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [93188] = { -- Return to Orgrul
            [questKeys.preQuestGroup] = {93072,93129},
            [questKeys.nextQuestInChain] = 93196,
        },
        [93196] = { -- Khan Jehn
            [questKeys.preQuestSingle] = {93188},
        },
        [93197] = { -- Mending Communications
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 93406,
        },
        [93224] = { -- Carved Centaur Totems
            [questKeys.exclusiveTo] = {93225},
        },
        [93225] = { -- Carved Centaur Totems
            [questKeys.exclusiveTo] = {93224},
        },
        [93226] = { -- Buying Friendship: Magram
            [questKeys.requiredMinRep] = {factionIDs.MAGRAM_CLAN_CENTAUR, 0},
            [questKeys.preQuestSingle] = {93224,93225},
            [questKeys.exclusiveTo] = {93227,94872,94873},
        },
        [93227] = { -- Buying Friendship: Gelkis
            [questKeys.requiredMinRep] = {factionIDs.GELKIS_CLAN_CENTAUR, 0},
            [questKeys.preQuestSingle] = {93224,93225},
            [questKeys.exclusiveTo] = {93226,94872,94873},
        },
        [93269] = { -- Top of the Post
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93406},
        },
        [93317] = { -- Crab Season
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93318] = { -- WANTED: Vulgara the Insatiable
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93319] = { -- Pilfered Windstones
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93320] = { -- Tower Defense
            [questKeys.preQuestSingle] = {92860,92871},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93341] = { -- Forlorn Gardens
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {93394},
        },
        [93362] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93341},
        },
        [93383] = { -- Contents Under Pressure
            [questKeys.preQuestSingle] = {96559},
        },
        [93394] = { -- Meeting the Magister
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {93016},
        },
        [93404] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93594},
            [questKeys.nextQuestInChain] = 93601,
        },
        [93406] = { -- Unfrozen Deliveries
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93197},
        },
        [93407] = { -- A Thorn in the Paw
            [questKeys.requiredLevel] = 57,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 93547,
        },
        [93422] = { -- Blackthorne Blackout
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93443] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.exclusiveTo] = {94841,94895,94930},
        },
        [93444] = { -- Bait the Beast
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestGroup] = {92329,92533,93407},
        },
        [93450] = { -- Phantasmal Problems
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {93394},
            [questKeys.nextQuestInChain] = 93546,
        },
        [93459] = { -- More Al'Aketh Ears
            [questKeys.preQuestSingle] = {93165},
            [questKeys.objectivesText] = {}, -- turn in only quest, no objectivesText for these
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [93461] = { -- Welcome to Shen'dar Village
            [questKeys.objectives] = {{{251903,nil,Questie.ICON_TYPE_TALK},{254089,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.nextQuestInChain] = 0,
        },
        [93464] = { -- The Visiting Mage
            [questKeys.preQuestSingle] = {1389},
            [questKeys.nextQuestInChain] = 93465,
        },
        [93465] = { -- Notes on Draenethyst
            [questKeys.preQuestSingle] = {93464},
            [questKeys.nextQuestInChain] = 93678,
        },
        [93510] = { -- Wake Memories
            [questKeys.preQuestSingle] = {96550},
        },
        [93521] = { -- Challenger of the Gods
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93546] = { -- Spectral Iron Ore
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93450},
            [questKeys.nextQuestInChain] = 96060,
        },
        [93547] = { -- A Thorny Solution
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93407},
        },
        [93551] = { -- Praise
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93552] = { -- Harvesting Windstones
            [questKeys.preQuestSingle] = {92461},
        },
        [93567] = { -- Ends Meet
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92102},
        },
        [93568] = { -- Partially Digested Collar
            [questKeys.requiredLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93572] = { -- To Serve The Draenei
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93685},
        },
        [93574] = { -- Corpsefeeder's Carapace
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93584] = { -- Cult Closure
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93594] = { -- Word of the Woods
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93341},
            [questKeys.nextQuestInChain] = 93404,
        },
        [93601] = { -- Passing the Blame
            [questKeys.requiredLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93404},
            [questKeys.nextQuestInChain] = 93604,
        },
        [93604] = { -- Agamaggan's Blood
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93601},
            [questKeys.nextQuestInChain] = 93606,
        },
        [93606] = { -- Not on Squealing Terms
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93604},
        },
        [93609] = { -- Forlorn Necklace
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93615] = { -- Kits and Cats
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93617] = { -- Prey and Predator
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96978},
        },
        [93644] = { -- Tattered Journal
            [questKeys.startedBy] = {nil,nil,{260347}},
            [questKeys.requiredLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.SHEN_DRALAS,
        },
        [93678] = { -- Abridged Notes on Draenethyst
            [questKeys.preQuestSingle] = {93465},
            [questKeys.nextQuestInChain] = 93679,
        },
        [93679] = { -- Visions of Another
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93678},
            [questKeys.nextQuestInChain] = 93684,
        },
        [93684] = { -- The Found One
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93679},
            [questKeys.nextQuestInChain] = 93685,
        },
        [93685] = { -- To Serve Kum'isha
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93684},
        },
        [93686] = { -- Kum'isha's Endeavors
            [questKeys.requiredLevel] = 45,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93735] = { -- The Broken Construct
            [questKeys.preQuestSingle] = {92700},
            [questKeys.nextQuestInChain] = 93737,
        },
        [93736] = { -- Unwelcome Spirits
            [questKeys.preQuestSingle] = {92700},
        },
        [93737] = { -- The Broken Construct
            [questKeys.preQuestSingle] = {93735},
            [questKeys.nextQuestInChain] = 93738,
            [questKeys.objectives] = {{{256083,nil,Questie.ICON_TYPE_EVENT}},nil,{{260881},{260883},{260880}}},
        },
        [93738] = { -- The Broken Construct
            [questKeys.preQuestSingle] = {93737},
            [questKeys.nextQuestInChain] = 93746,
        },
        [93739] = { -- Exploring the Horde
            [questKeys.preQuestSingle] = {95350},
            [questKeys.objectives] = {{{3230,nil,Questie.ICON_TYPE_TALK},{10540,nil,Questie.ICON_TYPE_TALK},{3057,nil,Questie.ICON_TYPE_TALK},{10181,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredSourceItems] = {285357},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_HORDE,
        },
        [93740] = { -- Blood for Blood
            [questKeys.preQuestSingle] = {93746},
        },
        [93746] = { -- A Firm Response
            [questKeys.preQuestSingle] = {93738},
            [questKeys.objectives] = {{{256247,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93747] = { -- Violence Into Verdure
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95568},
        },
        [93759] = { -- The Bounty of Nature
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestGroup] = {94479,95568,95569},
        },
        [93773] = { -- The Pact
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95006},
            [questKeys.nextQuestInChain] = 96930,
        },
        [93786] = { -- A Message in Blood
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [93787] = { -- Food for the Taking
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [93791] = { -- Speak with Belann
            [questKeys.nextQuestInChain] = 93797,
        },
        [93797] = { -- Boughs in the Wind
            [questKeys.preQuestSingle] = {93791},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [93825] = { -- Barkbound Blessings
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {91697},
        },
        [93826] = { -- Deal Dread to Deadwood
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {91697},
        },
        [93827] = { -- Windswept Wards
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {91697},
        },
        [93828] = { -- Herbs of the Hollow
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93830] = { -- Water of Hyjal
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93831] = { -- Sweetpaw Jam
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92111},
        },
        [93832] = { -- Shatter the Stonewatchers
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93833] = { -- Wicked Wisdom
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93834] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93835] = { -- Confront Lorthuna
            [questKeys.preQuestSingle] = {93958},
            [questKeys.nextQuestInChain] = 94369,
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Confront Lorthuna", {[zoneIDs.ZEPHRAS_ISLE] = {{74.87,53.02}}}},
            [questKeys.extraObjectives] = {
                {nil, Questie.ICON_TYPE_OBJECT, l10n("Take the portal"), 0, {{"object", 586726}}},
                {nil, Questie.ICON_TYPE_TALK, l10n("Start the fight"), 0, {{"monster", 253847}}},
            },
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.exclusiveTo] = {92646},
        },
        [93836] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {92646},
            [questKeys.nextQuestInChain] = 93090,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93848] = { -- Work Well Done
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92833},
        },
        [93925] = { -- Beads for Brerufa
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93952},
        },
        [93926] = { -- The Western Watch
            [questKeys.preQuestSingle] = {92528},
            [questKeys.nextQuestInChain] = 93927,
            [questKeys.objectives] = {{{252155,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93927] = { -- A Last Request
            [questKeys.preQuestSingle] = {93926},
            [questKeys.objectives] = {{{256966}},nil,{{254871},{263415},{263418}}}, -- double whammy
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93948] = { -- Deliver the Signet
            [questKeys.finishedBy] = {{252476}},
            [questKeys.preQuestGroup] = {92550,93927}, -- 92551 not needed
            [questKeys.nextQuestInChain] = 93949,
        },
        [93949] = { -- Bugged
            [questKeys.preQuestSingle] = {93948},
            [questKeys.objectives] = {{{251727}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93951] = { -- A Little Beauty
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [93952] = { -- Balance Through Strength
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93958] = { -- The Inner Sanctum
            [questKeys.preQuestSingle] = {92947},
        },
        [93963] = { -- Exploring the Alliance
            [questKeys.preQuestSingle] = {94947},
            [questKeys.objectives] = {{{275491,nil,Questie.ICON_TYPE_TALK},{7937,nil,Questie.ICON_TYPE_TALK},{2784,nil,Questie.ICON_TYPE_TALK},{7999,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredSourceItems] = {285356},
            [questKeys.reputationReward] = {{factionIDs.ALLIANCE, 100}, {factionIDs.GNOMEREGAN_EXILES, 175}, {factionIDs.STORMWIND, 175}, {factionIDs.DARNASSUS, 175}, {factionIDs.IRONFORGE, 175}, {factionIDs.KIRIN_TOR_FOREVER, 100}},
        },
        [93976] = { -- The Goblin Trader
            [questKeys.preQuestSingle] = {93788},
            [questKeys.nextQuestInChain] = 95288,
        },
        [94003] = { -- The Skybreaker Bulwark
            [questKeys.requiredClasses] = classIDs.WARRIOR,
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94004] = { -- Craftsman's Writ: Elixir of Ogre's Strength
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94006] = { -- The Great Ursera Spirit
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.nextQuestInChain] = 94638,
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94007] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94013] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {94979},
            [questKeys.nextQuestInChain] = 94050,
            [questKeys.objectives] = {{{250874,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.exclusiveTo] = {6063},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94050] = { -- Training the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {94013},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94212] = { -- Craftsman's Writ: Elixir of Wisdom
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94213] = { -- Craftsman's Writ: Lesser Mana Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94214] = { -- Craftsman's Writ: Shadow Protection Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94215] = { -- Craftsman's Writ: Free Action Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94216] = { -- Craftsman's Writ: Elixir of Lesser Agility
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94217] = { -- Craftsman's Writ: Lesser Troll's Blood Elixir
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94218] = { -- Craftsman's Writ: Elixir of Defense
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94219] = { -- Craftsman's Writ: Draught of Water Breathing
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94220] = { -- Craftsman's Writ: Pearl-Handled Dagger
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94221] = { -- Craftsman's Writ: Golden Rod
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94222] = { -- Craftsman's Writ: Iridescent Hammer
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94223] = { -- Craftsman's Writ: Silver Skeleton Key
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94224] = { -- Craftsman's Writ: Heavy Bronze Mace
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94225] = { -- Craftsman's Writ: Rough Bronze Leggings
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94226] = { -- Craftsman's Writ: Green Iron Gauntlets
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94227] = { -- Craftsman's Writ: Big Bronze Knife
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94228] = { -- Craftsman's Writ: Green Iron Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94229] = { -- Craftsman's Writ: Ornate Spyglass
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94230] = { -- Craftsman's Writ: Explosive Sheep
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94231] = { -- Craftsman's Writ: Moonsight Rifle
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94232] = { -- Craftsman's Writ: Minor Recombobulator
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94233] = { -- Craftsman's Writ: Practice Lock
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94234] = { -- Craftsman's Writ: Shadow Goggles
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94235] = { -- Craftsman's Writ: Gnomish Universal Remote
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94236] = { -- Craftsman's Writ: Big Bronze Bomb
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94237] = { -- Craftsman's Writ: Crafted Solid Shot
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94238] = { -- Craftsman's Writ: Heavy Leather Ball
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94239] = { -- Craftsman's Writ: Fine Leather Pants
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94240] = { -- Craftsman's Writ: Herbalist's Gloves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94241] = { -- Craftsman's Writ: Dark Leather Tunic
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94242] = { -- Craftsman's Writ: Pilferer's Gloves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94243] = { -- Craftsman's Writ: Heavy Quiver
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94244] = { -- Craftsman's Writ: Dark Leather Shoulders
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94245] = { -- Craftsman's Writ: Barbaric Gloves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94246] = { -- Craftsman's Writ: Red Whelp Gloves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94247] = { -- Craftsman's Writ: Lesser Wizard's Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94248] = { -- Craftsman's Writ: Blue Overalls
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94249] = { -- Craftsman's Writ: Azure Silk Hood
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94250] = { -- Craftsman's Writ: Small Silk Pack
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94251] = { -- Craftsman's Writ: Phoenix Pants
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94252] = { -- Craftsman's Writ: Red Woolen Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94253] = { -- Craftsman's Writ: Colorful Kilt
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94254] = { -- Craftsman's Writ: Greater Adept's Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94255] = { -- Craftsman's Writ: Spider Silk Slippers
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94256] = { -- Craftsman's Writ: Frost Protection Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94257] = { -- Craftsman's Writ: Lesser Invisibility Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94258] = { -- Craftsman's Writ: Lesser Stoneshield Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94259] = { -- Craftsman's Writ: Nature Protection Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94260] = { -- Craftsman's Writ: Catseye Draught
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94261] = { -- Craftsman's Writ: Great Rage Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94262] = { -- Craftsman's Writ: Mana Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94263] = { -- Craftsman's Writ: Fire Protection Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94264] = { -- Craftsman's Writ: Shadow Oil
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94265] = { -- Craftsman's Writ: Goblin Rocket Fuel
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94266] = { -- Craftsman's Writ: Elixir of Agility
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94267] = { -- Craftsman's Writ: Wildvine Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94268] = { -- Craftsman's Writ: Steel Plate Helm
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94269] = { -- Craftsman's Writ: Inlaid Mithril Cylinder
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94270] = { -- Craftsman's Writ: Steel Weapon Chain
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94271] = { -- Craftsman's Writ: Ornate Mithril Shoulders
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94272] = { -- Craftsman's Writ: Blue Glittering Axe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94273] = { -- Craftsman's Writ: Moonsteel Broadsword
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94274] = { -- Craftsman's Writ: Golden Scale Coif
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94275] = { -- Craftsman's Writ: Solid Sharpening Stone
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94276] = { -- Craftsman's Writ: Wicked Mithril Blade
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94277] = { -- Craftsman's Writ: Truesilver Rod
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94278] = { -- Craftsman's Writ: Golden Scale Gauntlets
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94279] = { -- Craftsman's Writ: Heavy Mithril Axe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94280] = { -- Craftsman's Writ: Mechanical Dragonling
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94281] = { -- Craftsman's Writ: Advanced Target Dummy
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94282] = { -- Craftsman's Writ: Craftsman's Monocle
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94283] = { -- Craftsman's Writ: Goblin Land Mine
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94284] = { -- Craftsman's Writ: Catseye Ultra Goggles
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94285] = { -- Craftsman's Writ: Unstable Trigger
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94286] = { -- Craftsman's Writ: Flash Bomb
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94287] = { -- Craftsman's Writ: Fire Goggles
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94288] = { -- Craftsman's Writ: Mithril Frag Bomb
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94289] = { -- Craftsman's Writ: Gyromatic Micro-Adjuster
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94290] = { -- Craftsman's Writ: Mechanical Repair Kit
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94291] = { -- Craftsman's Writ: Dark Iron Bomb
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94292] = { -- Craftsman's Writ: Comfortable Leather Hat
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94293] = { -- Craftsman's Writ: Guardian Cloak
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94294] = { -- Craftsman's Writ: Dusky Bracers
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94295] = { -- Craftsman's Writ: Wild Leather Helmet
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94296] = { -- Craftsman's Writ: Wild Leather Shoulders
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94297] = { -- Craftsman's Writ: Quickdraw Quiver
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94298] = { -- Craftsman's Writ: Swift Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94299] = { -- Craftsman's Writ: Nightscape Shoulders
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94300] = { -- Craftsman's Writ: Big Voodoo Mask
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94301] = { -- Craftsman's Writ: Big Voodoo Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94302] = { -- Craftsman's Writ: Turtle Scale Breastplate
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94303] = { -- Craftsman's Writ: Thick Leather Ammo Pouch
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94304] = { -- Craftsman's Writ: Mageweave Bag
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94305] = { -- Craftsman's Writ: Shadoweave Gloves
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94306] = { -- Craftsman's Writ: Crimson Silk Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94307] = { -- Craftsman's Writ: Shadoweave Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94308] = { -- Craftsman's Writ: Enchanted Mageweave Pouch
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94309] = { -- Craftsman's Writ: Star Belt
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94310] = { -- Craftsman's Writ: Black Mageweave Vest
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94311] = { -- Craftsman's Writ: Red Mageweave Pants
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94312] = { -- Craftsman's Writ: Orange Martial Shirt
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94313] = { -- Craftsman's Writ: White Bandit Mask
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94314] = { -- Craftsman's Writ: Cindercloth Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94315] = { -- Craftsman's Writ: Earthen Silk Belt
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94316] = { -- Craftsman's Writ: Potion of Demonslaying
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94317] = { -- Craftsman's Writ: Dreamless Sleep Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94318] = { -- Craftsman's Writ: Greater Fire Protection Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94319] = { -- Craftsman's Writ: Draught of Detect Demon
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94320] = { -- Craftsman's Writ: Gift of Arthas
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94321] = { -- Craftsman's Writ: Flask of Chromatic Resistance
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94322] = { -- Craftsman's Writ: Limited Invulnerability Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94323] = { -- Craftsman's Writ: Major Rejuvenation Potion
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94324] = { -- Craftsman's Writ: Distilled Firewater
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94325] = { -- Craftsman's Writ: Radiant Circlet
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94326] = { -- Craftsman's Writ: Radiant Belt
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94327] = { -- Craftsman's Writ: Orcish War Leggings
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94328] = { -- Craftsman's Writ: Mithril Spurs
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94329] = { -- Craftsman's Writ: Imperial Plate Chest
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94330] = { -- Craftsman's Writ: Darkrune Gauntlets
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94331] = { -- Craftsman's Writ: Huge Thorium Battleaxe
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94332] = { -- Craftsman's Writ: Arcanite Skeleton Key
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94333] = { -- Craftsman's Writ: Ebon Shiv
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94334] = { -- Craftsman's Writ: Masterwork Target Dummy
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94335] = { -- Craftsman's Writ: Green Lens
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94336] = { -- Craftsman's Writ: Lifelike Mechanical Toad
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94337] = { -- Craftsman's Writ: Gnomish Alarm-O-Bot
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94338] = { -- Craftsman's Writ: Goblin Jumper Cables XL
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94339] = { -- Craftsman's Writ: Field Repair Bot 74A
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94340] = { -- Craftsman's Writ: Truesilver Transformer
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94341] = { -- Craftsman's Writ: Sniper Scope
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94342] = { -- Craftsman's Writ: Tranquil Mechanical Yeti
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94343] = { -- Craftsman's Writ: Gordok Ogre Suit
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94344] = { -- Craftsman's Writ: Wicked Leather Pants
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94345] = { -- Craftsman's Writ: Volcanic Breastplate
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94346] = { -- Craftsman's Writ: Runic Leather Headband
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94347] = { -- Craftsman's Writ: Wicked Leather Bracers
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94348] = { -- Craftsman's Writ: Chimeric Vest
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94349] = { -- Craftsman's Writ: Heavy Scorpid Helm
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94350] = { -- Craftsman's Writ: Runic Leather Bracers
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94351] = { -- Craftsman's Writ: Frostsaber Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94352] = { -- Craftsman's Writ: Wizardweave Turban
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94353] = { -- Craftsman's Writ: Runecloth Bag
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94354] = { -- Craftsman's Writ: Runecloth Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94355] = { -- Craftsman's Writ: Tuxedo Jacket
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94356] = { -- Craftsman's Writ: Felcloth Boots
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94357] = { -- Craftsman's Writ: Cenarion Herb Bag
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94358] = { -- Craftsman's Writ: Shadoweave Mask
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94359] = { -- Craftsman's Writ: Ghostweave Vest
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94360] = { -- Craftsman's Writ: Soul Pouch
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.questFlags] = questFlags.DAILY,
        },
        [94369] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {93835},
            [questKeys.nextQuestInChain] = 93089,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94373] = { -- Call of Earth
            [questKeys.nextQuestInChain] = 94374,
            [questKeys.exclusiveTo] = {1516,1519,92466},
        },
        [94374] = { -- Call of Earth
            [questKeys.preQuestSingle] = {94373},
            [questKeys.nextQuestInChain] = 94375,
            [questKeys.exclusiveTo] = {1517,1520,92467},
        },
        [94375] = { -- Call of Earth
            [questKeys.startedBy_add] = {{257446}},
            [questKeys.preQuestSingle] = {94374},
            [questKeys.exclusiveTo] = {1518,1521,92468},
        },
        [94411] = { -- Meddlesome Mages
            [questKeys.preQuestSingle] = {92595},
            [questKeys.objectives] = {{{257521}}},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [94413] = { -- A Magical Affront
            [questKeys.preQuestSingle] = {92596},
            [questKeys.objectives] = {{{257532}}},
        },
        [94414] = { -- The Anchors of Zephras
            [questKeys.objectives] = {{{257554,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94427] = { -- A Lesson in Divinity
            [questKeys.nextQuestInChain] = 94434,
        },
        [94434] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94427},
            [questKeys.nextQuestInChain] = 94435,
        },
        [94435] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94434},
            [questKeys.nextQuestInChain] = 94436,
        },
        [94436] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94435},
            [questKeys.nextQuestInChain] = 94438,
        },
        [94438] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94436},
            [questKeys.requiredSourceItems] = {6866},
            [questKeys.nextQuestInChain] = 94440,
        },
        [94440] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94438},
            [questKeys.objectivesText] = {"Retrieve the Scarlet Crusade Attack Plans from the Scarlet Crusaders at Venomweb Vale, and return to Deathguard Billmuth at Bandarion Keep."},
            [questKeys.nextQuestInChain] = 94441,
        },
        [94441] = { -- A Lesson in Divinity
            [questKeys.preQuestSingle] = {94440},
        },
        [94465] = { -- Call of Fire
            [questKeys.nextQuestInChain] = 94466,
        },
        [94466] = { -- Call of Fire
            [questKeys.preQuestSingle] = {94465},
            [questKeys.nextQuestInChain] = 94467,
        },
        [94467] = { -- Call of Fire
            [questKeys.preQuestSingle] = {94466},
            [questKeys.nextQuestInChain] = 94468,
        },
        [94468] = { -- Call of Fire
            [questKeys.preQuestSingle] = {94467},
        },
        [94472] = { -- Earth Sapta
            [questKeys.preQuestSingle] = {94373},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.availableUntilCompleted] = 94374,
        },
        [94473] = { -- Fire Sapta
            [questKeys.preQuestSingle] = {94466},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.availableUntilCompleted] = 94467,
        },
        [94479] = { -- One Person's Trash
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 96796,
        },
        [94480] = { -- A Gift From Our Enemies
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {93787},
            [questKeys.nextQuestInChain] = 94481,
        },
        [94481] = { -- A Serving of Strength
            [questKeys.preQuestSingle] = {94480},
            [questKeys.objectives] = {{{256749,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [94483] = { -- Show Them How It's Done
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestGroup] = {93786,93787},
        },
        [94484] = { -- Unnerving Silence
            [questKeys.exclusiveTo] = {94493},
        },
        [94485] = { -- Tears of the Lady
            [questKeys.preQuestSingle] = {94484,94493},
        },
        [94486] = { -- Feathers for Binding
            [questKeys.preQuestSingle] = {94484,94493},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94487] = { -- Unwanted and Unworthy
            [questKeys.preQuestSingle] = {94484,94493},
        },
        [94488] = { -- The Ties That Bind
            [questKeys.preQuestGroup] = {94485,94486,94487},
        },
        [94489] = { -- The Wounds of Betrayal
            [questKeys.preQuestGroup] = {94485,94486,94487},
            [questKeys.objectives] = {{{258130,nil,Questie.ICON_TYPE_TALK}},nil,nil,nil,{{{258134,258137,258138,258275,258277,258288,258289},258134,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94490] = { -- Ripped Missive
            [questKeys.preQuestGroup] = {94485,94486,94487},
            [questKeys.nextQuestInChain] = 94491,
        },
        [94491] = { -- The Fate of the Den
            [questKeys.preQuestSingle] = {94490},
        },
        [94493] = { -- A Sacrifice in Vain
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.exclusiveTo] = {94484},
        },
        [94494] = { -- Call of Water
            [questKeys.nextQuestInChain] = 94495,
        },
        [94495] = { -- Call of Water
            [questKeys.preQuestSingle] = {94494},
            [questKeys.nextQuestInChain] = 94497,
        },
        [94497] = { -- Call of Water
            [questKeys.preQuestSingle] = {94495},
            [questKeys.nextQuestInChain] = 94499,
        },
        [94499] = { -- Call of Water
            [questKeys.preQuestSingle] = {94497},
            [questKeys.nextQuestInChain] = 94500,
        },
        [94500] = { -- Call of Water
            [questKeys.preQuestSingle] = {94499},
            [questKeys.nextQuestInChain] = 94501,
        },
        [94501] = { -- Call of Water
            [questKeys.preQuestSingle] = {94500},
            [questKeys.nextQuestInChain] = 94502,
        },
        [94502] = { -- Call of Water
            [questKeys.preQuestSingle] = {94501},
            [questKeys.nextQuestInChain] = 94503,
        },
        [94503] = { -- Call of Water
            [questKeys.preQuestSingle] = {94502},
            [questKeys.nextQuestInChain] = 94505,
        },
        [94504] = { -- Barkskin Beginnings
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94505] = { -- Call of Water
            [questKeys.preQuestSingle] = {94503},
        },
        [94532] = { -- Gnoll Infestation
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96109},
            [questKeys.exclusiveTo] = {94678},
        },
        [94533] = { -- Snargl's Snout
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96109},
            [questKeys.exclusiveTo] = {94679},
        },
        [94535] = { -- Bristle Hills Bandits
            [questKeys.preQuestSingle] = {96109},
        },
        [94556] = { -- Jom-jom's Escape
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.triggerEnd] = {"Help Jom-Jom reach Bolder'ok", {[zoneIDs.RIVERGLADES] = {{64.57,14.84}}}},
        },
        [94568] = { -- The Cult's True Plans
            [questKeys.preQuestSingle] = {92644},
            [questKeys.nextQuestInChain] = 92640,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94613] = { -- My Kingdom for a Horse
            [questKeys.nextQuestInChain] = 94615,
        },
        [94614] = { -- Freshwater Fiends
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94615] = { -- Foal Play
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94613},
            [questKeys.nextQuestInChain] = 94617,
        },
        [94616] = { -- Water Sapta
            [questKeys.preQuestSingle] = {94501},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.availableUntilCompleted] = 94502,
        },
        [94617] = { -- Coyote Huntin'
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94615},
        },
        [94618] = { -- Wheeler's Fleeing Steeds
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94615},
            [questKeys.nextQuestInChain] = 94992,
        },
        [94638] = { -- Strength and Mercy
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.preQuestSingle] = {94006},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94668] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestGroup] = {95424,95425},
            [questKeys.nextQuestInChain] = 94669,
        },
        [94669] = { -- Pay to Play
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94668},
            [questKeys.nextQuestInChain] = 94670,
        },
        [94670] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94669},
            [questKeys.nextQuestInChain] = 94739,
            [questKeys.objectives] = {{{257056}}},
        },
        [94672] = { -- Encroaching Twilight
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94483},
        },
        [94678] = { -- Gnoll Infestation
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.exclusiveTo] = {94532},
        },
        [94679] = { -- Snargl's Snout
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.exclusiveTo] = {94533},
        },
        [94680] = { -- Twilight Missives
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94483},
        },
        [94727] = { -- Digging for Answers
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestGroup] = {94672,94680},
            [questKeys.objectives] = {{{260931,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94733] = { -- Our Ogre Friend
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94964},
            [questKeys.nextQuestInChain] = 94734,
        },
        [94734] = { -- A Boar's Delight
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94733},
            [questKeys.nextQuestInChain] = 94737,
        },
        [94737] = { -- A Treat for a Friend
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94734},
            [questKeys.nextQuestInChain] = 94965,
        },
        [94739] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94670},
            [questKeys.nextQuestInChain] = 94962,
            [questKeys.objectives] = {{{258491}}},
        },
        [94744] = { -- The Wayward Warrior
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95428},
        },
        [94745] = { -- Carving a Path
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94744},
        },
        [94748] = { -- Break Their Chains
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94744},
            [questKeys.requiredSourceItems] = {265821},
            [questKeys.objectives] = {{{257450,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.extraObjectives] = {{nil,Questie.ICON_TYPE_OBJECT,l10n("Open the cage"),0,{{"object",620625}}}},
        },
        [94768] = { -- Bring Me His Head
            [questKeys.preQuestGroup] = {94745,94748},
        },
        [94773] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94774,94775,94776,94777,94778,94779},
        },
        [94774] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94775,94776,94777,94778,94779},
        },
        [94775] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94774,94776,94777,94778,94779},
        },
        [94776] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94774,94775,94777,94778,94779},
        },
        [94777] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94774,94775,94776,94778,94779},
        },
        [94778] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94774,94775,94776,94777,94779},
        },
        [94779] = { -- Divine Grace
            [questKeys.exclusiveTo] = {94773,94774,94775,94776,94777,94778},
        },
        [94782] = { -- The Western Post
            [questKeys.preQuestSingle] = {95316},
            [questKeys.exclusiveTo] = {91881},
        },
        [94789] = { -- Call of Air
            [questKeys.nextQuestInChain] = 96264,
        },
        [94792] = { -- Taming the Beast
            [questKeys.objectives] = {{{524,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.nextQuestInChain] = 94863,
        },
        [94793] = { -- Training the Beast
            [questKeys.preQuestSingle] = {94864},
        },
        [94817] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94821,94822,94823,94824,94825,94826},
        },
        [94818] = { -- Contingency Plan
            [questKeys.exclusiveTo] = {94819,94820},
        },
        [94819] = { -- Contingency Plan
            [questKeys.exclusiveTo] = {94818,94820},
        },
        [94820] = { -- Contingency Plan
            [questKeys.exclusiveTo] = {94818,94819},
        },
        [94821] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94822,94823,94824,94825,94826},
        },
        [94822] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94821,94823,94824,94825,94826},
        },
        [94823] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94821,94822,94824,94825,94826},
        },
        [94824] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94821,94822,94823,94825,94826},
        },
        [94825] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94821,94822,94823,94824,94826},
        },
        [94826] = { -- Confounding Flash
            [questKeys.exclusiveTo] = {94817,94821,94822,94823,94824,94825},
        },
        [94829] = { -- What We Lost
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 94858,
        },
        [94832] = { -- Belle's Ring
            [questKeys.preQuestSingle] = {95218},
            [questKeys.nextQuestInChain] = 96077,
        },
        [94841] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.exclusiveTo] = {93443,94895,94930},
        },
        [94842] = { -- Unsavory Plant Food
            [questKeys.nextQuestInChain] = 94843,
        },
        [94843] = { -- From Seed to Sprout
            [questKeys.preQuestSingle] = {94842},
        },
        [94857] = { -- If a Tree Falls, and No One Hears...
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 94861,
        },
        [94858] = { -- All That's Left
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94829},
        },
        [94861] = { -- Helping Hands
            [questKeys.preQuestSingle] = {94857},
        },
        [94863] = { -- Taming the Beast
            [questKeys.preQuestSingle] = {94792},
            [questKeys.objectives] = {{{1922,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.nextQuestInChain] = 94864,
        },
        [94864] = { -- Taming the Beast
            [questKeys.preQuestSingle] = {94863},
            [questKeys.objectives] = {{{822,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.nextQuestInChain] = 94793,
        },
        [94872] = { -- Buying Friendship: Magram
            [questKeys.requiredMinRep] = {factionIDs.MAGRAM_CLAN_CENTAUR, 0},
            [questKeys.preQuestSingle] = {93224,93225},
            [questKeys.exclusiveTo] = {93226,93227,94873},
        },
        [94873] = { -- Buying Friendship: Gelkis
            [questKeys.requiredMinRep] = {factionIDs.GELKIS_CLAN_CENTAUR, 0},
            [questKeys.preQuestSingle] = {93224,93225},
            [questKeys.exclusiveTo] = {93226,93227,94872},
        },
        [94877] = { -- Saving Sunnyglade
            [questKeys.nextQuestInChain] = 95329,
        },
        [94884] = { -- An Unsettling Discovery
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95562},
        },
        [94885] = { -- Field Marshal's Log
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 94887,
        },
        [94886] = { -- The Western Front
            [questKeys.preQuestSingle] = {94879},
        },
        [94887] = { -- Saving Marshal Ryan
            [questKeys.preQuestSingle] = {94885},
            [questKeys.nextQuestInChain] = 94892,
        },
        [94888] = { -- No Soldier Left Behind
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94886},
        },
        [94889] = { -- Carving a Path
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94886},
        },
        [94890] = { -- Bring Me His Head
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestGroup] = {94888,94889},
            [questKeys.nextQuestInChain] = 94891,
        },
        [94891] = { -- News to Farholde
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94890},
        },
        [94892] = { -- Dying Wish
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94887},
            [questKeys.nextQuestInChain] = 94893,
        },
        [94893] = { -- Delivering Closure
            [questKeys.preQuestSingle] = {94892},
        },
        [94894] = { -- The Twilight Threat
            [questKeys.preQuestSingle] = {94891},
        },
        [94895] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.exclusiveTo] = {93443,94841,94930},
        },
        [94896] = { -- Aid For The Refugees
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94897] = { -- The Fate of a Loved One
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94907] = { -- A Small Favor
            [questKeys.preQuestSingle] = {94881},
            [questKeys.nextQuestInChain] = 94984,
        },
        [94911] = { -- Child of Nature
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94912] = { -- Child of Nature
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94913] = { -- Moonglade
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94914] = { -- Moonglade
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94923] = { -- Hats Off
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94925] = { -- A Fur Trade
            [questKeys.nextQuestInChain] = 94928,
        },
        [94927] = { -- Dunston Checks Out
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {96126},
        },
        [94928] = { -- A Few Furs for Friz
            [questKeys.preQuestSingle] = {94925},
            [questKeys.nextQuestInChain] = 95288,
        },
        [94929] = { -- Deliver the Second Shipment
            [questKeys.preQuestSingle] = {1398},
        },
        [94930] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.exclusiveTo] = {93443,94841,94895},
        },
        [94946] = { -- The Magical City of Dalaran
            [questKeys.preQuestSingle] = {93089},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [94947] = { -- Welcome to Azeroth
            [questKeys.nextQuestInChain] = 93963,
            [questKeys.objectives] = {nil,{{631299}}},
        },
        [94961] = { -- Biting the Hand
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 94963,
        },
        [94962] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {94739},
            [questKeys.nextQuestInChain] = 94964,
            [questKeys.objectives] = {{{255892}}},
        },
        [94963] = { -- Biting the Hand
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {94961},
            [questKeys.triggerEnd] = {"Help Fuzzle escape Sunnyglade.", {[zoneIDs.RIVERGLADES] = {{41.62,47.73}}}},
        },
        [94964] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {94962},
            [questKeys.nextQuestInChain] = 94733,
            [questKeys.objectives] = {{{258626}}},
        },
        [94965] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {94737},
            [questKeys.nextQuestInChain] = 95063,
            [questKeys.objectives] = {{{258595}}},
        },
        [94968] = { -- Eye of Mugg
            [questKeys.preQuestSingle] = {95278},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94969] = { -- Krol'dok No More!
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94972] = { -- Tome of Twilight
            [questKeys.preQuestSingle] = {95278},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94973] = { -- Krol'dok Moulding
            [questKeys.nextQuestInChain] = 94974,
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94974] = { -- Key Ingredients
            [questKeys.preQuestSingle] = {94973},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94975] = { -- A Token of Vengeance
            [questKeys.preQuestSingle] = {94768},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94978] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.nextQuestInChain] = 94979,
            [questKeys.objectives] = {{{254588,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94979] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {94978},
            [questKeys.nextQuestInChain] = 94013,
            [questKeys.objectives] = {{{251707,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94980] = { -- Krol'dok Moulding
            [questKeys.nextQuestInChain] = 94981,
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94981] = { -- Key Ingredients
            [questKeys.preQuestSingle] = {94980},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94982] = { -- Eye of Mugg
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94983] = { -- Twilight Mementos
            [questKeys.preQuestSingle] = {94890},
            [questKeys.nextQuestInChain] = 94997,
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94984] = { -- Tome of Twilight
            [questKeys.preQuestSingle] = {94907},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94992] = { -- Rescue Roundup
            [questKeys.preQuestSingle] = {94618},
        },
        [94997] = { -- Lingering Essence
            [questKeys.preQuestSingle] = {94983},
            [questKeys.nextQuestInChain] = 94998,
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [94998] = { -- Curios of Curiosity
            [questKeys.preQuestSingle] = {94997},
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [95006] = { -- Stolen Power
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96209},
            [questKeys.nextQuestInChain] = 93773,
        },
        [95026] = { -- Blight No More
            [questKeys.exclusiveTo] = {92449},
        },
        [95027] = { -- Feathers in Flight
            [questKeys.exclusiveTo] = {92609},
        },
        [95034] = { -- The Debt
            [questKeys.preQuestSingle] = {96204},
            [questKeys.nextQuestInChain] = 95036,
            [questKeys.objectives] = {{{259620,nil,Questie.ICON_TYPE_TALK}}},
        },
        [95036] = { -- A Moon-Kissed Blade
            [questKeys.requiredRaces] = raceIDs.UNDEAD,
            [questKeys.preQuestSingle] = {95034},
            [questKeys.nextQuestInChain] = 95111,
            [questKeys.objectives] = {nil,nil,{{267454,nil,Questie.ICON_TYPE_TALK},{6994},{267361},{272448}}},
            [questKeys.childQuests] = {95042},
        },
        [95042] = { -- Seeking the Kor Gem
            [questKeys.parentQuest] = 95036,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [95056] = { -- Krol'dok No More!
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [95059] = { -- Frazzlespark's Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95062] = { -- Frazzlespark's Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95063] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94965},
            [questKeys.objectives] = {{{257059}}},
        },
        [95064] = { -- Preventative Measures
            [questKeys.preQuestSingle] = {94924},
        },
        [95065] = { -- Fishin' Time
            [questKeys.objectives] = {nil,nil,{{6529},{6530}}},
        },
        [95066] = { -- The Rog'mar Situation
            [questKeys.preQuestGroup] = {95064,95426},
        },
        [95107] = { -- Deeproar Down
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95108] = { -- Mystic Mix
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95111] = { -- An Underrated Talent
            [questKeys.preQuestSingle] = {95036},
            [questKeys.nextQuestInChain] = 95125,
        },
        [95118] = { -- Saltwater Savages
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95119] = { -- Unfriendly Competition
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95120] = { -- WANTED: Old Rot-Chum
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95121] = { -- A Taste of the Sea
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95122] = { -- Unchecked Expansion
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95119},
        },
        [95123] = { -- A Blast Ye Scurvy Dogs!
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95119},
        },
        [95124] = { -- Admiral Lamora
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95123},
            [questKeys.requiredSourceItems] = {268520},
        },
        [95125] = { -- Ott's Masterwork
            [questKeys.preQuestSingle] = {95111},
            [questKeys.nextQuestInChain] = 95126,
            [questKeys.objectives] = {{{3539,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [95126] = { -- The Moonsilver Blade
            [questKeys.preQuestSingle] = {95125},
            [questKeys.nextQuestInChain] = 95140,
        },
        [95140] = { -- Old Fire-Eye
            [questKeys.preQuestSingle] = {95126},
            [questKeys.objectives] = {{{259897}},nil,{{268484}}},
        },
        [95144] = { -- Overseas Delivery
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95147] = { -- The Lost Scout
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 95148,
        },
        [95148] = { -- Southern Watch Gnoll Report
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95147},
        },
        [95156] = { -- Stuff 'Em and Stick 'Em
            [questKeys.nextQuestInChain] = 95184,
        },
        [95161] = { -- Remember That I Love You
            [questKeys.preQuestSingle] = {92415},
        },
        [95162] = { -- Paletusk Harvesting
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [95163] = { -- Drive Them Back
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {{{258331,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [95165] = { -- See Ya, Scallywags!
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95123},
            [questKeys.objectives] = {nil,{{629425},{629426},{629427}}},
        },
        [95183] = { -- Step One: Rock
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 96026,
            [questKeys.preQuestGroup] = {95424,95425},
        },
        [95184] = { -- The Sharpest of Blades
            [questKeys.preQuestSingle] = {95156},
        },
        [95189] = { -- Crest of Lordaeron
            [questKeys.requiredLevel] = 15,
            [questKeys.exclusiveTo] = {95204},
        },
        [95194] = { -- Our Man in Theramore
            [questKeys.nextQuestInChain] = 95196,
        },
        [95195] = { -- Bloodied Insignia
            [questKeys.requiredLevel] = 15,
        },
        [95196] = { -- Watch Yer Back
            [questKeys.preQuestSingle] = {95194},
            [questKeys.nextQuestInChain] = 95198,
        },
        [95198] = { -- The Return of the King?
            [questKeys.preQuestSingle] = {95196},
            [questKeys.nextQuestInChain] = 95262,
        },
        [95204] = { -- Crest of Lordaeron
            [questKeys.requiredLevel] = 15,
            [questKeys.exclusiveTo] = {95189},
        },
        [95212] = { -- Never Saddle on Quality
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [95213] = { -- Stolen Blasting Powder
            [questKeys.nextQuestInChain] = 95214,
        },
        [95214] = { -- Stolen Blasting Powder
            [questKeys.preQuestSingle] = {95213},
        },
        [95216] = { -- The New Plague
            [questKeys.requiredLevel] = 15,
            [questKeys.preQuestSingle] = {451},
        },
        [95217] = { -- The Quarry's Smith
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
        },
        [95218] = { -- More of the Same
            [questKeys.preQuestSingle] = {90750},
            [questKeys.nextQuestInChain] = 94832,
        },
        [95219] = { -- From Port to Port
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95248] = { -- To the Summit of Eternity
            [questKeys.preQuestGroup] = {92592,94782,95026},
            [questKeys.exclusiveTo] = {91688},
        },
        [95250] = { -- Abominable Creatures
            [questKeys.requiredLevel] = 15,
        },
        [95254] = { -- WANTED: Trapclaw
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95260] = { -- Terrors From the Deep
            [questKeys.requiredLevel] = 38,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 95261,
        },
        [95261] = { -- It Takes Guts
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95260},
            [questKeys.nextQuestInChain] = 95267,
        },
        [95262] = { -- The Secret Prison
            [questKeys.preQuestSingle] = {95198},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [95263] = { -- Somber News
            [questKeys.preQuestSingle] = {95262},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [95264] = { -- Shaw Needs To Know
            [questKeys.preQuestSingle] = {95263},
        },
        [95267] = { -- The Monster Surfaces
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95261},
            [questKeys.extraObjectives] = {{nil,Questie.ICON_TYPE_OBJECT,l10n("Use the Big Ball o' Bait"),0,{{"object",630533}}}},
        },
        [95273] = { -- Water of Hyjal
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95278] = { -- It Is Time, Brother...
            [questKeys.preQuestSingle] = {94768},
            [questKeys.nextQuestInChain] = 94968,
        },
        [95284] = { -- The Elite of the Elite
            [questKeys.nextQuestInChain] = 95285,
        },
        [95285] = { -- Right Place, Wrong Time
            [questKeys.preQuestSingle] = {95284},
            [questKeys.nextQuestInChain] = 95309,
        },
        [95288] = { -- Smuggler's Paradise
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.nextQuestInChain] = 95293,
            [questKeys.preQuestSingle] = {93976,94928},
        },
        [95293] = { -- Smuggler's Special
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95288},
            [questKeys.nextQuestInChain] = 95294,
        },
        [95294] = { -- Smuggler's Bargain
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95293},
            [questKeys.nextQuestInChain] = 95296,
        },
        [95295] = { -- I Know a Guy
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95294},
            [questKeys.nextQuestInChain] = 95322,
        },
        [95296] = { -- Shipping and Handling
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95294},
            [questKeys.nextQuestInChain] = 95383,
        },
        [95309] = { -- No Orc Left Behind
            [questKeys.preQuestSingle] = {95285},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [95312] = { -- Coming to Collect
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95383},
            [questKeys.nextQuestInChain] = 95321,
        },
        [95314] = { -- That Shadowvale Green Elixir
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [95316] = { -- The Experimental Method
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestGroup] = {95380,96262},
        },
        [95317] = { -- Notation, Notation, Notation
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95318] = { -- Taste of Ash
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95320},
            [questKeys.nextQuestInChain] = 95319,
        },
        [95319] = { -- Crystalline Collection
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {95318},
        },
        [95320] = { -- A Curious Question
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95321] = { -- Tazzik's Dues
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95312},
            [questKeys.nextQuestInChain] = 95472,
        },
        [95322] = { -- Get the Goods
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95295},
            [questKeys.nextQuestInChain] = 95325,
        },
        [95325] = { -- We've Been Robbed!
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95322},
            [questKeys.nextQuestInChain] = 95326,
        },
        [95326] = { -- The Big Payback
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {95325},
            [questKeys.nextQuestInChain] = 95327,
        },
        [95327] = { -- All's Well That Ends Well
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95326},
        },
        [95329] = { -- Out in the Field
            [questKeys.preQuestSingle] = {94877},
        },
        [95349] = { -- The Earthen Ring
            [questKeys.preQuestSingle] = {93090},
        },
        [95350] = { -- Welcome to Azeroth
            [questKeys.nextQuestInChain] = 93739,
        },
        [95378] = { -- The Hydra's Head
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95319},
        },
        [95379] = { -- A Revenge So Sweet
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {95319},
        },
        [95380] = { -- A Prolific Source
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {95317},
        },
        [95383] = { -- Shipping and Handling
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95296},
            [questKeys.nextQuestInChain] = 95312,
        },
        [95385] = { -- Torn Mystical Scroll
            [questKeys.requiredLevel] = 35,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95417] = { -- The Purple Ones
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94727},
            [questKeys.nextQuestInChain] = 95601,
        },
        [95418] = { -- Spread the Word
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95427},
            [questKeys.nextQuestInChain] = 95420,
        },
        [95420] = { -- Land of Giants
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95418},
        },
        [95424] = { -- Might Makes Right
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95420},
        },
        [95425] = { -- Unworthy Champion
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95420},
        },
        [95426] = { -- Rog'mar Supplies
            [questKeys.preQuestSingle] = {94924},
        },
        [95427] = { -- Twilight No More!
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestGroup] = {95601,95602},
            [questKeys.nextQuestInChain] = 95418,
        },
        [95428] = { -- Clugfist's Decree
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestGroup] = {95424,95425},
            [questKeys.nextQuestInChain] = 94744,
        },
        [95431] = { -- Rumblings of Discontent
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94744},
            [questKeys.nextQuestInChain] = 95432,
        },
        [95432] = { -- Rise Up!
            [questKeys.preQuestSingle] = {95431},
            [questKeys.nextQuestInChain] = 95433,
            [questKeys.objectives] = {{{260995,nil,Questie.ICON_TYPE_TALK}}},
        },
        [95433] = { -- Death to the Executioner
            [questKeys.preQuestSingle] = {95432},
        },
        [95454] = { -- The Honor of the Kor'kron
            [questKeys.preQuestSingle] = {95309},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [95472] = { -- Consolation Prize
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {95321},
        },
        [95483] = { -- Thrall Needs to Know
            [questKeys.preQuestSingle] = {96369},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [95494] = { -- Bruised Pride and Lion Hides
            [questKeys.nextQuestInChain] = 0,
        },
        [95495] = { -- The Hermit Tanner
            [questKeys.preQuestGroup] = {95494,95507},
            [questKeys.nextQuestInChain] = 95621,
        },
        [95507] = { -- Vrang's Game
            [questKeys.nextQuestInChain] = 0,
        },
        [95508] = { -- Unwelcome Guests
            [questKeys.preQuestSingle] = {95621},
            [questKeys.objectives] = {{{261367}}},
        },
        [95511] = { -- Your First Feline Friend
            [questKeys.preQuestSingle] = {97074},
            [questKeys.exclusiveTo] = {96982,96989,96994,96996,96997,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [95534] = { -- Strahnbrad Mystery
            [questKeys.objectives] = {{{217305}}},
            [questKeys.extraObjectives] = {{{[zoneIDs.ALTERAC_MOUNTAINS] = {{60.1,45.58}}}, Questie.ICON_TYPE_EVENT, l10n("Ignite the bellows using fire abilities")}},
        },
        [95561] = { -- Apple of My Eye
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94877},
            [questKeys.nextQuestInChain] = 95913,
        },
        [95562] = { -- Cut Off the Heads
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestGroup] = {95642,95643},
            [questKeys.nextQuestInChain] = 94884,
        },
        [95568] = { -- Seeds for a New Season
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95569] = { -- Hope for Hatchlings
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95599] = { -- The Old Key
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95601] = { -- The Purple Ones
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95417},
        },
        [95602] = { -- Sickening Lights
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {94727},
            [questKeys.objectives] = {{{262006,nil,Questie.ICON_TYPE_OBJECT}}},
        },
        [95603] = { -- Bats in the Belfry
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 95613,
        },
        [95611] = { -- Rites of Respect
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93759},
        },
        [95613] = { -- Keeping the Light On
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95603},
            [questKeys.nextQuestInChain] = 95615,
        },
        [95615] = { -- In Memoriam
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95613},
        },
        [95621] = { -- Trouble in the Valley
            [questKeys.preQuestSingle] = {95495},
            [questKeys.nextQuestInChain] = 95508,
        },
        [95642] = { -- Abominable Magics
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95643] = { -- Indiscriminate Purge
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95646] = { -- Horrors in the Highland
            [questKeys.preQuestSingle] = {275},
        },
        [95663] = { -- Dragonmaw Rumors
            [questKeys.nextQuestInChain] = 95682,
        },
        [95664] = { -- Elder Knowledge
            [questKeys.nextQuestInChain] = 98823,
        },
        [95682] = { -- Open the Maw
            [questKeys.objectives] = {{{275045},{275044}},nil,{{284844}}},
            [questKeys.preQuestSingle] = {95663},
        },
        [95748] = { -- The Gurubashi Legends of Old
            [questKeys.preQuestSingle] = {629},
        },
        [95753] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95766] = { -- Fine Feathered Friend
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {91770},
        },
        [95769] = { -- Threading a Solution
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95770] = { -- Locating the Lost City
            [questKeys.preQuestSingle] = {95748},
        },
        [95771] = { -- A Taste of Darkness
            [questKeys.startedBy_add] = {{205153}},
            [questKeys.finishedBy_add] = {{205153}},
            [questKeys.requiredLevel] = 6,
            [questKeys.questLevel] = 10,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.PALADIN,
            [questKeys.zoneOrSort] = zoneIDs.ELWYNN_FOREST,
        },
        [95773] = { -- Enemies in the Water
            [questKeys.preQuestSingle] = {95748},
        },
        [95774] = { -- Her Name Is Olgra
            [questKeys.preQuestSingle] = {4921},
        },
        [95775] = { -- The Drowned City
            [questKeys.preQuestSingle] = {95770},
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95776] = { -- The Only Good Brinescale...
            [questKeys.preQuestGroup] = {95770,95773},
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95786] = { -- An Acquaintance in Southshore
            [questKeys.preQuestSingle] = {205},
        },
        [95787] = { -- Take Two With Water
            [questKeys.preQuestSingle] = {95786},
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95788] = { -- Magics of the Drowned City
            [questKeys.preQuestSingle] = {95786},
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95789] = { -- Shady Saltseers
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95791] = { -- The Saltseer Captain
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [95792] = { -- Clear 'em Out
            [questKeys.requiredLevel] = 36,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95793] = { -- Stemming the Demon Tide
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [95795] = { -- Fallen in the Fen
            [questKeys.preQuestSingle] = {95772},
        },
        [95798] = { -- The Web of Magic
            [questKeys.preQuestSingle] = {95788},
        },
        [95799] = { -- Findings for the Explorer's League
            [questKeys.preQuestSingle] = {95787},
        },
        [95803] = { -- A Token of Good Faith
            [questKeys.preQuestSingle] = {91317}, -- 91316 is not needed
        },
        [95805] = { -- Grace of An'she and Mu'sha
            [questKeys.preQuestSingle] = {755},
        },
        [95810] = { -- Lost Relic Carry
            [questKeys.nextQuestInChain] = 98824,
        },
        [95816] = { -- Sign Me Up!
            [questKeys.name] = "Sign Me Up!",
            [questKeys.startedBy] = {nil,nil,{270888}},
            [questKeys.finishedBy] = {{256391}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.objectivesText] = {"Bring the completed form to Elaine Compton in Redridge Mountains."},
            [questKeys.objectives] = {nil,nil,{{270897}}},
            [questKeys.sourceItemId] = 270896,
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
            [questKeys.requiredMinRep] = {factionIDs.AZEROTH_COMMERCE_AUTHORITY, 9000},
        },
        [95819] = { -- Sign Me Up!
            [questKeys.name] = "Sign Me Up!",
            [questKeys.startedBy] = {nil,nil,{270887}},
            [questKeys.finishedBy] = {{256388}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.objectivesText] = {"Bring the completed form to Jornah in The Barrens."},
            [questKeys.objectives] = {nil,nil,{{270897}}},
            [questKeys.sourceItemId] = 270896,
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
            [questKeys.requiredMinRep] = {factionIDs.DUROTAR_SUPPLY_AND_LOGISTICS, 9000},
        },
        [95882] = { -- WANTED: Scoutmaster Vargas
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95883] = { -- The Tortured Soul
            [questKeys.preQuestSingle] = {95884},
            [questKeys.nextQuestInChain] = 95885,
        },
        [95884] = { -- The Offering Stone
            [questKeys.nextQuestInChain] = 95883,
        },
        [95885] = { -- The Offering of Blood
            [questKeys.preQuestSingle] = {95883},
            [questKeys.objectives] = {{{212753}},{{645153}}},
        },
        [95912] = { -- WANTED: Blademaster Kaijo
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95913] = { -- Fit for a Princess
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95561},
            [questKeys.nextQuestInChain] = 95961,
        },
        [95934] = { -- Proof of Profit
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95935] = { -- Hail the Dragonslayer
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95936] = { -- Hail the Dragonslayer
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95943] = { -- Foreman's Plight
            [questKeys.nextQuestInChain] = 96009,
        },
        [95951] = { -- Fetch 'n' Fletch
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.nextQuestInChain] = 95955,
            [questKeys.requiredSourceItems] = {271629},
        },
        [95955] = { -- Stick 'Em
            [questKeys.preQuestSingle] = {95951},
            [questKeys.objectives] = {{{259046,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [95957] = { -- Drink Up!
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95988},
            [questKeys.nextQuestInChain] = 95975,
        },
        [95961] = { -- Stepped Out
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95913},
        },
        [95975] = { -- Her World
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95957},
        },
        [95981] = { -- Watching the Roads
            [questKeys.preQuestSingle] = {482},
        },
        [95982] = { -- Not My Circus
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95983] = { -- A Feast for Buzzards
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.nextQuestInChain] = 95984,
        },
        [95984] = { -- Song of the Strider
            [questKeys.preQuestSingle] = {95983},
            [questKeys.nextQuestInChain] = 95986,
        },
        [95986] = { -- King of the Wild Plains
            [questKeys.preQuestSingle] = {95984},
        },
        [95988] = { -- Goes Down Smooth
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {95961},
            [questKeys.nextQuestInChain] = 95957,
        },
        [95991] = { -- WANTED: Ghostmaw
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95992] = { -- WANTED: Ghostmaw
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95998] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96627},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {96101,96604,96605,96606,96607,96608},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [95999] = { -- WANTED: Incinerator Gar'im
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [96003] = { -- Drawing Down the Malevolent
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92960},
            [questKeys.nextQuestInChain] = 96025,
        },
        [96009] = { -- High Stakes
            [questKeys.preQuestSingle] = {95943},
        },
        [96010] = { -- Fragments of the Pylons
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {92914},
            [questKeys.nextQuestInChain] = 96018,
        },
        [96015] = { -- A Miner Problem
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94886},
        },
        [96016] = { -- The Tempest's Weapons
            [questKeys.preQuestSingle] = {79366,96135},
            [questKeys.exclusiveTo] = {79442},
        },
        [96018] = { -- Powering the Pylons
            [questKeys.preQuestSingle] = {96010},
            [questKeys.nextQuestInChain] = 93016,
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [96025] = { -- As the Crow Flies
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96003},
        },
        [96026] = { -- Step Two: More Rock
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {95183},
        },
        [96031] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{1466,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97906,97922,97934,97946,97958,97969},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.NONE,
        },
        [96044] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{1241,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97900,97916,97928,97939,97952,97964},
        },
        [96045] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{1246,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97899,97915,97927,97938,97951,97963},
        },
        [96046] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{5392,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97907,97923,97935,97948,97959,97970},
        },
        [96047] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{2326,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97903,97919,97931,97942,97955,97965},
        },
        [96050] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{1700,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97904,97920,97932,97943,97956,97967},
        },
        [96055] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{5137,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97905,97921,97933,97944,97957,97968},
        },
        [96056] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{6291,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97908,97924,97936,97949,97960,97971},
        },
        [96057] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1263425, -- Faction Banner
            [questKeys.objectives] = {{{1703,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96102,97925,97937,97950,97961,97972,97973},
        },
        [96058] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{1702,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97902,97918,97930,97941,97954,98285,98287},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [96059] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{11065,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {97901,97917,97929,97940,97953,98284,98286},
        },
        [96060] = { -- Tempered Expectations
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93546},
        },
        [96063] = { -- Gaseous Gold
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.nextQuestInChain] = 96067,
        },
        [96067] = { -- Rock 'em and Sock 'em
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96063},
            [questKeys.objectives] = {{{263369}}},
        },
        [96075] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96076] = { -- In Demand - Ancient Elven Curiosities
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96077] = { -- Belle's Ring
            [questKeys.preQuestSingle] = {94832},
        },
        [96078] = { -- A Tale Spun Around the Fire
            [questKeys.preQuestSingle] = {95775},
        },
        [96081] = { -- Wound Dressings
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {94877},
            [questKeys.nextQuestInChain] = 96082,
        },
        [96082] = { -- Doctor's Orderly
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {96081},
            [questKeys.nextQuestInChain] = 96083,
        },
        [96083] = { -- Clerical Quarantine
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {96082},
            [questKeys.nextQuestInChain] = 96084,
        },
        [96084] = { -- Something's in the Water
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {96083},
            [questKeys.nextQuestInChain] = 96085,
        },
        [96085] = { -- Upstream Contamination
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {96084},
        },
        [96088] = { -- In Demand - Titan Relics
            [questKeys.name] = "In Demand - Titan Relics",
            [questKeys.requiredLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.STRANGLETHORN_VALE,
        },
        [96101] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96638},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96604,96605,96606,96607,96608},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [96102] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1229504, -- Faction Banner
            [questKeys.objectives] = {{{2855,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,97925,97937,97950,97961,97972,97973},
        },
        [96103] = { -- A Feast for Buzzards
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.nextQuestInChain] = 96104,
        },
        [96104] = { -- Song of the Strider
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96103},
            [questKeys.nextQuestInChain] = 96105,
        },
        [96105] = { -- King of the Wild Plains
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96104},
        },
        [96107] = { -- Feathers for Fletching
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.nextQuestInChain] = 96108,
        },
        [96108] = { -- Poison Tips
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96107},
            [questKeys.nextQuestInChain] = 96109,
        },
        [96109] = { -- A Hunter's Quiver
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
            [questKeys.preQuestSingle] = {96108},
        },
        [96125] = { -- In Need of Relief
            [questKeys.preQuestGroup] = {94924,94925},
            [questKeys.nextQuestInChain] = 96126,
        },
        [96126] = { -- An Ogre's Captive
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.preQuestSingle] = {96125},
            [questKeys.nextQuestInChain] = 94927,
        },
        [96130] = { -- Chakuyak
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {757},
        },
        [96131] = { -- An Oldstone But An Old Friend
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96321},
            [questKeys.nextQuestInChain] = 92612,
        },
        [96135] = { -- Heed My Call
            [questKeys.preQuestSingle] = {79358},
            [questKeys.exclusiveTo] = {79366},
            [questKeys.nextQuestInChain] = 96016,
        },
        [96136] = { -- Call of Air
            [questKeys.exclusiveTo] = {1531,1532},
            [questKeys.nextQuestInChain] = 79360,
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [96139] = { -- The Valor Family
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [96145] = { -- Past Wing and Claw
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [96204] = { -- The Windshaper's Wrath
            [questKeys.preQuestSingle] = {91862},
            [questKeys.nextQuestInChain] = 95034,
            [questKeys.objectives] = {{{248755,nil,Questie.ICON_TYPE_EVENT}}}, -- Escort Lumina out of Fenris Keep
            [questKeys.triggerEnd] = {"Escort Lumina Windsinger to safety", {[zoneIDs.SILVERPINE_FOREST] = {{65.7,29.7}}}},
        },
        [96209] = { -- The Ancient, Orokai
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92612},
            [questKeys.nextQuestInChain] = 95006,
        },
        [96243] = { -- Call of Earth
            [questKeys.requiredLevel] = 4,
            [questKeys.questLevel] = 4,
            [questKeys.availableUntilCompleted] = 94373,
        },
        [96246] = { -- Blackmaw Pouches
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {97327},
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [96252] = { -- Tarnished Treasures
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96255] = { -- Amalgamated Marrow
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96435},
            [questKeys.nextQuestInChain] = 96322,
        },
        [96259] = { -- Defending the Dead
            [questKeys.nextQuestInChain] = 96261,
        },
        [96261] = { -- The Broodmother
            [questKeys.preQuestSingle] = {96259},
        },
        [96262] = { -- Prickly Pinecones
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {95317},
        },
        [96264] = { -- Elemental Aid
            [questKeys.preQuestSingle] = {94789},
            [questKeys.nextQuestInChain] = 79358,
        },
        [96296] = { -- Fetid Corruption
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [96301] = { -- Power Wash
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [96302] = { -- Arch Absolution
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {92017},
        },
        [96303] = { -- Memory Mist
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {93584},
        },
        [96321] = { -- The Dying God
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 96131,
        },
        [96322] = { -- A Revenge Now Bitter
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96255},
        },
        [96332] = { -- A Little Payback
            [questKeys.preQuestSingle] = {95285},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96334] = { -- Blood Red Bandanas
            [questKeys.preQuestSingle] = {95285},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96335] = { -- The Man in the Iron Chains
            [questKeys.requiredLevel] = 48,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96337] = { -- More Valuable Than Gold
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96335},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96339] = { -- Legacy Reward: Replica Ironforge Air Rifle
            [questKeys.requiredLevel] = 1,
        },
        [96369] = { -- Bad News for Folkar
            [questKeys.preQuestSingle] = {95454},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96376] = { -- State Secrets
            [questKeys.exclusiveTo] = {96377,96379},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96377] = { -- State Secrets
            [questKeys.exclusiveTo] = {96376,96379},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96379] = { -- State Secrets
            [questKeys.requiredLevel] = 48,
            [questKeys.questLevel] = 53,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.exclusiveTo] = {96376,96377},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96381] = { -- A Bit of Wet Work
            [questKeys.preQuestSingle] = {95198},
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96383] = { -- Legacy Reward: Spectral Bear Cub
            [questKeys.requiredLevel] = 1,
        },
        [96390] = { -- Nip 'Em in the Bud
            [questKeys.preQuestSingle] = {96392},
        },
        [96391] = { -- Underground Map
            [questKeys.nextQuestInChain] = 96393,
        },
        [96392] = { -- Farsen's Watch
            [questKeys.breadcrumbs] = {96408},
            [questKeys.objectives] = {{{264936,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.nextQuestInChain] = 96390,
        },
        [96393] = { -- Old Ironforge Incursion
            [questKeys.preQuestSingle] = {96391}, -- check if it also needs 96390. check if 96391 drops without preq
        },
        [96395] = { -- An Ancient Grudge
            [questKeys.startedBy] = {{265002}},
            [questKeys.finishedBy] = {{265002}},
            [questKeys.requiredLevel] = 10,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectives] = {{{261306}}},
            [questKeys.zoneOrSort] = zoneIDs.THE_HALL_OF_THANES,
        },
        [96408] = { -- A Visitor to Dun Morogh
            [questKeys.breadcrumbForQuestId] = 96392,
            [questKeys.nextQuestInChain] = 96392,
        },
        [96435] = { -- A Fitting End
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {95378},
            [questKeys.nextQuestInChain] = 96255,
        },
        [96494] = { -- Gathering Storm
            [questKeys.preQuestSingle] = {92593},
        },
        [96529] = { -- A Shaw Deal
            [questKeys.preQuestSingle] = {96494},
        },
        [96550] = { -- Battle Recall
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92100},
        },
        [96558] = { -- Soldier's Solace
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93567},
        },
        [96559] = { -- Supply Drop
            [questKeys.preQuestSingle] = {92064},
            [questKeys.nextQuestInChain] = 93383,
        },
        [96561] = { -- Last Wishes
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [96602] = { -- More Unstable Magic
            [questKeys.preQuestSingle] = {96603},
        },
        [96604] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96652},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96101,96605,96606,96607,96608},
        },
        [96605] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96659},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96606,96607,96608},
        },
        [96606] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96630},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96607,96608},
        },
        [96607] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96656},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96606,96608},
        },
        [96608] = { -- The Great Outdoors
            [questKeys.startedBy] = {{265813}},
            [questKeys.breadcrumbs] = {96628},
            [questKeys.objectives] = {nil,{{460003},{460003}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96606,96607},
        },
        [96622] = { -- A Rest Without Pain
            [questKeys.preQuestSingle] = {96616},
        },
        [96626] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{1430,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96629,96634,96646,96655,96658,96661},
        },
        [96627] = { -- The Adventurer
            [questKeys.preQuestSingle] = {21},
            [questKeys.breadcrumbForQuestId] = 95998,
            [questKeys.nextQuestInChain] = 95998,
            [questKeys.exclusiveTo] = {96628,96630,96638,96652,96656,96659},
        },
        [96628] = { -- The Adventurer
            [questKeys.preQuestSingle] = {282},
            [questKeys.breadcrumbForQuestId] = 96608,
            [questKeys.nextQuestInChain] = 96608,
            [questKeys.exclusiveTo] = {96627,96630,96638,96652,96656,96659},
        },
        [96629] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{1699,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96634,96646,96655,96658,96661},
        },
        [96630] = { -- The Adventurer
            [questKeys.preQuestSingle] = {921},
            [questKeys.breadcrumbForQuestId] = 96606,
            [questKeys.nextQuestInChain] = 96606,
            [questKeys.exclusiveTo] = {96627,96628,96638,96652,96656,96659},
        },
        [96634] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{6286,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96629,96646,96655,96658,96661},
        },
        [96638] = { -- The Adventurer
            [questKeys.preQuestSingle] = {92470},
            [questKeys.breadcrumbForQuestId] = 96101,
            [questKeys.nextQuestInChain] = 96101,
            [questKeys.exclusiveTo] = {96627,96628,96630,96652,96656,96659},
        },
        [96646] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{251905,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96629,96634,96655,96658,96661},
        },
        [96652] = { -- The Adventurer
            [questKeys.preQuestSingle] = {794},
            [questKeys.breadcrumbForQuestId] = 96604,
            [questKeys.nextQuestInChain] = 96604,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96656,96659},
        },
        [96655] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{3191,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96629,96634,96646,96658,96661},
        },
        [96656] = { -- The Adventurer
            [questKeys.preQuestSingle] = {382},
            [questKeys.breadcrumbForQuestId] = 96607,
            [questKeys.nextQuestInChain] = 96607,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96652,96659},
        },
        [96658] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{265944,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96629,96634,96646,96655,96661},
        },
        [96659] = { -- The Adventurer
            [questKeys.preQuestSingle] = {757},
            [questKeys.breadcrumbForQuestId] = 96605,
            [questKeys.nextQuestInChain] = 96605,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96652,96656},
        },
        [96661] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.objectives] = {{{3067,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.exclusiveTo] = {96626,96629,96634,96646,96655,96658},
        },
        [96666] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96676] = { -- Unsealing Blackthorne Pact
            [questKeys.preQuestSingle] = {96529},
        },
        [96770] = { -- The Witch Doctor's Head
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96771] = { -- Vengeance of the Highborne
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.zoneOrSort] = zoneIDs.KROLDOK_STRONGHOLD,
        },
        [96772] = { -- The Dragon's Journal
            [questKeys.zoneOrSort] = zoneIDs.ALCAZ_PRISON,
        },
        [96773] = { -- The Coldbringer's Eye
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96774] = { -- Ancient Gurubashi Idol
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [96779] = { -- Syndicate Sabotage
            [questKeys.preQuestSingle] = {6681},
        },
        [96781] = { -- What's the Big Idea?
            [questKeys.preQuestSingle] = {6681},
            [questKeys.nextQuestInChain] = 96782,
        },
        [96782] = { -- Covert Extraction
            [questKeys.preQuestSingle] = {96781},
        },
        [96783] = { -- A Way In
            [questKeys.preQuestSingle] = {6681},
            [questKeys.nextQuestInChain] = 96784,
        },
        [96784] = { -- Master of Disguise
            [questKeys.preQuestSingle] = {96783},
            [questKeys.nextQuestInChain] = 96785,
        },
        [96785] = { -- Ain't No Telling
            [questKeys.preQuestSingle] = {96784},
            [questKeys.nextQuestInChain] = 96786,
        },
        [96786] = { -- The Syndicate Sting
            [questKeys.preQuestSingle] = {96785},
        },
        [96796] = { -- Woods Workshop
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {94479},
        },
        [96797] = { -- The Orphan
            [questKeys.nextQuestInChain] = 96798,
        },
        [96798] = { -- Into the Darkness
            [questKeys.preQuestSingle] = {96797},
            [questKeys.nextQuestInChain] = 96811,
        },
        [96799] = { -- A Heavy Responsibility
            [questKeys.preQuestSingle] = {96811},
            [questKeys.nextQuestInChain] = 96812,
        },
        [96811] = { -- Escaping the Shadows
            [questKeys.preQuestSingle] = {96798},
            [questKeys.nextQuestInChain] = 96799,
        },
        [96812] = { -- Thicker Than Water
            [questKeys.preQuestSingle] = {96799},
        },
        [96830] = { -- Farsight Guided
            [questKeys.requiredLevel] = 54,
            [questKeys.exclusiveTo] = {96833},
        },
        [96833] = { -- Venom Maws
            [questKeys.requiredLevel] = 54,
            [questKeys.exclusiveTo] = {96830},
        },
        [96873] = { -- A Pain in the Neck
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
        },
        [96874] = { -- This Is Spinal Axe
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
        },
        [96875] = { -- Beasts of Thunder Ridge
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.objectives] = {nil,nil,{{275720},{4231}}},
        },
        [96896] = { -- A Righteous Cause
            [questKeys.preQuestSingle] = {96899},
            [questKeys.nextQuestInChain] = 98545,
        },
        [96897] = { -- The Cult of the Damned
            [questKeys.preQuestSingle] = {96895},
        },
        [96898] = { -- Remnants of War
            [questKeys.preQuestSingle] = {96895},
        },
        [96899] = { -- Bandarion Keep
            [questKeys.preQuestGroup] = {96897,96898},
            [questKeys.nextQuestInChain] = 96896,
        },
        [96912] = { -- Field of Honor: Week 1
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.GADGETZAN,
        },
        [96913] = { -- Field of Honor: Week 2
            [questKeys.requiredLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = zoneIDs.WARSONG_GULCH,
        },
        [96914] = { -- Field of Honor: Week 3
            [questKeys.zoneOrSort] = zoneIDs.WARSONG_GULCH,
        },
        [96915] = { -- Field of Honor: Week 4
            [questKeys.name] = "Field of Honor: Week 4",
            [questKeys.requiredLevel] = 60,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.startedBy] = {{267525}},
            [questKeys.finishedBy] = {{267525}},
            [questKeys.objectivesText] = {"Complete 3 Arathi Basin battles."},
            [questKeys.zoneOrSort] = zoneIDs.ARATHI_BASIN,
        },
        [96930] = { -- The Capricious Corvid
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93773},
            [questKeys.nextQuestInChain] = 96931,
        },
        [96931] = { -- Heading Up the Mountain
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96930},
        },
        [96939] = { -- The Balance of Life and Death
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96931},
            [questKeys.nextQuestInChain] = 92317,
        },
        [96957] = { -- Bone Sweet Bone
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96939},
        },
        [96959] = { -- Blademaster's Bonfires
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 96983,
        },
        [96964] = { -- A Clever Creature
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96931},
            [questKeys.nextQuestInChain] = 92335,
        },
        [96971] = { -- To Outfox a Demon
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96964},
        },
        [96978] = { -- Violent Venison
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96931},
        },
        [96979] = { -- Sacred Refreshment
            [questKeys.requiredLevel] = 54,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 96991,
        },
        [96982] = { -- Your First Riding Kodo
            [questKeys.exclusiveTo] = {95511,96989,96994,96996,96997,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [96983] = { -- Yashiro's Windwalk
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {96959},
        },
        [96984] = { -- Heart of Disruption
            [questKeys.preQuestSingle] = {92434},
            [questKeys.exclusiveTo] = {92458},
            [questKeys.nextQuestInChain] = 97287,
        },
        [96987] = { -- Opportunistic Education
            [questKeys.startedBy] = {{268743}},
            [questKeys.finishedBy] = {{268743}},
        },
        [96989] = { -- Your First Riding Raptor
            [questKeys.exclusiveTo] = {95511,96982,96994,96996,96997,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [96991] = { -- Trail Assist
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {96979},
        },
        [96992] = { -- Resupply
            [questKeys.preQuestSingle] = {92014},
        },
        [96994] = { -- Your First Riding Wolf
            [questKeys.exclusiveTo] = {95511,96982,96989,96996,96997,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredRaces] = raceIDs.ORC,
            [questKeys.requiredSpell] = 33388,
        },
        [96996] = { -- Your First Riding Galestrider
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96997,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [96997] = { -- A Steed in Death as They Were in Life
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,97017,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [96998] = { -- Tribal Colors
            [questKeys.nextQuestInChain] = 96999,
        },
        [96999] = { -- Wrap Return
            [questKeys.preQuestSingle] = {96998},
        },
        [97009] = { -- Maerion's Misery
            [questKeys.requiredLevel] = 56,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 97010,
        },
        [97010] = { -- Blind Vengeance
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {97009},
        },
        [97017] = { -- Your First Riding Ram
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97045,97046,97171,97446,98166,99326},
            [questKeys.requiredRaces] = raceIDs.DWARF,
            [questKeys.requiredSpell] = 33388,
        },
        [97018] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97074,97170,97188,97194,97200,97203,97204,97205},
            [questKeys.objectives] = {{{4772,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97022] = { -- Report to Danitha
            [questKeys.nextQuestInChain] = 94971,
        },
        [97029] = { -- Eluvi'ana
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = -1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93161},
            [questKeys.zoneOrSort] = zoneIDs.ZEPHRAS_ISLE,
        },
        [97045] = { -- Your First Horse
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97046,97171,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [97046] = { -- Your First Mechanostrider
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97045,97171,97446,98166,99326},
            [questKeys.requiredRaces] = raceIDs.GNOME,
            [questKeys.requiredSpell] = 33388,
        },
        [97047] = { -- The Cook in the Cage
            [questKeys.nextQuestInChain] = 97048,
        },
        [97048] = { -- Returning to Port
            [questKeys.preQuestSingle] = {97047},
        },
        [97065] = { -- Tip the Scales - Keefer's Angelfish
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97066] = { -- Tip the Scales - Brownell's Blue Striped Racer
            [questKeys.name] = "Tip the Scales - Brownell's Blue Striped Racer",
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97067] = { -- Tip the Scales - Dezian Queenfish
            [questKeys.name] = "Tip the Scales - Dezian Queenfish",
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredLevel] = 1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97074] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97170,97188,97194,97200,97203,97204,97205},
            [questKeys.objectives] = {{{4753,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97130] = { -- Ancient Gurubashi Secrets
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.zoneOrSort] = zoneIDs.THE_DROWNED_CITY,
        },
        [97169] = { -- The Darkreaver Menace
            [questKeys.requiredLevel] = 58,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [97170] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97188,97194,97200,97203,97204,97205},
            [questKeys.objectives] = {{{4732,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97171] = { -- Your First Horse
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97045,97046,97446,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [97173] = { -- Blackmaw Magic
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [97176] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97178] = { -- Ott of Tarren Mill
            [questKeys.requiredLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.requiredClasses] = classIDs.PALADIN,
        },
        [97180] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97182] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97183] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97184] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97185] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97186] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97188] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97170,97194,97200,97203,97204,97205},
            [questKeys.objectives] = {{{7954,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97198] = { -- Blackmaw Magic
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [97194] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97170,97188,97200,97203,97204,97205},
            [questKeys.objectives] = {{{4752,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97200] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97170,97188,97194,97203,97204,97205},
            [questKeys.objectives] = {{{7953,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97203] = { -- Learning to Ride
            [questKeys.requiredRaces] = raceIDs.UNDEAD,
            [questKeys.exclusiveTo] = {97018,97074,97170,97188,97194,97200,97204,97205},
            [questKeys.objectives] = {{{4773,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97204] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97170,97188,97194,97200,97203,97205},
            [questKeys.objectives] = {{{3690,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97205] = { -- Learning to Ride
            [questKeys.exclusiveTo] = {97018,97074,97170,97188,97194,97200,97203,97204},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.objectives] = {{{265756,nil,Questie.ICON_TYPE_TALK}}},
        },
        [97220] = { -- Philmor's Favor
            [questKeys.nextQuestInChain] = 97222,
        },
        [97222] = { -- Gatehouse Goods
            [questKeys.preQuestSingle] = {97220},
            [questKeys.objectives] = {nil,{{460004}}},
        },
        [97225] = { -- Forgotten Loa Idols
            [questKeys.startedBy] = {{3304}},
            [questKeys.disabledByQuest] = 805,
        },
        [97234] = { -- Reading Room
            [questKeys.nextQuestInChain] = 97237,
        },
        [97237] = { -- Shelf Picked
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {97234},
        },
        [97242] = { -- Yelmak's Medley
            [questKeys.nextQuestInChain] = 97275,
        },
        [97243] = { -- Call of Fire
            [questKeys.startedBy_add] = {{254082}},
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.nextQuestInChain] = 97244,
            [questKeys.breadcrumbs] = {98517}, -- to be tested
            [questKeys.exclusiveTo] = {1524},
        },
        [97244] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {97243},
            [questKeys.nextQuestInChain] = 97245,
        },
        [97245] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {97244},
            [questKeys.nextQuestInChain] = 97257,
            [questKeys.extraObjectives] = {{nil,Questie.ICON_TYPE_OBJECT,l10n("Knock on Kuramaa's Stump"),0,{{"object",660848}}}},
        },
        [97246] = { -- Meal Appeal
            [questKeys.finishedBy] = {{3368}},
            [questKeys.nextQuestInChain] = 97249,
        },
        [97249] = { -- Favorite Food
            [questKeys.preQuestSingle] = {97246},
            [questKeys.nextQuestInChain] = 97326,
        },
        [97257] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {97245},
            [questKeys.objectives] = {{{268762,nil,Questie.ICON_TYPE_EVENT},{268679,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97263] = { -- Your Package Has Arrived
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [97270] = { -- Brawl at the Maul
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [97271] = { -- Maul or Nothing!
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [97275] = { -- Whuut's the Rush
            [questKeys.preQuestSingle] = {97242},
        },
        [97277] = { -- Grund and Gozwin
            [questKeys.objectives] = {{{269075}},nil,{{277976}}},
            [questKeys.zoneOrSort] = 77,
        },
        [97281] = { -- A Simmering Storm
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.nextQuestInChain] = 97282,
        },
        [97282] = { -- Stormy Potential
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {97281},
        },
        [97284] = { -- Vahlarriel's Vengeance
            [questKeys.preQuestSingle] = {1465},
        },
        [97286] = { -- Research Access
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.preQuestSingle] = {78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,84395,84396,84397,84398,84399,84400,84401,84402},
        },
        [97287] = { -- Shrewd Negotiations
            [questKeys.preQuestSingle] = {92458,96984},
        },
        [97288] = { -- Unending Torment
            [questKeys.requiredLevel] = 15,
            [questKeys.nextQuestInChain] = 97289,
        },
        [97289] = { -- Unending Torment
            [questKeys.requiredLevel] = 15,
            [questKeys.preQuestSingle] = {97288},
            [questKeys.nextQuestInChain] = 97290,
        },
        [97290] = { -- Unending Torment
            [questKeys.requiredLevel] = 15,
            [questKeys.preQuestSingle] = {97289},
            [questKeys.nextQuestInChain] = 97291,
        },
        [97291] = { -- Unending Torment
            [questKeys.requiredLevel] = 15,
            [questKeys.preQuestSingle] = {97290},
            [questKeys.nextQuestInChain] = 97292,
        },
        [97292] = { -- Unending Torment
            [questKeys.requiredLevel] = 15,
            [questKeys.preQuestSingle] = {97291},
            [questKeys.objectives] = {nil,{{460007,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97326] = { -- Rocks to Rests
            [questKeys.preQuestSingle] = {97249},
        },
        [97327] = { -- Blackmaw Pouches
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.zoneOrSort] = zoneIDs.BLACKMAW_HOLD,
        },
        [97329] = { -- Where's the Key?
            [questKeys.nextQuestInChain] = 97331,
        },
        [97331] = { -- Zimmix's Great Escape
            [questKeys.triggerEnd] = {"Escort Zimmix Sputterspark to safety", {[zoneIDs.STRANGLETHORN_VALE] = {{26.85,11.42}}}},
            [questKeys.preQuestSingle] = {97329},
        },
        [97332] = { -- Twice Misplaced Trust
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestGroup] = {97328,97331},
        },
        [97378] = { -- Mirrorscale
            [questKeys.requiredLevel] = 45,
            [questKeys.preQuestSingle] = {1205},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [97386] = { -- The Offense of Grom'gol
            [questKeys.preQuestSingle] = {569},
        },
        [97404] = { -- Too Bad to Bear
            [questKeys.preQuestSingle] = {97264},
        },
        [97412] = { -- Just Compensation
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [97413] = { -- Anthion's Parting Words
            [questKeys.requiredLevel] = 58,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [97446] = { -- Your First Riding Kodo
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97045,97046,97171,98166,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [97453] = { -- Weed Whacked
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [97485] = { -- Traditions of the Bluff
            [questKeys.objectives] = {nil,{{665373}},{{278078}}},
            [questKeys.requiredSourceItems] = {278079,278080,278081,278083},
        },
        [97490] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97530] = { -- Dunemaul Dues
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [97534] = { -- Gritty Business
            [questKeys.exclusiveTo] = {97536},
        },
        [97536] = { -- Gnomish Garbage
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
            [questKeys.exclusiveTo] = {97534},
        },
        [97539] = { -- Silky Sutures
            [questKeys.nextQuestInChain] = 92519, -- TODO probably also needs First Aid
        },
        [97540] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97583] = { -- WRIGGLE.
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97617] = { -- Safety Checks
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [97663] = { -- Supplies and Studies
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [97821] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97883] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97894] = { -- Business in Auberdine
            [questKeys.breadcrumbForQuestId] = 982,
            [questKeys.nextQuestInChain] = 982,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [97899] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{11046,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97915,97927,97938,97951,97963},
        },
        [97900] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{3174,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97916,97928,97939,97952,97964},
        },
        [97901] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{11066,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97917,97929,97940,97953,98284,98286},
        },
        [97902] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{11025,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97918,97930,97941,97954,98285,98287},
        },
        [97903] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{5943,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97919,97931,97942,97955,97965},
        },
        [97904] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{5941,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97920,97932,97943,97956,97967},
        },
        [97905] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{3404,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97921,97933,97944,97957,97968},
        },
        [97906] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{3365,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97922,97934,97946,97958,97969},
        },
        [97907] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{3175,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97923,97935,97948,97959,97970},
        },
        [97908] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{7088,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97924,97936,97949,97960,97971},
        },
        [97914] = { -- Expanding Horizons
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 97926,
        },
        [97915] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{1215,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97899,97927,97938,97951,97963},
        },
        [97916] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{514,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97900,97928,97939,97952,97964},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.requiredClasses] = classIDs.NONE,
        },
        [97917] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{11068,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97929,97940,97953,98284,98286},
        },
        [97918] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{11026,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97930,97941,97954,98285,98287},
        },
        [97919] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{2329,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97903,97931,97942,97955,97965},
        },
        [97920] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{1651,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97904,97932,97943,97956,97967},
        },
        [97921] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{1218,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97905,97933,97944,97957,97968},
        },
        [97922] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{1632,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97906,97934,97946,97958,97969},
        },
        [97923] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{5513,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97907,97935,97948,97959,97970},
        },
        [97924] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{6306,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97908,97936,97949,97960,97971},
        },
        [97925] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1263425, -- Faction Banner
            [questKeys.objectives] = {{{1103,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97937,97950,97961,97972,97973},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [97926] = { -- Making Do
            [questKeys.preQuestSingle] = {97914},
        },
        [97927] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{11047,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97899,97915,97938,97951,97963},
        },
        [97928] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{10278,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97900,97916,97939,97952,97964},
        },
        [97929] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{11071,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97917,97940,97953,98284,98286},
        },
        [97930] = { -- Camping 101: Engineering
            [questKeys.startedBy] = {{265810}},
            [questKeys.finishedBy] = {{10993}},
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{10993,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97918,97941,97954,98285,98287},
        },
        [97931] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{5939,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97903,97919,97942,97955,97965},
        },
        [97932] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{5938,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97904,97920,97943,97956,97967},
        },
        [97933] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{3013,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97905,97921,97944,97957,97968},
        },
        [97934] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{3069,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97906,97922,97946,97958,97969},
        },
        [97935] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{3001,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97907,97923,97948,97959,97970},
        },
        [97936] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{6290,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97908,97924,97949,97960,97971},
        },
        [97937] = { -- Camping 101: Tailoring
            [questKeys.finishedBy] = {{11051}},
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1229504, -- Faction Banner
            [questKeys.objectives] = {{{11051,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97925,97950,97961,97972,97973},
        },
        [97938] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{3603,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97899,97915,97927,97951,97963},
        },
        [97939] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{6300,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97900,97916,97928,97952,97964},
        },
        [97940] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{3606,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97917,97929,97953,98284,98286},
        },
        [97941] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{11037,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97918,97930,97954,98285,98287},
        },
        [97942] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{6094,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97903,97919,97931,97955,97965},
        },
        [97943] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{4156,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97904,97920,97932,97956,97967},
        },
        [97944] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{3604,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97905,97921,97933,97957,97968},
        },
        [97946] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{3605,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97906,97922,97934,97958,97969},
        },
        [97948] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{6297,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97907,97923,97935,97959,97970},
        },
        [97949] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{6287,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97908,97924,97936,97960,97971},
        },
        [97950] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1263425, -- Faction Banner
            [questKeys.objectives] = {{{11050,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97925,97937,97961,97972,97973},
        },
        [97951] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{2132,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97899,97915,97927,97938,97963},
        },
        [97952] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{4605,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97900,97916,97928,97939,97964},
        },
        [97953] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{5695,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97917,97929,97940,98284,98286},
        },
        [97954] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{4586,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97918,97930,97941,98285,98287},
        },
        [97955] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{5759,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97903,97919,97931,97942,97965},
        },
        [97956] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{5690,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97904,97920,97932,97943,97967},
        },
        [97957] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{2114,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97905,97921,97933,97944,97968},
        },
        [97958] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{3549,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97906,97922,97934,97946,97969},
        },
        [97959] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{4598,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97907,97923,97935,97948,97970},
        },
        [97960] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{6289,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97908,97924,97936,97949,97971},
        },
        [97961] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1229504, -- Faction Banner
            [questKeys.objectives] = {{{3523,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97925,97937,97950,97972,97973},
        },
        [97963] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{257019,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96045,97899,97915,97927,97938,97951},
        },
        [97964] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{251913,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96044,97900,97916,97928,97939,97952},
        },
        [97965] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{257018,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96047,97903,97919,97931,97942,97955},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [97967] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{251992,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96050,97904,97920,97932,97943,97956},
        },
        [97968] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{254345,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96055,97905,97921,97933,97944,97957},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.finishedBy] = {{257021}},
        },
        [97969] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{251993,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96031,97906,97922,97934,97946,97958},
        },
        [97970] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{257022,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96046,97907,97923,97935,97948,97959},
        },
        [97971] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{257024,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96056,97908,97924,97936,97949,97960},
        },
        [97972] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1229504, -- Faction Banner
            [questKeys.objectives] = {{{251991,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97925,97937,97950,97961,97973},
        },
        [97973] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1263425, -- Faction Banner
            [questKeys.objectives] = {{{251991,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96057,96102,97925,97937,97950,97961,97972},
        },
        [97977] = { -- Nature's Call
            [questKeys.preQuestSingle] = {458},
        },
        [97979] = { -- The Goddess Provides
            [questKeys.preQuestSingle] = {456},
            [questKeys.objectives] = {nil,nil,nil,nil,nil,{{1259799},{20580}}},
        },
        [97986] = { -- Argent Arbiter
            [questKeys.requiredLevel] = 53,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {8152},
        },
        [97987] = { -- Stormwind's High Order
            [questKeys.preQuestSingle] = {98109},
        },
        [97988] = { -- Orgrimmar's Windshapers
            [questKeys.preQuestSingle] = {98109},
        },
        [98013] = { -- Swelling Forces
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {950},
        },
        [98021] = { -- Journey to Sentinel Hill
            [questKeys.preQuestSingle] = {94947},
        },
        [98024] = { -- Journey to the Crossroads
            [questKeys.preQuestSingle] = {95350},
        },
        [98025] = { -- WANTED: Jai'vhanel
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98042] = { -- It's All Fun and Games Until...
            [questKeys.preQuestSingle] = {949},
        },
        [98046] = { -- Crown of the Earth
            [questKeys.preQuestSingle] = {935},
            [questKeys.nextQuestInChain] = 98065,
        },
        [98065] = { -- Crown of the Earth
            [questKeys.preQuestSingle] = {98046},
        },
        [98067] = { -- Eyes of the Sentinels
            [questKeys.objectives] = {{{270418,nil,Questie.ICON_TYPE_EVENT},{270419,nil,Questie.ICON_TYPE_EVENT},{270420,nil,Questie.ICON_TYPE_EVENT},{270421,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98072] = { -- Crocs of the Sky
            [questKeys.preQuestSingle] = {471},
            [questKeys.nextQuestInChain] = 98240,
            [questKeys.requiredLevel] = 19,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98094] = { -- Scout Support
            [questKeys.preQuestSingle] = {528},
            [questKeys.nextQuestInChain] = 98095,
        },
        [98095] = { -- Valuable Vantages
            [questKeys.objectives] = {{{270573,nil,Questie.ICON_TYPE_EVENT},{270574,nil,Questie.ICON_TYPE_EVENT},{270575,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.preQuestSingle] = {98094},
        },
        [98096] = { -- Sisters In Duty
            [questKeys.preQuestSingle] = {98067},
        },
        [98109] = { -- Bleeding Edge
            [questKeys.requiredLevel] = 53,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {97986},
        },
        [98155] = { -- Pristine Pesterhide Pelts
            [questKeys.nextQuestInChain] = 98156,
        },
        [98156] = { -- Packaged Pristine Pelts
            [questKeys.preQuestSingle] = {98155},
        },
        [98166] = { -- Your First Horse
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97045,97046,97171,97446,99326},
            [questKeys.requiredSpell] = 33388,
        },
        [98189] = { -- Return the Statuette
            [questKeys.preQuestSingle] = {286}, -- unverified, see 286
            [questKeys.nextQuestInChain] = 98190,
        },
        [98190] = { -- A Friend of the Family
            [questKeys.preQuestSingle] = {98189},
            [questKeys.nextQuestInChain] = 98191,
        },
        [98191] = { -- A Friend of the Family
            [questKeys.preQuestSingle] = {98190},
        },
        [98197] = { -- Spoils of War
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98205] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98208] = { -- Bloom of the Heavens
            [questKeys.requiredLevel] = 22,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 98209,
        },
        [98209] = { -- Bloom of the Heavens
            [questKeys.preQuestSingle] = {98208},
        },
        [98215] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98216] = { -- Understanding Our Present
            [questKeys.preQuestSingle] = {299},
            [questKeys.nextQuestInChain] = 98310,
        },
        [98219] = { -- The Shamed Lieutenant
            [questKeys.preQuestSingle] = {98191},
            [questKeys.breadcrumbForQuestId] = 536,
            [questKeys.nextQuestInChain] = 536,
        },
        [98230] = { -- This Land Was Their Land
            [questKeys.preQuestGroup] = {474,98223},
        },
        [98231] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98233] = { -- Sword in the Slime
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [98240] = { -- Crimson Crate Delivery
            [questKeys.preQuestSingle] = {98072},
            [questKeys.nextQuestInChain] = 98245,
        },
        [98247] = { -- Shipping Label
            [questKeys.exclusiveTo] = {98248},
        },
        [98248] = { -- Shipping Label
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
            [questKeys.exclusiveTo] = {98247},
        },
        [98251] = { -- Never Coming Back
            [questKeys.nextQuestInChain] = 98252,
        },
        [98252] = { -- A Void Path
            [questKeys.triggerEnd] = {"Eye of Kilrogg guided to the road", {[zoneIDs.ASHENVALE] = {{44.37,56.48}}}},
            [questKeys.preQuestSingle] = {98251},
        },
        [98282] = { -- Alchemical Hazards
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98283] = { -- Carnage
            [questKeys.preQuestSingle] = {275},
        },
        [98284] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{257020,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97917,97929,97940,97953,98286},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [98285] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{251684,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97918,97930,97941,97954,98287},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [98286] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{257020,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96059,97901,97917,97929,97940,97953,98284},
        },
        [98287] = { -- Camping 101: Engineering -- ??
            [questKeys.preQuestSingle] = {95998,96101,96604,96605,96606,96607,96608},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{11026,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.exclusiveTo] = {96058,97902,97918,97930,97941,97954,98285},
        },
        [98291] = { -- Death to the Dragonmaw
            [questKeys.preQuestGroup] = {98245,98246},
            [questKeys.nextQuestInChain] = 98297,
        },
        [98297] = { -- Stopping the Cycle
            [questKeys.preQuestSingle] = {98291},
            [questKeys.nextQuestInChain] = 98300,
        },
        [98298] = { -- Arugal's Folly
            [questKeys.preQuestSingle] = {99},
        },
        [98299] = { -- Stop the Spread
            [questKeys.preQuestSingle] = {99},
        },
        [98300] = { -- Word to Ironforge
            [questKeys.preQuestSingle] = {98297},
        },
        [98310] = { -- Gleaning Our Future
            [questKeys.preQuestSingle] = {98216},
            [questKeys.nextQuestInChain] = 98313,
        },
        [98313] = { -- For Further Study
            [questKeys.preQuestSingle] = {98310},
        },
        [98319] = { -- Secure the Mountain
            [questKeys.preQuestSingle] = {98322},
            [questKeys.nextQuestInChain] = 98323,
            [questKeys.objectives] = {{{278166,nil,Questie.ICON_TYPE_EVENT}}},
            [questKeys.triggerEnd] = {},
        },
        [98322] = { -- Secure the Mountain
            [questKeys.nextQuestInChain] = 98319,
        },
        [98323] = { -- Secure the Mountain
            [questKeys.preQuestSingle] = {98319},
        },
        [98338] = { -- REUSE ME
            [questKeys.preQuestSingle] = {79360},
            [questKeys.exclusiveTo] = {79364},
        },
        [98340] = { -- The Great Cat Spirit
            [questKeys.exclusiveTo] = {98393},
            [questKeys.nextQuestInChain] = 98341,
        },
        [98341] = { -- The Great Windborne Cat Spirit
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.preQuestSingle] = {98340,98393},
            [questKeys.exclusiveTo] = {98394,98405},
            [questKeys.nextQuestInChain] = 98404,
        },
        [98342] = { -- The Great Cat Spirit
            [questKeys.preQuestSingle] = {98405},
            [questKeys.exclusiveTo] = {98396,98404},
            [questKeys.nextQuestInChain] = 98739,
        },
        [98362] = { -- To Thunder Bluff
            [questKeys.preQuestSingle] = {98731,98738,98739},
            [questKeys.exclusiveTo] = {98397},
        },
        [98372] = { -- An Unfortunate End
            [questKeys.startedBy_add] = {{271866}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE, -- confirmed both alliance and horde get this one
            [questKeys.zoneOrSort] = zoneIDs.DUSKWOOD,
        },
        [98386] = { -- Alther's Mill
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {89},
            [questKeys.objectives] = {nil,{{673101}},nil,nil,{{{505,271898,271988},505}}},
        },
        [98387] = { -- Blackrock Blockade
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98389] = { -- A Light in the Darkness
            [questKeys.preQuestSingle] = {376},
            [questKeys.objectives] = {nil,nil,nil,nil,{{{271961,271968},271968,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [98391] = { -- The Sisterhood of Elune
            [questKeys.breadcrumbForQuestId] = 2519,
            [questKeys.nextQuestInChain] = 2519,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.exclusiveTo] = {2518},
        },
        [98392] = { -- Darkness in the Glade
            [questKeys.preQuestSingle] = {937},
            [questKeys.nextQuestInChain] = 98398,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98393] = { -- The Great Cat Spirit
            [questKeys.exclusiveTo] = {98340},
            [questKeys.nextQuestInChain] = 98394,
        },
        [98394] = { -- The Great Cat Spirit
            [questKeys.preQuestSingle] = {98340,98393},
            [questKeys.exclusiveTo] = {98341,98405},
            [questKeys.nextQuestInChain] = 98396,
        },
        [98396] = { -- The Great Cat Spirit
            [questKeys.preQuestSingle] = {98394},
            [questKeys.exclusiveTo] = {98342,98404},
            [questKeys.nextQuestInChain] = 98731,
        },
        [98397] = { -- To Darnassus
            [questKeys.preQuestSingle] = {98731,98738,98739},
            [questKeys.exclusiveTo] = {98362},
        },
        [98398] = { -- The Oracle Tree
            [questKeys.preQuestSingle] = {98392},
            [questKeys.nextQuestInChain] = 940,
        },
        [98403] = { -- Twisted Hatred
            [questKeys.preQuestSingle] = {932},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98404] = { -- The Great Windborne Cat Spirit
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.preQuestSingle] = {98341},
            [questKeys.exclusiveTo] = {98342,98396},
            [questKeys.nextQuestInChain] = 98738,
        },
        [98405] = { -- The Great Cat Spirit
            [questKeys.preQuestSingle] = {98340,98393},
            [questKeys.exclusiveTo] = {98341,98394},
            [questKeys.nextQuestInChain] = 98342,
        },
        [98407] = { -- Show of Force
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {244},
        },
        [98417] = { -- Vengeful Trail
            [questKeys.nextQuestInChain] = 98418,
        },
        [98418] = { -- Shared Fury
            [questKeys.preQuestSingle] = {98417},
        },
        [98424] = { -- Fizsprocket's Notes
            [questKeys.nextQuestInChain] = 98427,
            [questKeys.sourceItemId] = 281031,
        },
        [98427] = { -- Ceasing Operations
            [questKeys.preQuestSingle] = {98424},
        },
        [98430] = { -- The Longwalkers
            [questKeys.triggerEnd] = {"Escort Perith Stormhoof out of Palemane Rock", {[zoneIDs.MULGORE] = {{37.19,64.62}}}},
        },
        [98435] = { -- Thunderhorn's Report
            [questKeys.preQuestSingle] = {760},
        },
        [98461] = { -- Unrequited Love
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 305,
            [questKeys.breadcrumbForQuestId] = 305,
        },
        [98462] = { -- Shroud of the Winter Wilds
            [questKeys.name] = "Shroud of the Winter Wilds",
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
            [questKeys.preQuestSingle] = {92859},
        },
        [98476] = { -- More Unstable Magic
            [questKeys.preQuestSingle] = {98477},
        },
        [98517] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.breadcrumbForQuestId] = 97243, -- to be tested
            [questKeys.nextQuestInChain] = 97243,
        },
        [98529] = { -- Junkboxes Needed
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [98545] = { -- Leonid's Letter
            [questKeys.preQuestSingle] = {96896},
        },
        [98574] = { -- Hallowed Memorandum
            [questKeys.preQuestSingle] = {179},
        },
        [98575] = { -- Tainted Tablet
            [questKeys.preQuestSingle] = {788},
        },
        [98576] = { -- Glyphic Parchment
            [questKeys.preQuestSingle] = {788},
        },
        [98581] = { -- Archaic Rune
            [questKeys.preQuestSingle] = {179},
        },
        [98601] = { -- A Difficult Path
            [questKeys.preQuestSingle] = {364},
        },
        [98731] = { -- Blessings of the Great Cat Spirit
            [questKeys.preQuestSingle] = {98396},
            [questKeys.exclusiveTo] = {98738,98739},
            [questKeys.nextQuestInChain] = 98397,
        },
        [98738] = { -- Blessings of the Great Windborne Cat Spirit
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.preQuestSingle] = {98404},
            [questKeys.exclusiveTo] = {98731,98739},
        },
        [98739] = { -- Blessings of the Great Cat Spirit
            [questKeys.preQuestSingle] = {98342},
            [questKeys.exclusiveTo] = {98731,98738},
            [questKeys.nextQuestInChain] = 98362,
        },
        [98815] = { -- Highland Hides
            [questKeys.preQuestSingle] = {484},
        },
        [98823] = { -- Earthen Echo
            [questKeys.preQuestSingle] = {95664},
        },
        [98824] = { -- Prehistoric Prism
            [questKeys.preQuestSingle] = {95810},
        },
        [98887] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to a Horde Warbringer outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 150}},
            [questKeys.exclusiveTo] = {98889,98891,98893},
            [questKeys.requiredMaxLevel] = 39,
        },
        [98888] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 100}},
            [questKeys.preQuestSingle] = {98887,98889,98891,98893},
            [questKeys.requiredMaxLevel] = 39,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98889] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to a Horde Warbringer outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 150}},
            [questKeys.exclusiveTo] = {98887,98891,98893},
            [questKeys.requiredMaxLevel] = 49,
        },
        [98890] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 100}},
            [questKeys.preQuestSingle] = {98887,98889,98891,98893},
            [questKeys.requiredMaxLevel] = 49,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98891] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 59,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to a Horde Warbringer outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 150}},
            [questKeys.exclusiveTo] = {98887,98889,98893},
            [questKeys.requiredMaxLevel] = 59,
        },
        [98892] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 59,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 100}},
            [questKeys.preQuestSingle] = {98887,98889,98891,98893},
            [questKeys.requiredMaxLevel] = 59,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98893] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 60,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to a Horde Warbringer outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 150}},
            [questKeys.exclusiveTo] = {98887,98889,98891},
        },
        [98894] = { -- Conflict at Darkspear Islands
            [questKeys.name] = "Conflict at Darkspear Islands",
            [questKeys.startedBy] = {{15350}},
            [questKeys.finishedBy] = {{15350}},
            [questKeys.requiredLevel] = 60,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 100}},
            [questKeys.preQuestSingle] = {98887,98889,98891,98893},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98895] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to an Alliance Brigadier General outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 150}},
            [questKeys.exclusiveTo] = {98897,98899,98901},
            [questKeys.requiredMaxLevel] = 39,
        },
        [98896] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 100}},
            [questKeys.preQuestSingle] = {98895,98897,98899,98901},
            [questKeys.requiredMaxLevel] = 39,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98897] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to an Alliance Brigadier General outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 150}},
            [questKeys.exclusiveTo] = {98895,98899,98901},
            [questKeys.requiredMaxLevel] = 49,
        },
        [98898] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 100}},
            [questKeys.preQuestSingle] = {98895,98897,98899,98901},
            [questKeys.requiredMaxLevel] = 49,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98899] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 59,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to an Alliance Brigadier General outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 150}},
            [questKeys.exclusiveTo] = {98895,98897,98901},
            [questKeys.requiredMaxLevel] = 59,
        },
        [98900] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 59,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 100}},
            [questKeys.preQuestSingle] = {98895,98897,98899,98901},
            [questKeys.requiredMaxLevel] = 59,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98901] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 60,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Bring 3 Darkspear Islands Marks of Honor to an Alliance Brigadier General outside the battlegrounds."},
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 150}},
            [questKeys.exclusiveTo] = {98895,98897,98899},
        },
        [98902] = { -- Darkspear Islands Clash
            [questKeys.name] = "Darkspear Islands Clash",
            [questKeys.startedBy] = {{15351}},
            [questKeys.finishedBy] = {{15351}},
            [questKeys.requiredLevel] = 60,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil, nil, {{274895}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 100}},
            [questKeys.preQuestSingle] = {98895,98897,98899,98901},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [98903] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275273}},
            [questKeys.finishedBy] = {{275273}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Brelinda McFarry at Northwatch Hold."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 200}},
            [questKeys.exclusiveTo] = {98904,98905},
            [questKeys.requiredMaxLevel] = 39,
        },
        [98904] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275273}},
            [questKeys.finishedBy] = {{275273}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Brelinda McFarry at Northwatch Hold."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 200}},
            [questKeys.exclusiveTo] = {98903,98905},
            [questKeys.requiredMaxLevel] = 49,
        },
        [98905] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275273}},
            [questKeys.finishedBy] = {{275273}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Brelinda McFarry at Northwatch Hold."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 200}},
            [questKeys.exclusiveTo] = {98903,98904},
        },
        [98906] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275276}},
            [questKeys.finishedBy] = {{275276}},
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Nizook Boof at The Merchant Coast."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 200}},
            [questKeys.exclusiveTo] = {98907,98908},
            [questKeys.requiredMaxLevel] = 39,
        },
        [98907] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275276}},
            [questKeys.finishedBy] = {{275276}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Nizook Boof at The Merchant Coast."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 200}},
            [questKeys.exclusiveTo] = {98906,98908},
            [questKeys.requiredMaxLevel] = 49,
        },
        [98908] = { -- The Battle for Darkspear Islands!
            [questKeys.name] = "The Battle for Darkspear Islands!",
            [questKeys.startedBy] = {{275276}},
            [questKeys.finishedBy] = {{275276}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectivesText] = {"Win a Darkspear Islands battleground and return back to Nizook Boof at The Merchant Coast."},
            [questKeys.objectives] = {{{275188}}},
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.DARKSPEAR_RAIDERS, 200}},
            [questKeys.exclusiveTo] = {98906,98907},
        },
        [98910] = { -- Darkspear's Basic Care Package
            [questKeys.name] = "Darkspear's Basic Care Package",
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.DARKSPEAR_RAIDERS,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_DEFILERS, 10}},
            [questKeys.exclusiveTo] = {98911,98912}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMaxLevel] = 39,
            [questKeys.requiredMinRep] = {factionIDs.DARKSPEAR_RAIDERS, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98911] = { -- Darkspear's Standard Care Package
            [questKeys.name] = "Darkspear's Standard Care Package",
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.DARKSPEAR_RAIDERS,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_DEFILERS, 10}},
            [questKeys.exclusiveTo] = {98910,98912}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMaxLevel] = 49,
            [questKeys.requiredMinRep] = {factionIDs.DARKSPEAR_RAIDERS, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98912] = { -- Darkspear's Advanced Care Package
            [questKeys.name] = "Darkspear's Advanced Care Package",
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.DARKSPEAR_RAIDERS,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_DEFILERS, 10}},
            [questKeys.exclusiveTo] = {98910,98911}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMinRep] = {factionIDs.DARKSPEAR_RAIDERS, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98913] = { -- Theramore Basic Care Package
            [questKeys.name] = "Theramore Basic Care Package",
            [questKeys.requiredLevel] = 30,
            [questKeys.questLevel] = 39,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.THERAMORE_EXPEDITIONARY_FORCE,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_LEAGUE_OF_ARATHOR, 10}},
            [questKeys.exclusiveTo] = {98914,98915}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMaxLevel] = 39,
            [questKeys.requiredMinRep] = {factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98914] = { -- Darkspear's Standard Care Package
            [questKeys.name] = "Darkspear's Standard Care Package",
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.THERAMORE_EXPEDITIONARY_FORCE,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_LEAGUE_OF_ARATHOR, 10}},
            [questKeys.exclusiveTo] = {98913,98915}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMaxLevel] = 49,
            [questKeys.requiredMinRep] = {factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98915] = { -- Darkspear's Advanced Care Package
            [questKeys.name] = "Darkspear's Advanced Care Package",
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil,nil,nil,{factionIDs.THERAMORE_EXPEDITIONARY_FORCE,3000}}, -- big assumption here. update when confirmed/disproved
            [questKeys.zoneOrSort] = zoneIDs.DARKSPEAR_ISLANDS,
            [questKeys.reputationReward] = {{factionIDs.THE_LEAGUE_OF_ARATHOR, 10}},
            [questKeys.exclusiveTo] = {98913,98914}, -- mirroring the behavior for the other Care Package quests
            [questKeys.requiredMinRep] = {factionIDs.THERAMORE_EXPEDITIONARY_FORCE, 3000}, -- big assumption here. update when confirmed/disproved
        },
        [98919] = { -- Conquering the Island
            [questKeys.requiredLevel] = 50,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [99046] = { -- The Lost Runner
            [questKeys.breadcrumbForQuestId] = 99047,
            [questKeys.nextQuestInChain] = 99047,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99047] = { -- Not Dead Yet
            [questKeys.breadcrumbs] = {99046},
            [questKeys.nextQuestInChain] = 99050,
        },
        [99048] = { -- A Missing Hand
            [questKeys.nextQuestInChain] = 99049,
        },
        [99049] = { -- Threat from Below
            [questKeys.preQuestSingle] = {99048},
            [questKeys.nextQuestInChain] = 99051,
        },
        [99050] = { -- The Great Tree Provides
            [questKeys.preQuestSingle] = {99047},
            [questKeys.objectives] = {nil,nil,{{286017},{3371},{159}}},
            [questKeys.nextQuestInChain] = 99073,
        },
        [99051] = { -- Threat from Below
            [questKeys.preQuestSingle] = {99049},
            [questKeys.nextQuestInChain] = 99052,
        },
        [99052] = { -- Threat from Below
            [questKeys.preQuestSingle] = {99051},
        },
        [99053] = { -- Escaping Ban'ethil
            [questKeys.triggerEnd] = {"Escort Lynessa Duskblossom out of Ban'ethil", {[zoneIDs.TELDRASSIL] = {{43.08,51.65}}}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99073] = { -- Easing Suffering
            [questKeys.preQuestSingle] = {99050},
        },
        [99079] = { -- Longwalker Malah
            [questKeys.nextQuestInChain] = 99081,
        },
        [99080] = { -- Drive Them Out
            [questKeys.preQuestSingle] = {99101},
            [questKeys.nextQuestInChain] = 99082,
        },
        [99081] = { -- Grim Tidings
            [questKeys.preQuestSingle] = {99079},
            [questKeys.nextQuestInChain] = 99101,
        },
        [99082] = { -- The High Chieftain
            [questKeys.preQuestSingle] = {99080},
        },
        [99101] = { -- Our Ancient Enemy
            [questKeys.preQuestSingle] = {99081},
            [questKeys.nextQuestInChain] = 99080,
        },
        [99108] = { -- Sparring Match
            [questKeys.objectives] = {{{10721}}},
        },
        [99123] = { -- Lost in the Shadows
            [questKeys.triggerEnd] = {"Escort Pal'juh out of Kolkar Crag.", {[zoneIDs.DUROTAR] = {{51.41,79.29}}}},
        },
        [99127] = { -- A Net Disaster
            [questKeys.nextQuestInChain] = 99128,
        },
        [99128] = { -- Slimy Menace
            [questKeys.preQuestSingle] = {99127},
            [questKeys.nextQuestInChain] = 99129,
        },
        [99129] = { -- A Man About a Murloc
            [questKeys.preQuestSingle] = {99128},
            [questKeys.nextQuestInChain] = 99130,
        },
        [99130] = { -- An Enticing Offer
            [questKeys.objectives] = {nil,nil,{{286215},{286214}}},
            [questKeys.preQuestSingle] = {99129},
            [questKeys.nextQuestInChain] = 99131,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99131] = { -- Baited for Success
            [questKeys.preQuestSingle] = {99130},
        },
        [99134] = { -- Discipline
            [questKeys.objectives] = {nil,nil,nil,nil,{{{1495,1496,1519,1652,1735,1736,1737,1738,1739,1740,1741,1742,1743,1744,1745,1746,2209,2210,5725,251001,257655,272101,275103},1495,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [99141] = { -- Patience
            [questKeys.objectives] = {nil,nil,{{286200,nil,Questie.ICON_TYPE_TALK},{286201,nil,Questie.ICON_TYPE_TALK},{286202,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99142] = { -- Tomb Weed
            [questKeys.preQuestSingle] = {5482},
        },
        [99144] = { -- Seeking Refuge
            [questKeys.triggerEnd] = {"Escort Bareth Dawnstone out of Crusader's Outpost", {[zoneIDs.TIRISFAL_GLADES] = {{39,48.75}}}},
        },
        [99152] = { -- As Above, So Below
            [questKeys.preQuestSingle] = {96896},
        },
        [99153] = { -- The One That Got Away
            [questKeys.preQuestSingle] = {96896},
        },
        [99156] = { -- Rear Guard Patrol
            [questKeys.preQuestSingle] = {356},
            [questKeys.nextQuestInChain] = 92422,
        },
        [99158] = { -- Dawn in the Mountains
            [questKeys.breadcrumbForQuestId] = 99159,
            [questKeys.nextQuestInChain] = 99159,
        },
        [99159] = { -- Finding Warmth
            [questKeys.breadcrumbs] = {99158},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99160] = { -- Rime's Wrath
            [questKeys.preQuestSingle] = {99159},
            [questKeys.nextQuestInChain] = 99161,
        },
        [99161] = { -- Rime's Wrath
            [questKeys.preQuestSingle] = {99160},
        },
        [99162] = { -- Treacherous Cold
            [questKeys.preQuestSingle] = {99159},
            [questKeys.objectives] = {nil,nil,{{286360},{286359},{286358}}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99191] = { -- A Donation of Wool
            [questKeys.requiredLevel] = 12,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99192] = { -- A Donation of Silk
            [questKeys.name] = "A Donation of Silk",
            [questKeys.requiredLevel] = 26,
            [questKeys.questLevel] = 60,
            [questKeys.finishedBy] = {{276170}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99193] = { -- A Donation of Mageweave
            [questKeys.name] = "A Donation of Mageweave",
            [questKeys.finishedBy] = {{276170}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.objectives] = {nil,nil,{{4338}}},
        },
        [99194] = { -- A Donation of Runecloth
            [questKeys.name] = "A Donation of Runecloth",
            [questKeys.startedBy] = {{276170}},
            [questKeys.finishedBy] = {{276170}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestGroup] = {99191,99192,99193},
            [questKeys.nextQuestInChain] = 99195,
            [questKeys.objectives] = {nil,nil,{{14047}}},
        },
        [99195] = { -- Additional Runecloth
            [questKeys.name] = "Additional Runecloth",
            [questKeys.startedBy] = {{276170}},
            [questKeys.finishedBy] = {{276170}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {99194},
            [questKeys.objectives] = {nil,nil,{{14047}}},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [99196] = { -- A Donation of Wool
            [questKeys.requiredLevel] = 12,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [99197] = { -- A Donation of Silk
            [questKeys.requiredLevel] = 26,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [99198] = { -- A Donation of Mageweave
            [questKeys.name] = "A Donation of Mageweave",
            [questKeys.startedBy] = {{276171}},
            [questKeys.finishedBy] = {{276171}},
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.objectives] = {nil,nil,{{4338}}},
        },
        [99199] = { -- A Donation of Runecloth
            [questKeys.name] = "A Donation of Runecloth",
            [questKeys.startedBy] = {{276171}},
            [questKeys.finishedBy] = {{276171}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestGroup] = {99196,99197,99198},
            [questKeys.nextQuestInChain] = 99195,
            [questKeys.objectives] = {nil,nil,{{14047}}},
        },
        [99200] = { -- Additional Runecloth
            [questKeys.name] = "Additional Runecloth",
            [questKeys.startedBy] = {{276171}},
            [questKeys.finishedBy] = {{276171}},
            [questKeys.requiredLevel] = 50,
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {99199},
            [questKeys.objectives] = {nil,nil,{{14047}}},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [99201] = { -- Swift as the Wind
            [questKeys.objectives] = {{{7953,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99202] = { -- Swift as the Wind
            [questKeys.objectives] = {{{3690,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99203] = { -- Swift as the Wind
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.objectives] = {{{265756,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99204] = { -- Swift as the Wind
            [questKeys.objectives] = {{{4752,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99205] = { -- Swift as the Wind
            [questKeys.objectives] = {{{4753,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99206] = { -- Swift as the Wind
            [questKeys.objectives] = {{{4732,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99207] = { -- Swift as the Wind
            [questKeys.objectives] = {{{7954,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99208] = { -- Swift as the Wind
            [questKeys.objectives] = {{{4773,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99209] = { -- Swift as the Wind
            [questKeys.objectives] = {{{4772,nil,Questie.ICON_TYPE_TALK}}},
        },
        [99210] = { -- An Epic Ride
            [questKeys.requiredRaces] = raceIDs.DWARF,
            [questKeys.requiredSpell] = 33391,
        },
        [99211] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99212] = { -- An Epic Ride
            [questKeys.startedBy] = {{7955}},
            [questKeys.finishedBy] = {{7955}},
            [questKeys.requiredSpell] = 33391,
        },
        [99213] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99214] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99215] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99216] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99217] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99218] = { -- An Epic Ride
            [questKeys.requiredSpell] = 33391,
        },
        [99233] = { -- Brawl at the Maul
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [99234] = { -- Brawl at the Maul
            [questKeys.requiredLevel] = 55,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [99257] = { -- A Heart of Crystal
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {93394},
            [questKeys.nextQuestInChain] = 99258,
        },
        [99258] = { -- Mana Mania
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
            [questKeys.preQuestSingle] = {99257},
        },
        [99260] = { -- Fillion's Mission
            [questKeys.preQuestSingle] = {92850},
            [questKeys.nextQuestInChain] = 92840,
        },
        [99267] = { -- An Unfortunate End
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.zoneOrSort] = zoneIDs.DUSKWOOD,
        },
        [99326] = { -- Your First Horse
            [questKeys.exclusiveTo] = {95511,96982,96989,96994,96996,96997,97017,97045,97046,97171,97446,98166},
            [questKeys.requiredSpell] = 33388,
        },
        [99411] = { -- Kyle's Gone Missing!
            [questKeys.name] = "Kyle's Gone Missing!",
            [questKeys.startedBy] = {{277182}},
            [questKeys.finishedBy] = {{277182}},
            [questKeys.requiredLevel] = 5,
            [questKeys.questLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.objectivesText] = {"Ahab Wheathoof at Bloodhoof Village in Mulgore wants you to feed his prized puppy, Kyle the Frenzied.","","Feed Kyle Tender Strider Meat and return to Ahab Wheathoof."},
            [questKeys.objectives] = {{{277154,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.zoneOrSort] = zoneIDs.MULGORE,
            [questKeys.requiredSourceItems] = {287505},
            [questKeys.questFlags] = 8,
            [questKeys.reputationReward] = {{factionIDs.THUNDER_BLUFF, 100}},
        },
        [99435] = { -- The Great Masquerade
            [questKeys.requiredLevel] = 50,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {6402},
            [questKeys.exclusiveTo] = {6403},
        },
        [99670] = { -- Return to Jereman
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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

    local questFixesHorde = {
        [652] = { -- Breaking the Keystone
            [questKeys.nextQuestInChain] = 688,
        },
        [687] = { -- Theldurin the Lost
            [questKeys.preQuestSingle] = {688},
        },
        [2945] = { -- Grime-Encrusted Ring
            [questKeys.nextQuestInChain] = 2949,
        },
        [78124] = { -- Nar'thalas Almanac
            [questKeys.startedBy] = {{211022},{409496}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Nar'thalas Almanac, Vol. 74' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78127] = { -- The Dalaran Digest
            [questKeys.startedBy] = {{211022},{409501}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'The Dalaran Digest, Vol. 23' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78142] = { -- Bewitchments and Glamours
            [questKeys.startedBy] = {{211022},{409562}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Bewitchments and Glamours' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78143] = { -- Secrets of the Dreamers
            [questKeys.startedBy] = {{211022},{409692}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Secrets of the Dreamers' located just outside the Wailing Cavern dungeon and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78145] = { -- Arcanic Systems Manual
            [questKeys.startedBy] = {{211022},{409700}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Arcanic Systems Manual' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78146] = { -- Goaz Scrolls
            [questKeys.startedBy] = {{211022},{409717}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Goaz Scrolls' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78147] = { -- Crimes Against Anatomy
            [questKeys.startedBy] = {{211022},{409735}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Crimes Against Anatomy' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78148] = { -- Runes of the Sorcerer-Kings
            [questKeys.startedBy] = {{211022},{409731}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Runes of the Sorcerer-Kings' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78149] = { -- Fury of the Land
            [questKeys.startedBy] = {{211022},{409711}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Fury of the Land' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [78150] = { -- Friend of the Library
            [questKeys.startedBy] = {{211022}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"You will need to hand in 10 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79091] = { -- Archmage Antonidas: The Unabridged Autobiography
            [questKeys.startedBy] = {{211022},{386691}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Archmage Antonidas: The Unabridged Autobiography' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79092] = { -- Archmage Theocritus' Research Journal
            [questKeys.startedBy] = {{211022},{386759}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Archmage Theocritus' Research Journal' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79093] = { -- Rumi of Gnomeregan: The Collected Works
            [questKeys.startedBy] = {{211022},{408014}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Rumi of Gnomeregan: The Collected Works' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79094] = { -- The Lessons of Ta'zo
            [questKeys.startedBy] = {{211022},{405149}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'The Lessons of Ta'zo' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79095] = { -- The Apothecary's Metaphysical Primer
            [questKeys.startedBy] = {{211022},{405879}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'The Apothecary's Metaphysical Primer' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79096] = { -- Ataeric: On Arcane Curiosities
            [questKeys.startedBy] = {{211022},{410299}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Ataeric: On Arcane Curiosities' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79097] = { -- Baxtan: On Destructive Magics
            [questKeys.startedBy] = {{211022},{407566}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Baxtan: On Destructive Magics' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79535] = { -- Basilisks: Should Petrification be Feared?
            [questKeys.startedBy] = {{211022},{421526}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Basilisks: Should Petrification be Feared?' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79536] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211022}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"You will need to hand in 20 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79947] = { -- Geomancy: The Stone-Cold Truth
            [questKeys.startedBy] = {{211022},{423895}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Geomancy: The Stone-Cold Truth' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79948] = { -- Defensive Magics 101
            [questKeys.startedBy] = {{211022},{423896}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Defensive Magics 101' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79949] = { -- A Web of Lies: Debunking Myths and Legends
            [questKeys.startedBy] = {{211022},{423897}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'A Web of Lies: Debunking Myths and Legends' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79950] = { -- Demons and You
            [questKeys.startedBy] = {{211022},{423898}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Demons and You' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79951] = { -- Mummies: A Guide to the Unsavory Undead
            [questKeys.startedBy] = {{211022},{423899}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Mummies: A Guide to the Unsavory Undead' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79952] = { -- RwlRwlRwlRwl!
            [questKeys.startedBy] = {{211022},{423900}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'RwlRwlRwlRwl!' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [79953] = { -- A Ludite's Guide to Caring for Your Demonic Pet
            [questKeys.startedBy] = {{211022},{423901}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'A Ludite's Guide to Caring for Your Demonic Pet' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81947] = { -- Sanguine Sorcery
            [questKeys.startedBy] = {{211022},{441247}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Sanguine Sorcery' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81949] = { -- Legends of the Tidesages
            [questKeys.startedBy] = {{211022},{441248}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Legends of the Tidesages' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81951] = { -- The Liminal and the Arcane
            [questKeys.startedBy] = {{211022},{441249}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'The Liminal and the Arcane' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81952] = { -- Everyday Etiquette
            [questKeys.startedBy] = {{211022},{441250}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Everyday Etiquette' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81953] = { -- Stonewrought Design
            [questKeys.startedBy] = {{211022},{441251}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Stonewrought Design' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81954] = { -- Venomous Journeys
            [questKeys.startedBy] = {{211022},{441252}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Venomous Journeys' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81955] = { -- A Mind of Metal
            [questKeys.startedBy] = {{211022},{441253}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'A Mind of Metal' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [81956] = { -- Conjurer's Codex
            [questKeys.startedBy] = {{211022},{441254}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.objectivesText] = {"Collect 'Conjurer's Codex' and bring it to Owen Thadd in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [82208] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211022}},
            [questKeys.finishedBy] = {{211022}},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84395] = { -- Undead Potatoes
            [questKeys.startedBy] = {{7825},{463213}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Undead Potatoes' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84396] = { -- Magma or Lava?
            [questKeys.startedBy] = {{7825},{463206}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Magma or Lava?' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84397] = { -- Northern Kalimdor - A Comprehensive Guide
            [questKeys.startedBy] = {{7825},{463209}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Northern Kalimdor - A Comprehensive Guide' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84398] = { -- A Study of the Light
            [questKeys.startedBy] = {{7825},{463207}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'A Study of the Light' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84399] = { -- Ka-Boom!
            [questKeys.startedBy] = {{7825},{463214}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Ka-Boom!' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84400] = { -- The Knight and the Lady
            [questKeys.startedBy] = {{7825},{463208}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'The Knight and the Lady' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84401] = { -- Scourge: Undead Menace or Misunderstood?
            [questKeys.startedBy] = {{7825},{463212}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Scourge: Undead Menace or Misunderstood?' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [84402] = { -- Necromancy 101
            [questKeys.startedBy] = {{7825},{463211}},
            [questKeys.finishedBy] = {{7825}},
            [questKeys.objectivesText] = {"Collect 'Necromancy 101' and bring it to Oran Snakewrithe in Undercity."},
            [questKeys.zoneOrSort] = zoneIDs.UNDERCITY,
        },
        [91899] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91900] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91901] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91902] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91903] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91904] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91905] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91906] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [91907] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.THE_BARRENS,
        },
        [97286] = { -- Research Access
            [questKeys.startedBy] = {{211022}},
            [questKeys.finishedBy] = {{211022}},
        },
        [97287] = { -- Shrewd Negotiations
            [questKeys.finishedBy] = {{269127}},
        },
    }

    local questFixesAlliance = {
        [652] = { -- Breaking the Keystone
            [questKeys.nextQuestInChain] = 653,
        },
        [687] = { -- Theldurin the Lost
            [questKeys.preQuestSingle] = {653},
        },
        [2945] = { -- Grime-Encrusted Ring
            [questKeys.nextQuestInChain] = 2947,
        },
        [78124] = { -- Nar'thalas Almanac
            [questKeys.startedBy] = {{211033},{409496}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Nar'thalas Almanac, Vol. 74' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78127] = { -- The Dalaran Digest
            [questKeys.startedBy] = {{211033},{409501}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'The Dalaran Digest, Vol. 23' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78142] = { -- Bewitchments and Glamours
            [questKeys.startedBy] = {{211033},{409562}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Bewitchments and Glamours' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78143] = { -- Secrets of the Dreamers
            [questKeys.startedBy] = {{211033},{409692}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Secrets of the Dreamers' located just outside the Wailing Cavern dungeon and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78145] = { -- Arcanic Systems Manual
            [questKeys.startedBy] = {{211033},{409700}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Arcanic Systems Manual' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78146] = { -- Goaz Scrolls
            [questKeys.startedBy] = {{211033},{409717}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Goaz Scrolls' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78147] = { -- Crimes Against Anatomy
            [questKeys.startedBy] = {{211033},{409735}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Crimes Against Anatomy' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78148] = { -- Runes of the Sorcerer-Kings
            [questKeys.startedBy] = {{211033},{409731}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Runes of the Sorcerer-Kings' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78149] = { -- Fury of the Land
            [questKeys.startedBy] = {{211033},{409711}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Fury of the Land' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [78150] = { -- Friend of the Library
            [questKeys.startedBy] = {{211033}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"You will need to hand in 10 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79091] = { -- Archmage Antonidas: The Unabridged Autobiography
            [questKeys.startedBy] = {{211033},{386691}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Archmage Antonidas: The Unabridged Autobiography' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79092] = { -- Archmage Theocritus' Research Journal
            [questKeys.startedBy] = {{211033},{386759}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Archmage Theocritus' Research Journal' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79093] = { -- Rumi of Gnomeregan: The Collected Works
            [questKeys.startedBy] = {{211033},{408014}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Rumi of Gnomeregan: The Collected Works' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79094] = { -- The Lessons of Ta'zo
            [questKeys.startedBy] = {{211033},{405149}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'The Lessons of Ta'zo' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79095] = { -- The Apothecary's Metaphysical Primer
            [questKeys.startedBy] = {{211033},{405879}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'The Apothecary's Metaphysical Primer' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79096] = { -- Ataeric: On Arcane Curiosities
            [questKeys.startedBy] = {{211033},{410299}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Ataeric: On Arcane Curiosities' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79097] = { -- Baxtan: On Destructive Magics
            [questKeys.startedBy] = {{211033},{407566}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Baxtan: On Destructive Magics' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79535] = { -- Basilisks: Should Petrification be Feared?
            [questKeys.startedBy] = {{211033},{421526}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Basilisks: Should Petrification be Feared?' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79536] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211033}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"You will need to hand in 20 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79947] = { -- Geomancy: The Stone-Cold Truth
            [questKeys.startedBy] = {{211033},{423895}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Geomancy: The Stone-Cold Truth' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79948] = { -- Defensive Magics 101
            [questKeys.startedBy] = {{211033},{423896}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Defensive Magics 101' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79949] = { -- A Web of Lies: Debunking Myths and Legends
            [questKeys.startedBy] = {{211033},{423897}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'A Web of Lies: Debunking Myths and Legends' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79950] = { -- Demons and You
            [questKeys.startedBy] = {{211033},{423898}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Demons and You' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79951] = { -- Mummies: A Guide to the Unsavory Undead
            [questKeys.startedBy] = {{211033},{423899}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Mummies: A Guide to the Unsavory Undead' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79952] = { -- RwlRwlRwlRwl!
            [questKeys.startedBy] = {{211033},{423900}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'RwlRwlRwlRwl!' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [79953] = { -- A Ludite's Guide to Caring for Your Demonic Pet
            [questKeys.startedBy] = {{211033},{423901}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'A Ludite's Guide to Caring for Your Demonic Pet' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81947] = { -- Sanguine Sorcery
            [questKeys.startedBy] = {{211033},{441247}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Sanguine Sorcery' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81949] = { -- Legends of the Tidesages
            [questKeys.startedBy] = {{211033},{441248}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Legends of the Tidesages' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81951] = { -- The Liminal and the Arcane
            [questKeys.startedBy] = {{211033},{441249}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'The Liminal and the Arcane' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81952] = { -- Everyday Etiquette
            [questKeys.startedBy] = {{211033},{441250}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Everyday Etiquette' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81953] = { -- Stonewrought Design
            [questKeys.startedBy] = {{211033},{441251}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Stonewrought Design' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81954] = { -- Venomous Journeys
            [questKeys.startedBy] = {{211033},{441252}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Venomous Journeys' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81955] = { -- A Mind of Metal
            [questKeys.startedBy] = {{211033},{441253}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'A Mind of Metal' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [81956] = { -- Conjurer's Codex
            [questKeys.startedBy] = {{211033},{441254}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.objectivesText] = {"Collect 'Conjurer's Codex' and bring it to Garion Wendell in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [82208] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211033}},
            [questKeys.finishedBy] = {{211033}},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84395] = { -- Undead Potatoes
            [questKeys.startedBy] = {{5497},{463213}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Undead Potatoes' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84396] = { -- Magma or Lava?
            [questKeys.startedBy] = {{5497},{463206}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Magma or Lava?' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84397] = { -- Northern Kalimdor - A Comprehensive Guide
            [questKeys.startedBy] = {{5497},{463209}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Northern Kalimdor - A Comprehensive Guide' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84398] = { -- A Study of the Light
            [questKeys.startedBy] = {{5497},{463207}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'A Study of the Light' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84399] = { -- Ka-Boom!
            [questKeys.startedBy] = {{5497},{463214}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Ka-Boom!' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84400] = { -- The Knight and the Lady
            [questKeys.startedBy] = {{5497},{463208}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'The Knight and the Lady' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84401] = { -- Scourge: Undead Menace or Misunderstood?
            [questKeys.startedBy] = {{5497},{463212}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Scourge: Undead Menace or Misunderstood?' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [84402] = { -- Necromancy 101
            [questKeys.startedBy] = {{5497},{463211}},
            [questKeys.finishedBy] = {{5497}},
            [questKeys.objectivesText] = {"Collect 'Necromancy 101' and bring it to Jennea Cannon in Stormwind."},
            [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY,
        },
        [91899] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91900] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91901] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91902] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91903] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91904] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91905] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91906] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [91907] = { -- A Sealed Crate
            [questKeys.zoneOrSort] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [97286] = { -- Research Access
            [questKeys.startedBy] = {{211033}},
            [questKeys.finishedBy] = {{211033}},
        },
    }

    if UnitFactionGroup("Player") == "Horde" then
        return questFixesHorde
    else
        return questFixesAlliance
    end
end
