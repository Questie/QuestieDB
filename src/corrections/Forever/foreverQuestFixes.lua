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

    return {
        [19] = { -- Tharil'zun
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {20,98387},
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
        [273] = { -- Resupplying the Excavation
            [questKeys.objectives] = {nil,nil,nil,nil,{{{1379,2057},15885,nil,Questie.ICON_TYPE_EVENT}}},
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
        [324] = { -- The Lost Ingots
            [questKeys.exclusiveTo] = {526},
        },
        [334] = { -- Package for Thurman
            [questKeys.disabledByQuest] = 333,
        },
        [356] = { -- Rear Guard Patrol
            [questKeys.nextQuestInChain] = 99156,
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
        [544] = { -- Prison Break In
            [questKeys.nextQuestInChain] = 0,
        },
        [545] = { -- Dalaran Patrols
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {544,93680},
        },
        [590] = { -- A Rogue's Deal
            [questKeys.objectives] = {{{6784}}},
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
        [1079] = { -- Covert Ops - Alpha
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Place the NG-5 Explosives (Blue)"), 0, {{"object", 19591}}}},
        },
        [1080] = { -- Covert Ops - Beta
            [questKeys.extraObjectives] = {{nil, Questie.ICON_TYPE_OBJECT, l10n("Place the NG-5 Explosives (Red)"), 0, {{"object", 19600}}}},
        },
        [1086] = { -- The Flying Machine Airport
            [questKeys.objectives] = {nil,{{19594}}},
        },
        [1122] = { -- Report Back to Fizzlebub
            [questKeys.nextQuestInChain] = 0,
        },
        [1127] = { -- Fool's Stout
            [questKeys.parentQuest] = 0,
        },
        [1273] = { -- Questioning Reethe
            [questKeys.objectives] = {{{4980,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [1276] = { -- The Black Shield
            [questKeys.preQuestSingle] = {},
            [questKeys.preQuestGroup] = {1273,1323},
        },
        [1486] = { -- Deviate Hides
            [questKeys.startedBy_remove] = {nil,{659159}},
        },
        [1516] = { -- Call of Earth
            [questKeys.exclusiveTo] = {1519,92466},
        },
        [1519] = { -- Call of Earth
            [questKeys.exclusiveTo] = {1516,92466},
        },
        [1531] = { -- Call of Air
            [questKeys.exclusiveTo] = {1532,96136},
        },
        [1532] = { -- Call of Air
            [questKeys.exclusiveTo] = {1531,96136},
        },
        [1657] = { -- Stinking Up Southshore
            [questKeys.objectives] = {{{15415,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [1883] = { -- Speak with Un'thuwa
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [2519] = { -- The Temple of the Moon
            [questKeys.breadcrumbs] = {98391},
        },
        [3505] = { -- Betrayed
            [questKeys.finishedBy_remove] = {{247449}},
        },
        [4763] = { -- The Blackwood Corrupted
            [questKeys.extraObjectives] = {
                {nil, Questie.ICON_TYPE_OBJECT, l10n("Summon Xabraxxis once you have the required items from the Blackwood Stores."), 0, {{"object", 176705}}},
                {nil, Questie.ICON_TYPE_SLAY, l10n("Kill Xabraxxis"), 0, {{"monster", 10373}}},
            },
        },
        [5147] = { -- WANTED: Arnak Grimtotem
            [questKeys.name] = "WANTED: Arnak Grimtotem",
        },
        [5321] = { -- The Sleeper Has Awakened
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Escort Kerlonian Evershade on the road south to his bag",{[zoneIDs.DARKSHORE] = {{42,90.5}}}},
        },
        [5482] = { -- Doom Weed
            [questKeys.nextQuestInChain] = 99142,
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
        [6126] = { -- Lessons Anew
            [questKeys.startedBy_add] = {{262560}},
        },
        [7790] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [8152] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [8356] = { -- Flexing for Nougat
            [questKeys.objectivesText] = {"Do a flex emote at Innkeeper Allison, and in exchange you'll receive Stormwind Nougat!"},
        },
        [8409] = { -- Ruined Kegs
            [questKeys.requiredLevel] = 30,
        },
        [60860] = { -- Your Reward has Arrived!
            [questKeys.name] = "Your Reward has Arrived!",
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [60870] = { -- A Special Gift
            [questKeys.name] = "A Special Gift", -- google translate
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [76156] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.ORC + raceIDs.TAUREN + raceIDs.TROLL,
            [questKeys.requiredClasses] = classIDs.NONE,
            [questKeys.nextQuestInChain] = 76160,
            [questKeys.objectives] = {nil,nil,{{206157}}},
            [questKeys.sourceItemId] = 206159,
        },
        [76160] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.ORC + raceIDs.TAUREN + raceIDs.TROLL,
            [questKeys.preQuestSingle] = {76156},
            [questKeys.nextQuestInChain] = 76240,
            [questKeys.sourceItemId] = 206176,
            [questKeys.objectives] = {nil,nil,{{206175}}},
            [questKeys.requiredSourceItems] = {206170},
        },
        [76240] = { -- Stalk With The Earthmother
            [questKeys.requiredRaces] = raceIDs.ORC + raceIDs.TAUREN + raceIDs.TROLL,
            [questKeys.preQuestSingle] = {76160},
            [questKeys.sourceItemId] = 206344,
            [questKeys.objectives] = {nil,nil,{{206345}}},
            [questKeys.requiredSourceItems] = {6291},
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
        },
        [78270] = { -- Goblin Lockpicks
            [questKeys.questLevel] = 23,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78307] = { -- The Horn of Xelthos
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 23,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.requiredClasses] = classIDs.ROGUE,
            [questKeys.preQuestSingle] = {78261},
        },
        [78823] = { -- Terror of the Desert Skies
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78830] = { -- Terror of the Desert Skies
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
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
        },
        [79235] = { -- On the Lam
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [79236] = { -- Cherry for Your Thoughts?
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [79242] = { -- No Honor Among Thieves
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [79365] = { -- With Wind Beneath Your Wings
            [questKeys.requiredRaces] = raceIDs.ORC + raceIDs.TAUREN, -- wowhead
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
        [79677] = { -- A Quick Grocery Run
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [79678] = { -- Taste Testing
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
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
        [82208] = { -- Greater Friend of the Library
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.objectivesText] = {"You will need to hand in 25 books to complete this quest, however you can hand 1 in at any time."},
            [questKeys.preQuestSingle] = {79536},
        },
        [84151] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [84319] = {
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
        [86577] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86615] = { -- Treaty Obligations
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [86746] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86747] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [86799] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86804] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [86925] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [87288] = { -- Soft Saber Pelts
            [questKeys.reputationReward] = {{factionIDs.DARNASSUS, 100},{factionIDs.GNOMEREGAN_EXILES, 25},{factionIDs.ALLIANCE, 25},{factionIDs.IRONFORGE, 25},{factionIDs.STORMWIND, 25}},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [87494] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [87760] = { -- Holy Diver
            [questKeys.preQuestGroup] = {4722,4723,4725,4727,4728,4730,4731,4732,4733},
        },
        [90487] = { -- Ancient Allies
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [90647] = { -- The Staff of the Mountain
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [90750] = { -- More Work?
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [90854] = { -- Leather for Inclement Weather
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [91564] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91696] = { -- Open Season
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91697] = { -- Meet the Elders
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91698] = { -- Barkskin Breakout
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91723] = { -- Delicate Instruments
            [questKeys.nextQuestInChain] = 91724,
        },
        [91724] = { -- Delicate Instruments
            [questKeys.preQuestSingle] = {91723},
        },
        [91736] = { -- Applejack Still
            [questKeys.startedBy] = {nil,{562131}},
            [questKeys.finishedBy] = {nil,{562131}},
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = 1,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
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
        [91754] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91755] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91758] = { -- Follow That Kobold!
            [questKeys.preQuestSingle] = {91752},
            [questKeys.nextQuestInChain] = 91772,
        },
        [91770] = { -- Bark Bite
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [91882] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91902] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91904] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91905] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91906] = { -- A Sealed Crate
            [questKeys.questLevel] = 60,
            [questKeys.startedBy] = {{256386,256390}},
            [questKeys.finishedBy] = {{256386,256390}},
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [91907] = { -- A Sealed Crate
            [questKeys.name] = "A Sealed Crate",
            [questKeys.questLevel] = 60,
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
        [91952] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92008] = { -- Premiere Parts
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92009] = { -- Crate Expectations
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92011] = { -- Rubble Rummage
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92016] = { -- Rootwork
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92017] = { -- Cleansing Winds
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92020] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92065] = { -- Blackmaw Reclamation
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92066] = { -- The Twin Bears
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92067] = { -- Feeding Time!
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92069] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92070] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92100] = { -- Anywhere But Here
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92124] = { -- Book Inventory
            [questKeys.preQuestSingle] = {91741},
            [questKeys.nextQuestInChain] = 91743,
        },
        [92147] = { -- Highfeather Helper
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92169] = { -- Paying Back the Pact
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92171] = { -- Taking to New Heights
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92317] = { -- Stolen Life
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92328] = { -- Siegecraft
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92329] = { -- Drum Up Trouble
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92335] = { -- Ashes of the Legion Ascent
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [92433] = { -- Now We're Cooking
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [92468] = { -- Call of Earth
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {92467},
        },
        [92469] = { -- Return to Rorian
            [questKeys.preQuestSingle] = {92465},
        },
        [92470] = { -- Foul Matriarch
            [questKeys.preQuestSingle] = {92471},
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92514] = { -- Welcome to Shen'dar Village
            [questKeys.objectives] = {{{251902,nil,Questie.ICON_TYPE_TALK},{254089,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [92515] = { -- The Problem With Prideclaws
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92516] = { -- Hippogryph Harrassment
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92517] = { -- The Criminal Element
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.nextQuestInChain] = 93036,
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92528] = { -- Among the Faithful
            [questKeys.preQuestSingle] = {92529},
            [questKeys.objectives] = {{{254128,nil,Questie.ICON_TYPE_EVENT}}},
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
        [92594] = { -- Kindling, Kinda
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [92612] = { -- Aid from Moonglade
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [92679] = { -- Blood Tithe
            [questKeys.objectives] = {{{252800,nil,Questie.ICON_TYPE_INTERACT},{252448,nil,Questie.ICON_TYPE_EVENT}}}, -- 2nd objective is Optional
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
        [92703] = { -- Deliver the News
            [questKeys.preQuestSingle] = {92693},
        },
        [92706] = { -- WANTED: Bruuz
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
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
        [92819] = { -- Destruction in Deadmines
            [questKeys.preQuestSingle] = {92753},
            [questKeys.objectives] = {nil,{{581792}}},
        },
        [92833] = { -- Ve'han's Fall
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92834] = { -- Avenged Tenfold
            [questKeys.preQuestSingle] = {92840},
        },
        [92840] = { -- Catching Wind
            [questKeys.preQuestSingle] = {99260},
            [questKeys.objectives] = {nil,{{697118}}},
        },
        [92842] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [92859] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92860] = { -- In Service of Zephras
            [questKeys.preQuestSingle] = {92840},
            [questKeys.nextQuestInChain] = 93320,
        },
        [92871] = { -- In Service of Zephras
            [questKeys.preQuestSingle] = {93746},
            [questKeys.nextQuestInChain] = 93320,
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
        },
        [92947] = { -- Making Our Move
            [questKeys.preQuestSingle] = {93065},
            [questKeys.nextQuestInChain] = 93958,
            [questKeys.objectives] = {{{252762},{252763},{252765},{253576,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92959] = { -- The Dying Ancients
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [92960] = { -- Siphoned Ephemeral Essence
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93016] = { -- A Brief History Lesson
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93036] = { -- Infiltrating the Cult
            [questKeys.preQuestSingle] = {92517},
            [questKeys.nextQuestInChain] = 92529,
        },
        [93045] = { -- Test Your Theory
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [93065] = { -- Prepare for Battle
            [questKeys.preQuestSingle] = {92640},
            [questKeys.nextQuestInChain] = 92947,
            [questKeys.objectives] = {{{253844,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [93089] = { -- What Comes Next
            [questKeys.preQuestSingle] = {94369},
            [questKeys.nextQuestInChain] = 94946,
        },
        [93090] = { -- What Comes Next
            [questKeys.preQuestSingle] = {93836},
            [questKeys.nextQuestInChain] = 95349,
        },
        [93127] = { -- Summit Sentries
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [93162] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [93197] = { -- Mending Communications
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93269] = { -- Top of the Post
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [93362] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93394] = { -- Meeting the Magister
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93404] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93406] = { -- Unfrozen Deliveries
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93407] = { -- A Thorn in the Paw
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93422] = { -- Blackthorne Blackout
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93443] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [93444] = { -- Bait the Beast
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93450] = { -- Phantasmal Problems
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93459] = { -- More Al'Aketh Ears
            [questKeys.preQuestSingle] = {93165},
            [questKeys.objectivesText] = {}, -- turn in only quest, no objectivesText for these
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [93461] = { -- Welcome to Shen'dar Village
            [questKeys.objectives] = {{{251903,nil,Questie.ICON_TYPE_TALK},{254089,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93521] = { -- Challenger of the Gods
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93546] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93547] = { -- A Thorny Solution
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93551] = { -- Praise
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93552] = { -- Harvesting Windstones
            [questKeys.preQuestSingle] = {92461},
        },
        [93567] = { -- Ends Meet
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93568] = { -- Partially Digested Collar
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93572] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93574] = { -- Corpsefeeder's Carapace
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93584] = { -- Cult Closure
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93594] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93601] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93604] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93606] = { -- Not on Squealing Terms
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93609] = { -- Forlorn Necklace
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93615] = { -- Kits and Cats
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93617] = { -- Prey and Predator
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93644] = { -- Tattered Journal
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [93679] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93684] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93685] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93686] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [93740] = { -- Blood for Blood
            [questKeys.preQuestSingle] = {93746},
        },
        [93746] = { -- A Firm Response
            [questKeys.preQuestSingle] = {93738},
            [questKeys.objectives] = {{{256247,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93747] = { -- Violence Into Verdure
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93759] = { -- The Bounty of Nature
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93773] = { -- The Pact
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [93826] = { -- Deal Dread to Deadwood
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93827] = { -- Windswept Wards
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93828] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93830] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93831] = { -- Sweetpaw Jam
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93833] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        },
        [93836] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {92646},
            [questKeys.nextQuestInChain] = 93090,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93848] = { -- Work Well Done
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [93925] = { -- Beads for Brerufa
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [94003] = { -- The Skybreaker Bulwark
            [questKeys.requiredClasses] = classIDs.WARRIOR,
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
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
        },
        [94050] = { -- Training the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {94013},
        },
        [94218] = { -- Craftsman's Writ: Elixir of Defense
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94219] = { -- Craftsman's Writ: Draught of Water Breathing
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94222] = { -- Craftsman's Writ: Iridescent Hammer
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94230] = { -- Craftsman's Writ: Explosive Sheep
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94231] = { -- Craftsman's Writ: Moonsight Rifle
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94247] = { -- Craftsman's Writ: Lesser Wizard's Robe
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94255] = { -- Craftsman's Writ: Spider Silk Slippers
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94369] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {93835},
            [questKeys.nextQuestInChain] = 93089,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94373] = { -- Call of Earth
            [questKeys.nextQuestInChain] = 94374,
        },
        [94374] = { -- Call of Earth
            [questKeys.preQuestSingle] = {94373},
            [questKeys.nextQuestInChain] = 94375,
        },
        [94375] = { -- Call of Earth
            [questKeys.startedBy_add] = {{257446}},
            [questKeys.preQuestSingle] = {94374},
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
        [94479] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [94480] = { -- A Gift From Our Enemies
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94483] = { -- Show Them How It's Done
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [94505] = { -- Call of Water
            [questKeys.preQuestSingle] = {94503},
        },
        [94532] = { -- Gnoll Infestation
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94533] = { -- Snargl's Snout
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94556] = { -- Jom-jom's Escape
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94568] = { -- The Cult's True Plans
            [questKeys.preQuestSingle] = {92644},
            [questKeys.nextQuestInChain] = 92640,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94614] = { -- Freshwater Fiends
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94615] = { -- Foal Play
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94616] = { -- Water Sapta
            [questKeys.preQuestSingle] = {94501},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
            [questKeys.availableUntilCompleted] = 94502,
        },
        [94617] = { -- Coyote Huntin'
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94618] = { -- Wheeler's Fleeing Steeds
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94638] = { -- Strength and Mercy
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.preQuestSingle] = {94006},
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [94668] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94669] = { -- Pay to Play
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94670] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94672] = { -- Encroaching Twilight
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94678] = { -- Gnoll Infestation
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94679] = { -- Snargl's Snout
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94680] = { -- Twilight Missives
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94727] = { -- Digging for Answers
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94733] = { -- Our Ogre Friend
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94734] = { -- A Boar's Delight
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94737] = { -- A Treat for a Friend
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94739] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94744] = { -- The Wayward Warrior
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94745] = { -- Carving a Path
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94748] = { -- Break Their Chains
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
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
        },
        [94841] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94857] = { -- If a Tree Falls, and No One Hears...
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94858] = { -- All That's Left
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
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
        [94884] = { -- An Unsettling Discovery
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94885] = { -- Field Marshal's Log
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94888] = { -- No Soldier Left Behind
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94889] = { -- Carving a Path
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94890] = { -- Bring Me His Head
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94891] = { -- News to Farholde
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94892] = { -- Dying Wish
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94895] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94896] = { -- Aid For The Refugees
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [94897] = { -- The Fate of a Loved One
            [questKeys.requiredRaces] = raceIDs.NONE,
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
        [94927] = { -- Dunston Checks Out
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94930] = { -- Lost Shipping Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [94962] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94963] = { -- Biting the Hand
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [94964] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94965] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [94978] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.nextQuestInChain] = 94979,
            [questKeys.objectives] = {{{254588,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [94979] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {94978},
            [questKeys.nextQuestInChain] = 94013,
            [questKeys.objectives] = {{{251707,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [94980] = { -- Krol'dok Moulding
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94983] = { -- Twilight Mementos
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94992] = { -- Rescue Roundup
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94997] = { -- Lingering Essence
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [94999] = { -- Eyes for the Watchman
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95006] = { -- Stolen Power
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95033] = { -- On the Other Side
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95034] = { -- The Debt
            [questKeys.preQuestSingle] = {96204},
            [questKeys.nextQuestInChain] = 95036,
            [questKeys.objectives] = {{{259620,nil,Questie.ICON_TYPE_TALK}}}, -- Lumina Windsinger in the Sepulcher
        },
        [95036] = { -- A Moon-Kissed Blade
            [questKeys.requiredRaces] = raceIDs.UNDEAD,
            [questKeys.preQuestSingle] = {95034},
            [questKeys.nextQuestInChain] = 95111,
            -- Speak with Trevan for notes, then gather materials
            [questKeys.objectives] = {{{248840,nil,Questie.ICON_TYPE_TALK}},nil,{{267454},{6994},{267361},{272448}}},
        },
        [95059] = { -- Frazzlespark's Crate
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95062] = { -- Frazzlespark's Crate
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95063] = { -- Bloodmaster's Ring
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95065] = { -- Fishin' Time
            [questKeys.objectives] = {nil,nil,{{6529},{6530}}},
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
        },
        [95123] = { -- A Blast Ye Scurvy Dogs!
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95124] = { -- Admiral Lamora
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95125] = { -- Ott's Masterwork
            [questKeys.preQuestSingle] = {95111},
            [questKeys.nextQuestInChain] = 95126,
            [questKeys.objectives] = {{{3539,nil,Questie.ICON_TYPE_EVENT}}}, -- Watch Ott forge the blade
        },
        [95126] = { -- The Moonsilver Blade
            [questKeys.preQuestSingle] = {95125},
            [questKeys.nextQuestInChain] = 95140,
        },
        [95140] = { -- Old Fire-Eye
            [questKeys.preQuestSingle] = {95126},
            [questKeys.objectives] = {{{259897}},nil,{{268484}}}, -- Old Fire-Eye + Moonsilver Blade
        },
        [95144] = { -- Overseas Delivery
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95147] = { -- The Lost Scout
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95148] = { -- Southern Watch Gnoll Report
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95161] = { -- Remember That I Love You
            [questKeys.preQuestSingle] = {92415},
        },
        [95162] = { -- Paletusk Harvesting
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95163] = { -- Drive Them Back
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95165] = { -- See Ya, Scallywags!
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95183] = { -- Step One: Rock
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95189] = { -- Crest of Lordaeron
            [questKeys.requiredLevel] = 15,
        },
        [95195] = { -- Bloodied Insignia
            [questKeys.requiredLevel] = 15,
        },
        [95204] = { -- Crest of Lordaeron
            [questKeys.requiredLevel] = 15,
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
        [95219] = { -- From Port to Port
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95250] = { -- Abominable Creatures
            [questKeys.requiredLevel] = 15,
        },
        [95254] = { -- WANTED: Trapclaw
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95260] = { -- Terrors From the Deep
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95261] = { -- It Takes Guts
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95267] = { -- The Monster Surfaces
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95288] = { -- Smuggler's Paradise
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95293] = { -- Smuggler's Special
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95294] = { -- Smuggler's Bargain
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95295] = { -- I Know a Guy
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95296] = { -- Shipping and Handling
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95312] = { -- Coming to Collect
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95314] = { -- That Shadowvale Green Elixir
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [95316] = { -- The Experimental Method
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95317] = { -- Notation, Notation, Notation
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95318] = { -- Taste of Ash
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95319] = { -- Crystalline Collection
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95320] = { -- A Curious Question
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95321] = { -- Tazzik's Dues
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95322] = { -- Get the Goods
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95325] = { -- We've Been Robbed!
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95326] = { -- The Big Payback
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95327] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95349] = { -- The Earthen Ring
            [questKeys.preQuestSingle] = {93090},
        },
        [95350] = { -- Welcome to Azeroth
            [questKeys.nextQuestInChain] = 93739,
        },
        [95378] = { -- The Hydra's Head
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95379] = { -- A Revenge So Sweet
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95380] = { -- A Prolific Source
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95383] = { -- Shipping and Handling
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95385] = { -- Torn Mystical Scroll
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95417] = { -- The Purple Ones
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95418] = { -- Spread the Word
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95420] = { -- Land of Giants
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95424] = { -- Might Makes Right
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95425] = { -- Unworthy Champion
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95427] = { -- Twilight No More!
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95428] = { -- Clugfist's Decree
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95431] = { -- Rumblings of Discontent
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95472] = { -- Consolation Prize
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95494] = { -- Bruised Pride and Lion Hides
            [questKeys.nextQuestInChain] = 95495,
        },
        [95495] = { -- The Hermit Tanner
            [questKeys.preQuestGroup] = {95494,95507},
        },
        [95561] = { -- Apple of My Eye
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95562] = { -- Cut Off the Heads
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95568] = { -- Seeds for a New Season
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95569] = { -- Hope for Hatchlings
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95599] = { -- The Old Key
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95601] = { -- The Purple Ones
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95602] = { -- Sickening Lights
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95603] = { -- Bats in the Belfry
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95611] = { -- Rites of Respect
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95613] = { -- Keeping the Light On
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95615] = { -- In Memoriam
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95621] = { -- Trouble in the Valley
            [questKeys.preQuestSingle] = {95495},
        },
        [95642] = { -- Abominable Magics
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95643] = { -- Indiscriminate Purge
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95753] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95766] = { -- Fine Feathered Friend
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95769] = { -- Threading a Solution
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95789] = { -- Shady Saltseers
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95791] = { -- The Saltseer Captain
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95792] = { -- Clear 'em Out
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95793] = { -- Stemming the Demon Tide
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [95803] = { -- A Token of Good Faith
            [questKeys.preQuestSingle] = {91317}, -- 91316 is not needed
        },
        [95805] = { -- Grace of An'she and Mu'sha
            [questKeys.preQuestSingle] = {755},
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
        [95951] = { -- Fetch 'n' Fletch
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [95957] = { -- Drink Up!
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95961] = { -- Stepped Out
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95975] = { -- Her World
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95981] = { -- Watching the Roads
            [questKeys.preQuestSingle] = {482},
        },
        [95982] = { -- Not My Circus
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [95983] = { -- A Feast for Buzzards
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [95988] = { -- Goes Down Smooth
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
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
        },
        [96010] = { -- Fragments of the Pylons
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [96015] = { -- A Miner Problem
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96018] = { -- Powering the Pylons
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [96025] = { -- As the Crow Flies
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96026] = { -- Step Two: More Rock
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
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
        [96060] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96063] = { -- Gaseous Gold
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [96067] = { -- Rock 'em and Sock 'em
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [96076] = { -- In Demand - Ancient Elven Curiosities
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96081] = { -- Wound Dressings
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96082] = { -- Doctor's Orderly
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96083] = { -- Clerical Quarantine
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96084] = { -- Something's in the Water
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96085] = { -- Upstream Contamination
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
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
        },
        [96104] = { -- Song of the Strider
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [96105] = { -- King of the Wild Plains
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [96107] = { -- Feathers for Fletching
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [96108] = { -- Poison Tips
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [96109] = { -- A Hunter's Quiver
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE, -- wowhead
        },
        [96126] = { -- An Ogre's Captive
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96130] = { -- Chakuyak
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {757},
        },
        [96131] = { -- An Oldstone But An Old Friend
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96139] = { -- The Valor Family
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [96145] = { -- Past Wing and Claw
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96204] = { -- The Windshaper's Wrath
            [questKeys.preQuestSingle] = {91862},
            [questKeys.nextQuestInChain] = 95034,
            [questKeys.objectives] = {{{248755,nil,Questie.ICON_TYPE_EVENT}}}, -- Escort Lumina out of Fenris Keep
            [questKeys.triggerEnd] = {"Escort Lumina Windsinger to safety", {[zoneIDs.SILVERPINE_FOREST] = {{65.7,29.7}}}},
        },
        [96209] = { -- The Ancient, Orokai
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96243] = { -- Call of Earth
            [questKeys.requiredLevel] = 4,
            [questKeys.questLevel] = 4,
            [questKeys.availableUntilCompleted] = 94373,
        },
        [96246] = { -- Blackmaw Pouches
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96252] = { -- Tarnished Treasures
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96255] = { -- Amalgamated Marrow
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96259] = { -- Defending the Dead
            [questKeys.nextQuestInChain] = 96261,
        },
        [96261] = { -- The Broodmother
            [questKeys.preQuestSingle] = {96259},
        },
        [96262] = { -- Prickly Pinecones
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96296] = { -- Fetid Corruption
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96301] = { -- Power Wash
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96302] = { -- Arch Absolution
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96303] = { -- Memory Mist
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96321] = { -- The Dying God
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96322] = { -- A Revenge Now Bitter
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96335] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96337] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96379] = { -- State Secrets
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96390] = { -- Nip 'Em in the Bud
            [questKeys.preQuestSingle] = {96392},
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
        },
        [96550] = { -- Battle Recall
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96558] = { -- Soldier's Solace
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96561] = { -- Last Wishes
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [96770] = { -- The Witch Doctor's Head
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96771] = { -- Vengeance of the Highborne
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96773] = { -- The Coldbringer's Eye
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [96796] = { -- Woods Workshop
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96930] = { -- The Capricious Corvid
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96931] = { -- Heading Up the Mountain
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96939] = { -- The Balance of Life and Death
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96957] = { -- Bone Sweet Bone
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96959] = { -- Blademaster's Bonfires
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96964] = { -- A Clever Creature
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96971] = { -- To Outfox a Demon
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96978] = { -- Violent Venison
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96979] = { -- Sacred Refreshment
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96983] = { -- Yashiro's Windwalk
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [96991] = { -- Trail Assist
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97009] = { -- Maerion's Misery
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97010] = { -- Blind Vengeance
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97029] = { -- Eluvi'ana
            [questKeys.requiredLevel] = 1,
            [questKeys.questLevel] = -1,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.preQuestSingle] = {93161},
            [questKeys.zoneOrSort] = zoneIDs.ZEPHRAS_ISLE,
        },
        [97065] = { -- Tip the Scales - Keefer's Angelfish
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97066] = { -- Tip the Scales - Brownell's Blue Striped Racer
            [questKeys.name] = "Tip the Scales - Brownell's Blue Striped Racer",
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97067] = { -- Tip the Scales - Dezian Queenfish
            [questKeys.name] = "Tip the Scales - Dezian Queenfish",
            [questKeys.finishedBy_add] = {{267806}},
            [questKeys.questLevel] = 60,
            [questKeys.requiredRaces] = raceIDs.NONE,
            [questKeys.zoneOrSort] = sortKeys.FISHING,
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [97130] = { -- Ancient Gurubashi Secrets
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [97176] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97178] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [97271] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [97286] = { -- Research Access
            [questKeys.startedBy] = {{211022,211033}},
            [questKeys.preQuestSingle] = {78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,84395,84396,84397,84398,84399,84400,84401,84402},
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
        [97327] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [97332] = { -- Twice Misplaced Trust
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
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
        [97536] = { -- Gnomish Garbage
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
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
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98013] = { -- Swelling Forces
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
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
        [98109] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98215] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98231] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98233] = { -- Sword in the Slime
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- wowhead
        },
        [98282] = { -- Alchemical Hazards
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
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
        [98298] = { -- Arugal's Folly
            [questKeys.preQuestSingle] = {99},
        },
        [98299] = { -- Stop the Spread
            [questKeys.preQuestSingle] = {99},
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
        [98341] = { -- The Great Windborne Cat Spirit
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
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
            [questKeys.disabledByQuest] = 2518,
        },
        [98392] = { -- Darkness in the Glade
            [questKeys.preQuestSingle] = {937},
            [questKeys.nextQuestInChain] = 98398,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
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
        },
        [98407] = { -- Show of Force
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
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
        },
        [98462] = { -- Shroud of the Winter Wilds
            [questKeys.name] = "Shroud of the Winter Wilds",
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [98517] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.breadcrumbForQuestId] = 97243, -- to be tested
            [questKeys.nextQuestInChain] = 97243,
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
        [98738] = { -- Blessings of the Great Windborne Cat Spirit
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
        },
        [98890] = { -- Conflict at Darkspear Islands
            [questKeys.requiredLevel] = 40,
            [questKeys.questLevel] = 49,
        },
        [98898] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [99204] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [99233] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
        },
        [99257] = { -- A Heart of Crystal
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [99258] = { -- Mana Mania
            [questKeys.requiredRaces] = raceIDs.NONE, -- wowhead
        },
        [99260] = { -- Fillion's Mission
            [questKeys.preQuestSingle] = {92850},
            [questKeys.nextQuestInChain] = 92840,
        },
        [99267] = { -- An Unfortunate End
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.zoneOrSort] = zoneIDs.DUSKWOOD,
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
        [99435] = {
            [questKeys.requiredRaces] = raceIDs.NONE, -- unverified
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
        [97286] = { -- Research Access
            [questKeys.startedBy] = {{211022}},
            [questKeys.finishedBy] = {{211022}},
        },
    }

    local questFixesAlliance = {
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
