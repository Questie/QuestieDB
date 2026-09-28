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
        -- For MoP fixes 450001-459999
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
