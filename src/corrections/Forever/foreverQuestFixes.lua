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
        [92460] = { -- Coming of Age
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            --[questKeys.reputationReward] = {{factionIDs.WINDSHAPERS,25}}, for factionFixes
        },
        [92461] = { -- Harmony in Balance
            [questKeys.preQuestSingle] = {92460},
        },
        [92462] = { -- Infestation Investigation
            [questKeys.requiredLevel] = 1,
            [questKeys.preQuestSingle] = {92460},
        },
        [92463] = { -- The Cirrusfly Queen
            [questKeys.requiredLevel] = 2,
            [questKeys.preQuestSingle] = {92462},
        },
        [92464] = { -- Elemental Unrest
            [questKeys.requiredLevel] = 2,
            [questKeys.availableUntilCompleted] = 92465,
        },
        [92465] = { -- Agitators
            [questKeys.requiredLevel] = 2,
            [questKeys.objectives] = {{{251160},{251143}}},
            [questKeys.nextQuestInChain] = 92469,
        },
        [92466] = { -- Call of Earth
            [questKeys.requiredLevel] = 3,
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.nextQuestInChain] = 92467,
        },
        [92467] = { -- Call of Earth
            [questKeys.requiredLevel] = 3,
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {92466},
            [questKeys.nextQuestInChain] = 92468,
        },
        [92468] = { -- Call of Earth
            [questKeys.requiredLevel] = 3,
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {92467},
        },
        [92469] = { -- Return to Rorian
            [questKeys.requiredLevel] = 3,
            [questKeys.preQuestSingle] = {92465},
        },
        [92470] = { -- Foul Matriarch
            [questKeys.requiredLevel] = 2,
            [questKeys.preQuestSingle] = {92471},
        },
        [92471] = { -- Aetheen of the Gales
            --[questKeys.requiredLevel] = 4,
        },
        [92472] = { -- The Next Step
            [questKeys.requiredLevel] = 3,
            [questKeys.preQuestSingle] = {92470},
        },
        [92473] = { -- Aggressive Encroachment
            [questKeys.requiredLevel] = 3,
            [questKeys.preQuestSingle] = {92471},
        },
        [92474] = { -- Falling With Style
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE + raceIDs.SKYBORNE_HORDE,
            [questKeys.objectives] = {},
            [questKeys.triggerEnd] = {"Use Walk on Air", {[zoneIDs.ZEPHRAS_ISLE] = {{43.67,24.14}}}},
        },
        [92481] = { -- A Student of the Arcane
            [questKeys.requiredClasses] = classIDs.MAGE,
            [questKeys.preQuestSingle] = {92461},
        },
        [92482] = { -- The Way of the Hunter
            [questKeys.requiredClasses] = classIDs.HUNTER,
            [questKeys.preQuestSingle] = {92461},
        },
        [92483] = { -- At Home in the Shadows
            [questKeys.requiredClasses] = classIDs.ROGUE,
            [questKeys.preQuestSingle] = {92461},
        },
        [92484] = { -- Embracing the Elements
            [questKeys.requiredClasses] = classIDs.SHAMAN,
            [questKeys.preQuestSingle] = {92461},
        },
        [92485] = { -- A Student of Nature
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.preQuestSingle] = {92461},
        },
        [92514] = { -- Welcome to Shen'dar Village
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [92515] = { -- The Problem With Prideclaws
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92516] = { -- Hippogryph Harrassment
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92517] = { -- The Criminal Element
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
            [questKeys.nextQuestInChain] = 93036,
        },
        [92528] = { -- Among the Faithful
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92529},
        },
        [92529] = { -- Falaath Village
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {93036},
            [questKeys.nextQuestInChain] = 92528,
        },
        [92532] = { -- The Warrior's Path
            [questKeys.requiredClasses] = classIDs.WARRIOR,
            [questKeys.preQuestSingle] = {92461},
        },
        [92544] = { -- Al'Aketh Thugs
            [questKeys.requiredLevel] = 2,
            [questKeys.objectives] = {{{251145},{251448},{256935}}},
        },
        [92550] = { -- Havoc in the Highlands
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92528},
        },
        [92551] = { -- Stolen Supplies
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92528},
        },
        [92553] = { -- Restocking the Larders
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [92579] = { -- To Valanaar
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92550},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 92700,
        },
        [92595] = { -- The Windshapers
            [questKeys.requiredLevel] = 4,
            [questKeys.nextQuestInChain] = 94411,
            [questKeys.availableStartingWith] = 92514, -- available even after abandoning 92514, but this is next best thing
        },
        [92596] = { -- The High Order
            [questKeys.requiredLevel] = 4,
            [questKeys.nextQuestInChain] = 94413,
            [questKeys.availableStartingWith] = 93461, -- available even after abandoning 93461, but this is next best thing
        },
        [92597] = { -- Reading the Ley Lines
            [questKeys.requiredLevel] = 2,
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_ALLIANCE,
            [questKeys.objectives] = {nil,{{450002}}},
        },
        [92598] = { -- The Gift of Skysight
            [questKeys.requiredLevel] = 2,
            [questKeys.requiredRaces] = raceIDs.SKYBORNE_HORDE,
            [questKeys.objectives] = {nil,{{450001}}},
        },
        [92640] = { -- Desperate Times
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {94568},
            [questKeys.nextQuestInChain] = 93065,
        },
        [92642] = { -- Disrupting Logistics
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {93320},
        },
        [92643] = { -- The Turncoat
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92881},
            [questKeys.nextQuestInChain] = 92644,
        },
        [92644] = { -- Unfortunate News
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92643},
            [questKeys.nextQuestInChain] = 94568,
        },
        [92645] = { -- Breaking the Breaker
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {93320},
        },
        [92646] = { -- Confront Lorthuna
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {93958},
            [questKeys.nextQuestInChain] = 93836,
        },
        [92679] = { -- Blood Tithe
            [questKeys.requiredLevel] = 5,
        },
        [92682] = { -- Make Yourself Useful
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92679},
        },
        [92683] = { -- Flutterfly Dust
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92679},
        },
        [92684] = { -- Ornery Ornery Galestriders
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92679},
        },
        [92685] = { -- The Hills Have Eyes
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestGroup] = {92683,92684}, -- most likely also 92682
            [questKeys.nextQuestInChain] = 92693,
        },
        [92693] = { -- Standing Our Ground
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92685},
            [questKeys.nextQuestInChain] = 92703,
        },
        [92698] = { -- What Is My Purpose?
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92679},
        },
        [92699] = { -- The Supreme Magister
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92701},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92700] = { -- The Grand Skyseer
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92579},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [92701] = { -- To Valanaar
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92550},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92699,
        },
        [92703] = { -- Deliver the News
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92693},
        },
        [92708] = { -- A Grand Adventure
            [questKeys.requiredLevel] = 7,
            [questKeys.preQuestSingle] = {92700},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [92709] = { -- A Grand Adventure
            [questKeys.requiredLevel] = 7,
            [questKeys.preQuestSingle] = {92699},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92727] = { -- The Missing Scholar
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92699},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92849,
        },
        [92741] = { -- Unwelcome Visitors
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {92699},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92834] = { -- Avenged Tenfold
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92840},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92840] = { -- Catching Wind
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {99260},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [92849] = { -- The Missing Scholar
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92727},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92850,
        },
        [92850] = { -- The Missing Scholar
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92849},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 99260,
        },
        [92860] = { -- In Service of Zephras
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92840},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 93320,
        },
        [92871] = { -- In Service of Zephras
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {93746},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 93320,
        },
        [92880] = { -- Return to Valanaar
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestGroup] = {92642,92645},
            [questKeys.nextQuestInChain] = 92881,
        },
        [92881] = { -- The High Elder's Request
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92880},
            [questKeys.nextQuestInChain] = 92643,
        },
        [92947] = { -- Making Our Move
            [questKeys.requiredLevel] = 7,
            [questKeys.preQuestSingle] = {93065},
            [questKeys.nextQuestInChain] = 93958,
        },
        [93036] = { -- Infiltrating the Cult
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92517},
            [questKeys.nextQuestInChain] = 92529,
        },
        [93065] = { -- Prepare for Battle
            [questKeys.requiredLevel] = 7,
            [questKeys.preQuestSingle] = {92640},
            [questKeys.nextQuestInChain] = 92947,
        },
        [93089] = { -- What Comes Next
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {94369},
            [questKeys.nextQuestInChain] = 94946,
        },
        [93090] = { -- What Comes Next
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {93836},
            [questKeys.nextQuestInChain] = 95349,
        },
        [93159] = { -- The Strange Hermit
            [questKeys.requiredLevel] = 8,
        },
        [93160] = { -- The Forest's Bounty
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {93159},
        },
        [93165] = { -- Mercy Falls on Deaf Ears
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {94484},
            [questKeys.nextQuestInChain] = 93459,
        },
        [93172] = { -- Free the Hollows
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {93159},
        },
        [93317] = { -- Crab Season
            [questKeys.requiredLevel] = 4,
        },
        [93318] = { -- WANTED: Vulgara the Insatiable
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93319] = { -- Pilfered Windstones
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93320] = { -- Tower Defense
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92860,92871},
        },
        [93459] = { -- More Al'Aketh Ears
            [questKeys.questLevel] = 13,
            [questKeys.requiredLevel] = 8,
            [questKeys.zoneOrSort] = 16593,
            [questKeys.preQuestSingle] = {93165},
            [questKeys.specialFlags] = specialFlags.REPEATABLE,
        },
        [93461] = { -- Welcome to Shen'dar Village
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
        },
        [93552] = { -- Harvesting Windstones
            [questKeys.requiredLevel] = 2,
            [questKeys.preQuestSingle] = {92461},
        },
        [93735] = { -- The Broken Construct
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92700},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 93737,
        },
        [93736] = { -- Unwelcome Spirits
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92700},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [93737] = { -- The Broken Construct
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {93735},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 93738,
        },
        [93738] = { -- The Broken Construct
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {93737},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.nextQuestInChain] = 93746,
        },
        [93740] = { -- Blood for Blood
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {93746},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [93746] = { -- A Firm Response
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {93738},
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
        },
        [93791] = { -- Speak with Belann
            --[questKeys.requiredLevel] = 10,
            [questKeys.requiredClasses] = classIDs.MAGE,
        },
        [93797] = { -- Boughs in the Wind
            --[questKeys.requiredLevel] = 10,
            [questKeys.requiredClasses] = classIDs.MAGE,
        },
        [93835] = { -- Confront Lorthuna
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {93958},
            [questKeys.nextQuestInChain] = 94369,
        },
        [93836] = { -- The Fate of Zephras
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {92646},
            [questKeys.nextQuestInChain] = 93090,
        },
        [93926] = { -- The Western Watch
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92528},
            [questKeys.nextQuestInChain] = 93927,
        },
        [93927] = { -- A Last Request
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {93926},
        },
        [93948] = { -- Deliver the Signet
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92550},
            [questKeys.nextQuestInChain] = 93949,
        },
        [93949] = { -- Bugged
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {93948},
        },
        [93951] = { -- A Little Beauty
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92514,93461},
        },
        [93958] = { -- The Inner Sanctum
            [questKeys.requiredLevel] = 7,
            [questKeys.preQuestSingle] = {92947},
        },
        [94003] = { -- The Skybreaker Bulwark
            --[questKeys.requiredLevel] = 10,
            [questKeys.requiredClasses] = classIDs.WARRIOR,
        },
        [94006] = { -- The Great Ursera Spirit
            --[questKeys.requiredLevel] = 10,
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.nextQuestInChain] = 94638,
        },
        [94007] = { -- Taming the Beast
            [questKeys.name] = "Taming the Beast",
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94013] = { -- Taming the Beast
            [questKeys.name] = "Taming the Beast",
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94050] = { -- Training the Beast
            [questKeys.name] = "Training the Beast",
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94369] = { -- The Fate of Zephras
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {93835},
            [questKeys.nextQuestInChain] = 93089,
        },
        [94411] = { -- Meddlesome Mages
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92595},
        },
        [94413] = { -- A Magical Affront
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92596},
        },
        [94414] = { -- The Anchors of Zephras
            [questKeys.objectives] = {{{257554,nil,Questie.ICON_TYPE_TALK}}},
        },
        [94484] = { -- Unnerving Silence
            [questKeys.requiredLevel] = 8,
        },
        [94485] = { -- Tears of the Lady
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {94484},
        },
        [94486] = { -- Feathers for Binding
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {94484},
        },
        [94487] = { -- Unwanted and Unworthy
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {94484},
        },
        [94488] = { -- The Ties That Bind
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestGroup] = {94486,94487}, -- check if also needed 94485
        },
        [94489] = { -- The Wounds of Betrayal
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestGroup] = {94486,94487}, -- check if also needed 94485
        },
        [94490] = { -- Ripped Missive
            [questKeys.requiredLevel] = 9,
            [questKeys.preQuestGroup] = {94486,94487}, -- check if also needed 94485
            [questKeys.nextQuestInChain] = 94491,
        },
        [94491] = { -- The Fate of the Den
            [questKeys.requiredLevel] = 8,
            [questKeys.preQuestSingle] = {94490},
        },
        [94493] = { -- A Sacrifice in Vain
            [questKeys.name] = "A Sacrifice in Vain",
            [questKeys.questLevel] = 11,
            [questKeys.requiredLevel] = 8,
        },
        [94568] = { -- The Cult's True Plans
            [questKeys.requiredLevel] = 6,
            [questKeys.preQuestSingle] = {92644},
            [questKeys.nextQuestInChain] = 92640,
        },
        [94638] = { -- Strength and Mercy
            [questKeys.requiredClasses] = classIDs.DRUID,
            [questKeys.preQuestSingle] = {94006},
        },
        [94896] = { -- Aid For The Refugees
            [questKeys.requiredLevel] = 8,
        },
        [94897] = { -- The Fate of a Loved One
            [questKeys.requiredLevel] = 8,
        },
        [94946] = { -- The Magical City of Dalaran
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {93089},
        },
        [94978] = { -- Taming the Beast
            [questKeys.name] = "Taming the Beast",
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [94979] = { -- Taming the Beast
            [questKeys.name] = "Taming the Beast",
            [questKeys.requiredClasses] = classIDs.HUNTER,
        },
        [95349] = { -- The Earthen Ring
            [questKeys.requiredLevel] = 7,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {93090},
        },
        [96101] = { -- The Great Outdoors
            [questKeys.requiredLevel] = 4,
            [questKeys.breadcrumbs] = {96638},
        },
        [96638] = { -- The Adventurer
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {92470},
            [questKeys.breadcrumbForQuestId] = 96101,
            [questKeys.nextQuestInChain] = 96101,
        },
        [96646] = { -- Camping 101: Cooking
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97243] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [97244] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [97245] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [97257] = { -- Call of Fire
            [questKeys.requiredClasses] = classIDs.SHAMAN,
        },
        [97963] = { -- Camping 101: Alchemy
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97964] = { -- Camping 101: Blacksmithing
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97965] = { -- Camping 101: First Aid
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97967] = { -- Camping 101: Fishing
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97968] = { -- Camping 101: Herbalism
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97969] = { -- Camping 101: Leatherworking
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97970] = { -- Camping 101: Mining
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97971] = { -- Camping 101: Skinning
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [97972] = { -- Camping 101: Tailoring
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {96101},
        },
        [97973] = { -- Camping 101: Tailoring
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {96101},
        },
        [98284] = { -- Camping 101: Enchanting
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_HORDE,
            [questKeys.preQuestSingle] = {96101},
        },
        [98285] = { -- Camping 101: Engineering
            [questKeys.requiredLevel] = 4,
            [questKeys.preQuestSingle] = {96101},
        },
        [98286] = { -- Camping 101: Enchanting
            [questKeys.requiredLevel] = 4,
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.preQuestSingle] = {96101},
        },
        [98512] = { -- Al'Aketh Assassins
            [questKeys.requiredLevel] = 6,
        },
        [99260] = { -- Fillion's Mission
            [questKeys.requiredLevel] = 5,
            [questKeys.preQuestSingle] = {92850},
            [questKeys.requiredRaces] = raceIDs.ALL_ALLIANCE,
            [questKeys.nextQuestInChain] = 92840,
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
