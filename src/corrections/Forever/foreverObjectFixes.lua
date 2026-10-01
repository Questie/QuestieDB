---@class ForeverObjectFixes
local ForeverObjectFixes = QuestieLoader:CreateModule("ForeverObjectFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverObjectFixes:Load()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs

    return {
        [576179] = { -- Supply Cache
            [objectKeys.name] = "Supply Cache",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.5,55.8},{49.0,53.6},{49.4,57.1},{49.5,54.8},{49.8,57.3},{49.9,56.0}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578937] = { -- Ripe Stormapple
            [objectKeys.name] = "Ripe Stormapple",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.2,78.4},{46.3,79.2},{46.4,80.2},{46.5,78.4},{46.5,78.5},{46.6,80.3},{46.6,80.7},{47.4,83.1},{47.6,83.6},{48.0,83.0},{48.7,83.6},{48.8,83.2},{48.8,84.5}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578959] = { -- Flutterfly Dust
            [objectKeys.name] = "Flutterfly Dust",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.9,76.9},{47.8,76.4},{47.8,76.5},{48.0,79.5},{48.2,78.4},{48.2,78.5},{48.4,73.7},{48.7,75.5},{48.7,79.1},{48.8,75.4},{48.9,82.0},{49.3,74.1},{49.6,77.3},{50.0,75.2},{50.0,81.1},{50.3,72.5},{50.3,73.5},{50.3,79.7},{50.4,77.6},{50.4,82.4},{50.4,82.5},{50.5,77.5},{50.5,79.6},{50.5,82.6},{50.8,80.9},{51.1,83.5},{51.2,81.8},{51.4,76.0},{51.4,77.0},{51.5,75.9},{51.5,77.1},{51.8,83.4},{51.8,83.5},{51.9,82.1},{52.7,79.4},{52.8,79.7},{53.6,81.8},{54.5,80.0}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [586726] = { -- Portal To Rohashi Spires
            [objectKeys.name] = "Portal To Rohashi Spires",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.55,50.33}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [613286] = { -- Raw Windstone
            [objectKeys.name] = "Raw Windstone",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.8,30.77},{39.31,27.71},{38.28,29.99},{38.55,34.39},{40.38,30.47},{42.87,28.75},{45.33,29.14},{44.27,27.28},{41.51,26.94},{43.82,25.43},{44.23,24.95},{43.48,23.85},{42.82,22.27},{41.92,23.71},{44.17,22.29},{44.98,19.78},{46.59,17.83},{48.28,19.05},{46.94,20.9},{47.19,23.55},{46.61,24.6},{49.92,24.2},{48.29,25.67},{47.4,26.43},{46.76,27.94},{48.13,29.3},{46.62,31.21}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616466] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.4,46.0},{49.6,45.9},{50.0,44.8},{50.7,44.3},{50.7,44.5},{51.6,46.6},{52.4,45.8},{52.5,45.8},{52.8,49.7},{52.9,51.7},{53.1,47.7},{53.1,51.4},{53.5,50.4},{53.6,50.5}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616467] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.3,74.5},{43.9,75.4},{43.9,75.5},{44.7,73.4},{44.8,74.2},{44.8,76.7}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616468] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{51.4,67.5},{51.5,67.6},{51.9,65.6},{51.9,67.1},{52.8,64.8},{52.9,66.1}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617674] = { -- Arvensus Shadowsong
            [objectKeys.name] = "Arvensus Shadowsong",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{40.98,64.09}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617675] = { -- Raani Windgazer
            [objectKeys.name] = "Raani Windgazer",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{41.13,64.07}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617704] = { -- Bloody Note
            [objectKeys.name] = "Bloody Note",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.37,62.07}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617839] = { -- Hippogryph Down
            [objectKeys.name] = "Hippogryph Down",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.63,59.11},{33.19,54.37},{33.99,55.29},{35.11,54.07},{35.79,55.33},{36.02,54.29},{36.75,54.67},{36.84,53.31},{36.82,52.45},{36.03,52},{36.5,50.88},{37.19,51.2},{37.84,51.04}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [623295] = { -- Abandonded Belongings
            [objectKeys.name] = "Abandonded Belongings",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.9,29.4},{56.9,33.6},{57.0,33.4},{57.6,31.0},{57.6,32.1},{57.9,26.9},{58.4,32.7},{58.8,31.1},{59.1,32.3},{59.1,34.7},{59.2,33.8}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [660848] = { -- Kuramaa's Stump
            [objectKeys.name] = "Kuramaa's Stump",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.35,68.82}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        -- For Forever fixes 450001-459999
        [450001] = { -- Elemental Convergence
            [objectKeys.name] = "Elemental Convergence",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.28,20.62}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [450002] = { -- Ley Line
            [objectKeys.name] = "Ley Line",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.28,20.62}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [450003] = { -- Basic Campfire
            [objectKeys.name] = "Basic Campfire",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{41.73,44.78}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverObjectFixes:LoadDynamic()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs

    return {
        -- [objectId] = { [objectKeys.name] = "Character-specific name" },
    }
end
