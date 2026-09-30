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
        [251115] = { -- Urs'anah
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.65,26.07}}},
        },
        [251166] = { -- Minor Manifestation of Earth
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.67,23.8}}},
        },
        [252476] = { -- Talaanis Shadowsong
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.17,76.51}}},
        },
        [252800] = { -- Aamelia Windfield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.7,81.95}}},
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
        [254082] = { -- Aarnor Galestrike
            [npcKeys.questStarts] = {97243},
        },
        [255013] = { -- DNT KILL CREDIT
            [npcKeys.name] = "DNT KILL CREDIT",
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.16,60.59}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255534] = { -- "Badwind" Bennic
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.62,34.27}}},
        },
        [256935] = { -- Malduko Cloudcrush
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.05,33.53}}},
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
