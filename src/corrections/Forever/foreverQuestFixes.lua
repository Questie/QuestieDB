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
QuestieCorrections.itemObjectiveFirst[93739] = true
QuestieCorrections.itemObjectiveFirst[93963] = true
QuestieCorrections.killCreditObjectiveFirst[94489] = true

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
        [940] = { -- Teldrassil
            [questKeys.startedBy_add] = {nil,{673378}},
        },
        [982] = { -- Deep Ocean, Vast Sea
            [questKeys.breadcrumbs_add] = {97894},
        },
        [1516] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1516,1519,92466},
            [questKeys.exclusiveTo] = {1519,92466},
        },
        [1519] = { -- Call of Earth
            [questKeys.preQuestSingle] = {1516,1519,92466},
            [questKeys.exclusiveTo] = {1516,92466},
        },
        [6126] = { -- Lessons Anew
            [questKeys.startedBy_add] = {{262560}},
        },
        [78124] = { -- Nar'thalas Almanac
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78127] = { -- The Dalaran Digest
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78142] = { -- Bewitchments and Glamours
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78143] = { -- Secrets of the Dreamers
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78145] = { -- Arcanic Systems Manual
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78149] = { -- Fury of the Land
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [78261] = { -- The Horn of Xelthos
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [79091] = { -- Archmage Antonidas: The Unabridged Autobiography
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [79093] = { -- Rumi of Gnomeregan: The Collected Works
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [79094] = { -- The Lessons of Ta'zo
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [79097] = { -- Baxtan: On Destructive Magics
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [79948] = { -- Defensive Magics 101
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [81953] = { -- Stonewrought Design
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [81954] = { -- Venomous Journeys
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [81955] = { -- A Mind of Metal
            [questKeys.requiredRaces] = raceIDs.NONE,
        },
        [92461] = { -- Harmony in Balance
            [questKeys.preQuestSingle] = {92460},
        },
        [92462] = { -- Infestation Investigation
            [questKeys.preQuestSingle] = {92460},
        },
        [92463] = { -- The Cirrusfly Queen
            [questKeys.preQuestSingle] = {92462},
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
        },
        [92473] = { -- Aggressive Encroachment
            [questKeys.preQuestSingle] = {92471},
        },
        [92474] = { -- Falling With Style
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Use Walk on Air", {[zoneIDs.ZEPHRAS_ISLE] = {{43.67,24.14}}}},
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
        [92514] = { -- Welcome to Shen'dar Village
            [questKeys.objectives] = {{{251902,nil,Questie.ICON_TYPE_TALK},{254089,nil,Questie.ICON_TYPE_TALK}}},
        },
        [92515] = { -- The Problem With Prideclaws
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92516] = { -- Hippogryph Harrassment
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92517] = { -- The Criminal Element
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.nextQuestInChain] = 93036,
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
        [92550] = { -- Havoc in the Highlands
            [questKeys.preQuestSingle] = {92528},
        },
        [92551] = { -- Stolen Supplies
            [questKeys.preQuestSingle] = {92528},
        },
        [92553] = { -- Restocking the Larders
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92579] = { -- To Valanaar
            [questKeys.preQuestGroup] = {92550,93927}, -- 92551 not needed
            [questKeys.nextQuestInChain] = 92700,
        },
        [92595] = { -- The Windshapers
            [questKeys.nextQuestInChain] = 94411,
            [questKeys.availableStartingWith] = 92514, -- available even after abandoning 92514, but this is next best thing
            [questKeys.objectives] = {{{251902,nil,Questie.ICON_TYPE_TALK}}},
        },
        [92596] = { -- The High Order
            [questKeys.nextQuestInChain] = 94413,
            [questKeys.availableStartingWith] = 93461, -- available even after abandoning 93461, but this is next best thing
            [questKeys.objectives] = {{{251903,nil,Questie.ICON_TYPE_TALK}}},
        },
        [92597] = { -- Reading the Ley Lines
            [questKeys.preQuestSingle] = {92461},
            [questKeys.objectives] = {nil,{{450002}}},
        },
        [92598] = { -- The Gift of Skysight
            [questKeys.objectives] = {nil,{{450001}}},
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
        },
        [92683] = { -- Flutterfly Dust
            [questKeys.preQuestSingle] = {92679},
            [questKeys.extraObjectives] = {{nil,Questie.ICON_TYPE_INTERACT,l10n("Use the Flutterfly Swatter"),0,{{"monster",251622}}}},
        },
        [92684] = { -- Ornery Ornery Galestriders
            [questKeys.preQuestSingle] = {92679},
        },
        [92685] = { -- The Hills Have Eyes
            [questKeys.preQuestGroup] = {92682,92683,92684},
            [questKeys.nextQuestInChain] = 92693,
        },
        [92693] = { -- Standing Our Ground
            [questKeys.preQuestSingle] = {92685},
            [questKeys.nextQuestInChain] = 92703,
            [questKeys.objectives] = {{{252800,nil,Questie.ICON_TYPE_TALK},{252863,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [92698] = { -- What Is My Purpose?
            [questKeys.preQuestSingle] = {92679},
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
        [92708] = { -- A Grand Adventure
            [questKeys.preQuestSingle] = {92700},
            [questKeys.objectives] = {{{251968,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [92709] = { -- A Grand Adventure
            [questKeys.preQuestSingle] = {92699},
        },
        [92727] = { -- The Missing Scholar
            [questKeys.preQuestSingle] = {92699},
            [questKeys.nextQuestInChain] = 92849,
        },
        [92741] = { -- Unwelcome Visitors
            [questKeys.preQuestSingle] = {92699},
        },
        [92834] = { -- Avenged Tenfold
            [questKeys.preQuestSingle] = {92840},
        },
        [92840] = { -- Catching Wind
            [questKeys.preQuestSingle] = {99260},
        },
        [92849] = { -- The Missing Scholar
            [questKeys.preQuestSingle] = {92727},
            [questKeys.nextQuestInChain] = 92850,
        },
        [92850] = { -- The Missing Scholar
            [questKeys.preQuestSingle] = {92849},
            [questKeys.nextQuestInChain] = 99260,
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
        },
        [92881] = { -- The High Elder's Request
            [questKeys.preQuestSingle] = {92880},
            [questKeys.nextQuestInChain] = 92643,
        },
        [92947] = { -- Making Our Move
            [questKeys.preQuestSingle] = {93065},
            [questKeys.nextQuestInChain] = 93958,
            [questKeys.objectives] = {{{252762},{252763},{252765},{253576,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [93036] = { -- Infiltrating the Cult
            [questKeys.preQuestSingle] = {92517},
            [questKeys.nextQuestInChain] = 92529,
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
        [93159] = { -- The Strange Hermit
            [questKeys.objectives] = {{{251684,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93160] = { -- The Forest's Bounty
            [questKeys.preQuestSingle] = {93159},
        },
        [93165] = { -- Mercy Falls on Deaf Ears
            [questKeys.preQuestSingle] = {94484,94493},
            [questKeys.nextQuestInChain] = 93459,
        },
        [93172] = { -- Free the Hollows
            [questKeys.preQuestSingle] = {93159},
            [questKeys.objectives] = {{{251676}}},
        },
        [93318] = { -- WANTED: Vulgara the Insatiable
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93319] = { -- Pilfered Windstones
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93320] = { -- Tower Defense
            [questKeys.preQuestSingle] = {92860,92871},
        },
        [93459] = { -- More Al'Aketh Ears
            [questKeys.preQuestSingle] = {93165},
            [questKeys.objectivesText] = {}, -- turn in only quest, no objectivesText for these
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [93461] = { -- Welcome to Shen'dar Village
        },
        [93552] = { -- Harvesting Windstones
            [questKeys.preQuestSingle] = {92461},
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
            [questKeys.objectives] = {{{10540,nil,Questie.ICON_TYPE_TALK},{3057,nil,Questie.ICON_TYPE_TALK},{10181,nil,Questie.ICON_TYPE_TALK}},nil,{{285357,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93740] = { -- Blood for Blood
            [questKeys.preQuestSingle] = {93746},
        },
        [93746] = { -- A Firm Response
            [questKeys.preQuestSingle] = {93738},
            [questKeys.objectives] = {{{256247,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93791] = { -- Speak with Belann
            [questKeys.nextQuestInChain] = 93797,
        },
        [93797] = { -- Boughs in the Wind
            [questKeys.preQuestSingle] = {93791},
        },
        [93835] = { -- Confront Lorthuna
            [questKeys.preQuestSingle] = {93958},
            [questKeys.nextQuestInChain] = 94369,
        },
        [93836] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {92646},
            [questKeys.nextQuestInChain] = 93090,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [93926] = { -- The Western Watch
            [questKeys.preQuestSingle] = {92528},
            [questKeys.nextQuestInChain] = 93927,
            [questKeys.objectives] = {{{252155,nil,Questie.ICON_TYPE_INTERACT}}},
        },
        [93927] = { -- A Last Request
            [questKeys.preQuestSingle] = {93926},
            [questKeys.objectives] = {{{256966}},nil,{{254871},{263415},{263418}}}, -- double whammy
        },
        [93948] = { -- Deliver the Signet
            [questKeys.preQuestGroup] = {92550,93927}, -- 92551 not needed
            [questKeys.nextQuestInChain] = 93949,
        },
        [93949] = { -- Bugged
            [questKeys.preQuestSingle] = {93948},
            [questKeys.objectives] = {{{251727}}},
        },
        [93951] = { -- A Little Beauty
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93958] = { -- The Inner Sanctum
            [questKeys.preQuestSingle] = {92947},
        },
        [93963] = { -- Exploring the Alliance
            [questKeys.preQuestSingle] = {94947},
            [questKeys.objectives] = {{{7937,nil,Questie.ICON_TYPE_TALK},{2784,nil,Questie.ICON_TYPE_TALK},{7999,nil,Questie.ICON_TYPE_TALK}},nil,{{285356,nil,Questie.ICON_TYPE_TALK}}},
            [questKeys.reputationReward] = {{factionIDs.ALLIANCE, 100}, {factionIDs.GNOMEREGAN_EXILES, 175}, {factionIDs.STORMWIND, 175}, {factionIDs.DARNASSUS, 175}, {factionIDs.IRONFORGE, 175}, {factionIDs.KIRIN_TOR_FOREVER, 100}},
        },
        [94003] = { -- The Skybreaker Bulwark
            [questKeys.requiredClasses] = classIDs.WARRIOR,
        },
        [94006] = { -- The Great Ursera Spirit
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.nextQuestInChain] = 94638,
        },
        [94007] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94013] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94050] = { -- Training the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94369] = { -- The Fate of Zephras
            [questKeys.preQuestSingle] = {93835},
            [questKeys.nextQuestInChain] = 93089,
        },
        [94411] = { -- Meddlesome Mages
            [questKeys.preQuestSingle] = {92595},
            [questKeys.objectives] = {{{257521}}},
        },
        [94413] = { -- A Magical Affront
            [questKeys.preQuestSingle] = {92596},
            [questKeys.objectives] = {{{257532}}},
        },
        [94414] = { -- The Anchors of Zephras
            [questKeys.objectives] = {{{257554,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94484] = { -- Unnerving Silence
            [questKeys.exclusiveTo] = {94493},
        },
        [94485] = { -- Tears of the Lady
            [questKeys.preQuestSingle] = {94484,94493},
        },
        [94486] = { -- Feathers for Binding
            [questKeys.preQuestSingle] = {94484,94493},
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
        [94568] = { -- The Cult's True Plans
            [questKeys.preQuestSingle] = {92644},
            [questKeys.nextQuestInChain] = 92640,
            [questKeys.objectives] = {{{252476,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94638] = { -- Strength and Mercy
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.preQuestSingle] = {94006},
        },
        [94911] = { -- Child of Nature
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94912] = { -- Child of Nature
            [questKeys.requiredClasses] = classIDs.DRUID,
        },
        [94946] = { -- The Magical City of Dalaran
            [questKeys.preQuestSingle] = {93089},
            [questKeys.nextQuestInChain] = 94947,
        },
        [94947] = { -- Welcome to Azeroth
            [questKeys.preQuestSingle] = {94946},
            [questKeys.nextQuestInChain] = 93963,
        },
        [94978] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94979] = { -- Taming the Beast
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [95349] = { -- The Earthen Ring
            [questKeys.preQuestSingle] = {93090},
            [questKeys.nextQuestInChain] = 95350,
        },
        [95350] = { -- Welcome to Azeroth
            [questKeys.preQuestSingle] = {95349},
            [questKeys.nextQuestInChain] = 93739,
        },
        [95998] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96627},
            [questKeys.objectives] = {nil,{{450003},{450003}}},
            [questKeys.exclusiveTo] = {96101,96604,96605,96606,96607,96608},
        },
        [96101] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96638},
            [questKeys.objectives] = {nil,{{450004},{450004}}},
            [questKeys.exclusiveTo] = {95998,96604,96605,96606,96607,96608},
        },
        [96395] = { -- An Ancient Grudge
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE, -- not sure if horde can get this quest
        },
        [96604] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96652},
            [questKeys.objectives] = {nil,{{450005},{450005}}},
            [questKeys.exclusiveTo] = {95998,96101,96605,96606,96607,96608},
        },
        [96605] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96659},
            [questKeys.objectives] = {nil,{{450006},{450006}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96606,96607,96608},
        },
        [96606] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96630},
            [questKeys.objectives] = {nil,{{450007},{450007}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96607,96608},
        },
        [96607] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96656},
            [questKeys.objectives] = {nil,{{450008},{450008}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96606,96608},
        },
        [96608] = { -- The Great Outdoors
            [questKeys.breadcrumbs] = {96628},
            [questKeys.objectives] = {nil,{{450009},{450009}}},
            [questKeys.exclusiveTo] = {95998,96101,96604,96605,96606,96607},
        },
        [96627] = { -- The Adventurer
            -- [questKeys.preQuestSingle] = {92470}, -- TBD
            [questKeys.breadcrumbForQuestId] = 95998,
            [questKeys.nextQuestInChain] = 95998,
            [questKeys.exclusiveTo] = {96628,96630,96638,96652,96656,96659},
        },
        [96628] = { -- The Adventurer
            -- [questKeys.preQuestSingle] = {92470}, -- TBD
            [questKeys.breadcrumbForQuestId] = 96608,
            [questKeys.nextQuestInChain] = 96608,
            [questKeys.exclusiveTo] = {96627,96630,96638,96652,96656,96659},
        },
        [96630] = { -- The Adventurer
            [questKeys.preQuestSingle] = {921},
            [questKeys.breadcrumbForQuestId] = 96606,
            [questKeys.nextQuestInChain] = 96606,
            [questKeys.exclusiveTo] = {96627,96628,96638,96652,96656,96659},
        },
        [96638] = { -- The Adventurer
            [questKeys.preQuestSingle] = {92470},
            [questKeys.breadcrumbForQuestId] = 96101,
            [questKeys.nextQuestInChain] = 96101,
            [questKeys.exclusiveTo] = {96627,96628,96630,96652,96656,96659},
        },
        [96646] = { -- Camping 101: Cooking
            [questKeys.preQuestSingle] = {96101},
            [questKeys.objectives] = {{{251905,nil,Questie.ICON_TYPE_TALK}}},
        },
        [96652] = { -- The Adventurer
            [questKeys.preQuestSingle] = {794},
            [questKeys.breadcrumbForQuestId] = 96604,
            [questKeys.nextQuestInChain] = 96604,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96656,96659},
        },
        [96656] = { -- The Adventurer
            -- [questKeys.preQuestSingle] = {92470}, -- TBD
            [questKeys.breadcrumbForQuestId] = 96607,
            [questKeys.nextQuestInChain] = 96607,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96652,96659},
        },
        [96659] = { -- The Adventurer
            -- [questKeys.preQuestSingle] = {92470}, -- TBD
            [questKeys.breadcrumbForQuestId] = 96605,
            [questKeys.nextQuestInChain] = 96605,
            [questKeys.exclusiveTo] = {96627,96628,96630,96638,96652,96656},
        },
        [97243] = { -- Call of Fire
            [questKeys.startedBy_add] = {{254082}},
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.nextQuestInChain] = 97244,
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
        [97257] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {97245},
            [questKeys.objectives] = {{{268762,nil,Questie.ICON_TYPE_EVENT},{268679,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97894] = { -- Business in Auberdine
            [questKeys.breadcrumbForQuestId] = 982,
            [questKeys.nextQuestInChain] = 982,
        },
        [97963] = { -- Camping 101: Alchemy
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.ALCHEMY, 1},
            [questKeys.requiredSpell] = -1230564, -- Mana Well
            [questKeys.objectives] = {{{257019,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97964] = { -- Camping 101: Blacksmithing
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.BLACKSMITHING, 1},
            [questKeys.requiredSpell] = -1230171, -- Sharpening Wheel
            [questKeys.objectives] = {{{251913,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97965] = { -- Camping 101: First Aid
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.FIRST_AID, 1},
            [questKeys.requiredSpell] = -1230117, -- First Aid Kit
            [questKeys.objectives] = {{{257018,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97967] = { -- Camping 101: Fishing
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.FISHING, 1},
            [questKeys.requiredSpell] = -1229745, -- Fish Bowl
            [questKeys.objectives] = {{{251992,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97968] = { -- Camping 101: Herbalism
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.HERBALISM, 1},
            [questKeys.requiredSpell] = -1229705, -- Incense Candle
            [questKeys.objectives] = {{{254345,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97969] = { -- Camping 101: Leatherworking
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.LEATHERWORKING, 1},
            [questKeys.requiredSpell] = -1229432, -- Camp Tent
            [questKeys.objectives] = {{{251993,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97970] = { -- Camping 101: Mining
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.MINING, 1},
            [questKeys.requiredSpell] = -1230161, -- Lodestone
            [questKeys.objectives] = {{{257022,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97971] = { -- Camping 101: Skinning
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.SKINNING, 1},
            [questKeys.requiredSpell] = -1229517, -- Camp Chair
            [questKeys.objectives] = {{{257024,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97972] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1229504, -- Faction Banner
            [questKeys.objectives] = {{{251991,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [97973] = { -- Camping 101: Tailoring
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.TAILORING, 1},
            [questKeys.requiredSpell] = -1263425, -- Faction Banner
            [questKeys.objectives] = {{{251991,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [98024] = { -- Journey to the Crossroads
            [questKeys.preQuestSingle] = {95350},
        },
        [98284] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{257020,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [98285] = { -- Camping 101: Engineering
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.ENGINEERING, 1},
            [questKeys.requiredSpell] = -1230656, -- Reagent Bot
            [questKeys.objectives] = {{{251684,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [98286] = { -- Camping 101: Enchanting
            [questKeys.preQuestSingle] = {96101},
            [questKeys.requiredSkill] = {profKeys.ENCHANTING, 1},
            [questKeys.requiredSpell] = -1230643, -- Enchanted Lute
            [questKeys.objectives] = {{{257020,nil,Questie.ICON_TYPE_EVENT}}},
        },
        [98372] = { -- An Unfortunate End
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [98430] = { -- The Longwalkers
            [questKeys.triggerEnd] = {"Escort Perith Stormhoof out of Palemane Rock", {[zoneIDs.MULGORE] = {{37.19,64.62}}}},
        },
        [99260] = { -- Fillion's Mission
            [questKeys.preQuestSingle] = {92850},
            [questKeys.nextQuestInChain] = 92840,
        },
        [99267] = { -- An Unfortunate End
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [99411] = { -- Kyle's Gone Missing!
            [questKeys.name] = "Kyle's Gone Missing!",
            [questKeys.startedBy] = {{277182}},
            [questKeys.finishedBy] = {{277182}},
            [questKeys.requiredLevel] = 7,
            [questKeys.questLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.requiredClasses] = raceIDs.NONE,
            [questKeys.objectivesText] = {"Ahab Wheathoof at Bloodhoof Village in Mulgore wants you to feed his prized puppy, Kyle the Frenzied.","","Feed Kyle Tender Strider Meat and return to Ahab Wheathoof."},
            [questKeys.objectives] = {{{277154,nil,Questie.ICON_TYPE_INTERACT}}},
            [questKeys.zoneOrSort] = zoneIDs.MULGORE,
            [questKeys.requiredSourceItems] = {287505},
            [questKeys.questFlags] = 8,
            [questKeys.reputationReward] = {{factionIDs.THUNDER_BLUFF, 100}},
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
        -- [questId] = { [questKeys.name] = "Character-specific name" },
    }
end
