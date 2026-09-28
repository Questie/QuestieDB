local _, LibQuestieDB = ...

-- Source separates authored Forever-only NPC corrections into Static and Dynamic tables.
-- Inherited Classic content lives under legacy/ and normally stays unchanged.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.foreverNPCFixes, "duplicate correction provider: foreverNPCFixes")
LibQuestieDB.CorrectionProviders.foreverNPCFixes = providers

---@return table<integer, table> fixes Character-independent NPC corrections.
function providers.Load()
    -- Add character-independent Forever NPC corrections or new entities to this Static table.
    local npcKeys = LibQuestieDB.Meta.Npc.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs
    local npcFlags = LibQuestieDB.Enum.corrections.npcFlags
    local waypointPresets = LibQuestieDB.Enum.waypointPresets
    local phases = LibQuestieDB.Enum.phases

    return {
        -- [npcId] = { [npcKeys.name] = "Corrected name" },
    }
end

---Returns authored Forever Dynamic NPC corrections that depend on faction, class, race, or other character state.
---Add character-dependent rows to this table.
---@return table<integer, table> fixes Character-dependent NPC corrections.
function providers.LoadDynamic()
    local npcKeys = LibQuestieDB.Meta.Npc.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs
    local npcFlags = LibQuestieDB.Enum.corrections.npcFlags
    local waypointPresets = LibQuestieDB.Enum.waypointPresets
    local phases = LibQuestieDB.Enum.phases

    return {
        -- [npcId] = { [npcKeys.name] = "Character-specific name" },
    }
end
