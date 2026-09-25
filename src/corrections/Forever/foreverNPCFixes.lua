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
        [265810] = {
            [npcKeys.name] = "Kaga Wildhoof",
            [npcKeys.minLevel] = 0,
            [npcKeys.maxLevel] = 0,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.spawns] = {
                [zoneIDs.MULGORE] = {{46.2, 67.2}},
            },
            [npcKeys.friendlyToFaction] = nil,
            [npcKeys.questStarts] = nil,
            [npcKeys.questEnds] = {96659},
        },
        [268558] = {
            [npcKeys.name] = "Chakuyak",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.spawns] = {
                [zoneIDs.MULGORE] = {{39.5,66.2}},
            },
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
        -- [npcId] = { [npcKeys.name] = "Corrected name" },
    }
end
