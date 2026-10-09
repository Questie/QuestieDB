---@class ForeverNpcFixes
local ForeverNpcFixes = QuestieLoader:CreateModule("ForeverNpcFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
---@type Phasing
local Phasing = QuestieLoader:ImportModule("Phasing")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverNpcFixes:Load()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
    local npcFlags = QuestieDB.npcFlags
    local waypointPresets = QuestieDB.waypointPresets
    local phases = Phasing.phases

    return {
        [2155] = { -- Sentinel Shayla Nightbreeze
            [npcKeys.questEnds_add] = {490},
            [npcKeys.questStarts_add] = {490},
        },
        [2756] = { -- Grund Drokda
            [npcKeys.name] = "Grund Drokda",
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.67,67.52}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [4949] = { -- Thrall
            [npcKeys.questEnds_add] = {93739},
        },
        [5891] = { -- Minor Manifestation of Earth
            [npcKeys.spawns_add] = {[zoneIDs.DUN_MOROGH] = {{24.84,61.86}}},
        },
        [10993] = { -- Twizwick Sprocketgrind
            [npcKeys.questEnds_add] = {97930},
            [npcKeys.questStarts_add] = {97930},
        },
        [11051] = { -- Vhan
            [npcKeys.questEnds_add] = {97937},
        },
        [14242] = { -- Sulhasa
            [npcKeys.name] = "Sulhasa",
        },
        [247226] = { -- Kelsey Fargo
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{47.18,32.16}}},
        },
        [247229] = { -- Daniel
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{49.48,40.67}}},
        },
        [248242] = { -- Hamish Bergwort
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{65.1,69.84}}},
        },
        [248248] = { -- Blixie Fitzwink
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{63.2,72.6}}},
        },
        [248265] = { -- Ormin Pelford
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{76.54,71.92}}},
        },
        [248266] = { -- Hagar Lowe
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{82.47,63.83}}},
        },
        [248277] = { -- Merell Ross
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{84.75,79.3}}},
        },
        [248362] = { -- Shinyfinder Narf
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{49.22,28.01}}},
        },
        [248415] = { -- Tordrin Sternblade
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{51.21,40.8}}},
        },
        [248464] = { -- Nimsy
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{41.62,79.9}}},
        },
        [248474] = { -- Geosculptor Yip
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{61.38,48.93}}},
        },
        [251115] = { -- Urs'anah
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.65,26.07}}},
        },
        [251166] = { -- Minor Manifestation of Earth
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.67,23.8}}},
        },
        [251966] = { -- Commander Cyclas
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.39,56.96}}},
        },
        [251261] = { -- Hippogryph Matriarch
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{33.04,54.63},{35.23,54.08}}},
        },
        [251404] = { -- Cirrusfly Queen
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.41,28.53}}},
        },
        [251684] = { -- Strange Hermit
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{53.96,38.9}}},
        },
        [252172] = { -- Danarii Bellowveil
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.24,45.18}}},
        },
        [252476] = { -- Talaanis Shadowsong
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.17,76.51}}},
        },
        [252666] = { -- Commander Belguilos
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.58,65.62}}},
        },
        [252800] = { -- Aamelia Windfield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.7,81.95}}},
        },
        [253204] = { -- Dondallion Whisperwind
            [npcKeys.questEnds_remove] = {92850},
        },
        [253622] = { -- Commander Haalien
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.53,36.32}}},
        },
        [253847] = { -- Elaadrin Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.17,52.57}}},
        },
        [253849] = { -- Ayessa Dawnsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.05,52.63}}},
        },
        [254082] = { -- Aarnor Galestrike
            [npcKeys.questStarts] = {97243},
        },
        [254084] = { -- Elayaa Easewind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.26,44.24}}},
        },
        [254128] = { -- Wardrobe
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.84,53.93}}},
        },
        [254589] = { -- Vulgara the Insatiable
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.66,52.8}}},
        },
        [255013] = { -- DNT KILL CREDIT
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.16,60.59}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255534] = { -- "Badwind" Bennic
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.62,34.27}}},
        },
        [256935] = { -- Malduko Cloudcrush
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.05,33.53}}},
        },
        [257196] = { -- Zaal Stormshield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.05,33.53}}},
        },
        [257446] = { -- Teo Hammerstorm
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.79,66.18}}},
            [npcKeys.questStarts_add] = {94375},
        },
        [257597] = { -- Bruegs Kindleborn
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{87.94,44.8}}},
        },
        [257808] = { -- Braldir Ashmantle
            [npcKeys.spawns] = {[zoneIDs.LOCH_MODAN] = {{32.17,65.97}}},
        },
        [258113] = { -- Ingrid Dunwald
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{47.58,51.95}}},
        },
        [258130] = { -- Jorel Windsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.48,34.74}}},
        },
        [258134] = { -- Jorel Windsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.96,34.95}}},
        },
        [258137] = { -- Telenos Leafwhisper
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.69,35.02}}},
        },
        [258138] = { -- Nayeela Snarlfang
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.52,34.89}}},
        },
        [258275] = { -- Neyasteel Mossmender
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.01,31.96}}},
        },
        [258277] = { -- Bryaes Galechaser
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.43,31.9}}},
        },
        [258288] = { -- Mithraless Sterngale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.8,32.96}}},
        },
        [258289] = { -- Baeo Sharpstrike
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.92,33.55}}},
        },
        [259013] = { -- Resaan Nimbuswalker
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{57.05,29.35}}},
        },
        [263399] = { -- Sam Sarsaparilla
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{44.9,63.36}}},
        },
        [264936] = { -- Earthseer Farsen
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{64.87,58.47}}},
        },
        [268602] = { -- Skypriest Faladiel
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.43,63.71}}},
        },
        [268605] = { -- Kuramaa
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.44,68.75}}},
        },
        [268679] = { -- Brazier of Eternal Flame
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{58.35,78.84}}},
        },
        [268762] = { -- Brazier of Offering
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{51.2,85.9}}},
        },
        [269075] = { -- Snow Leopard Prowler
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{27.37,62.86}}},
        },
        [271546] = { -- Mountaineer Gretchen
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{44.1,57.07}}},
        },
        [271587] = { -- Frosthowl
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{39.33,48.79}}},
        },
        [276009] = { -- Avala
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{58.34,42.06}}},
        },
        [277154] = { -- Kyle the Frenzied
            [npcKeys.name] = "Kyle the Frenzied",
            [npcKeys.minLevelHealth] = 272,
            [npcKeys.maxLevelHealth] = 272,
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.rank] = 0,
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{46.82,63.84}}}, -- TBD
            [npcKeys.waypoints] = nil, -- TBD
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = nil,
            [npcKeys.questEnds] = nil,
            [npcKeys.factionID] = 35,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [277182] = { -- Ahab Wheathoof
            [npcKeys.name] = "Ahab Wheathoof",
            [npcKeys.minLevelHealth] = 4208,
            [npcKeys.maxLevelHealth] = 4208,
            [npcKeys.minLevel] = 62,
            [npcKeys.maxLevel] = 62,
            [npcKeys.rank] = 0,
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{47.28,57.63}}},
            [npcKeys.waypoints] = {},
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {99411},
            [npcKeys.questEnds] = {99411},
            [npcKeys.factionID] = 105,
            [npcKeys.friendlyToFaction] = "H",
            [npcKeys.subName] = "The Old Rancher",
            [npcKeys.npcFlags] = 3,
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverNpcFixes:LoadDynamic()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
    local npcFlags = QuestieDB.npcFlags
    local waypointPresets = QuestieDB.waypointPresets
    local phases = Phasing.phases

    return {
        -- [npcId] = { [npcKeys.name] = "Character-specific name" },
    }
end
