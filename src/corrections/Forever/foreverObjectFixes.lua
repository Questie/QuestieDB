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
        [613286] = { -- Raw Windstone
            [objectKeys.name] = "Raw Windstone",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.8,30.77},{39.31,27.71},{38.28,29.99},{38.55,34.39},{40.38,30.47},{42.87,28.75},{45.33,29.14},{44.27,27.28},{41.51,26.94},{43.82,25.43},{44.23,24.95},{43.48,23.85},{42.82,22.27},{41.92,23.71},{44.17,22.29},{44.98,19.78},{46.59,17.83},{48.28,19.05},{46.94,20.9},{47.19,23.55},{46.61,24.6},{49.92,24.2},{48.29,25.67},{47.4,26.43},{46.76,27.94},{48.13,29.3},{46.62,31.21}}},
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
