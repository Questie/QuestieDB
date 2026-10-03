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
        [4949] = { -- Thrall
            [npcKeys.questEnds_add] = {93739},
        },
        [14242] = { -- Sulhasa
            [npcKeys.name] = "Sulhasa",
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
        [252476] = { -- Talaanis Shadowsong
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.17,76.51}}},
        },
        [252800] = { -- Aamelia Windfield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.7,81.95}}},
        },
        [253622] = { -- Commander Haalien
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.53,36.32}}},
        },
        [253849] = { -- Ayessa Dawnsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.05,52.63}}},
        },
        [254128] = { -- Wardrobe
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.84,53.93}}},
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
        [252666] = { -- Commander Belguilos
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.58,65.62}}},
        },
        [253847] = { -- Elaadrin Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.17,52.57}}},
        },
        [254082] = { -- Aarnor Galestrike
            [npcKeys.questStarts] = {97243},
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
