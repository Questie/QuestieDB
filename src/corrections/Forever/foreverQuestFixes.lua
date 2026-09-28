local _, LibQuestieDB = ...

-- Source separates authored Forever-only quest corrections into Static and Dynamic tables.
-- Inherited Classic content lives under legacy/ and normally stays unchanged.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.foreverQuestFixes, "duplicate correction provider: foreverQuestFixes")
LibQuestieDB.CorrectionProviders.foreverQuestFixes = providers

---@return table<integer, table> fixes Character-independent quest corrections.
function providers.Load()
    -- Add character-independent Forever quest corrections or new entities to this Static table.
    local questKeys = LibQuestieDB.Meta.Quest.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs
    local raceIDs = LibQuestieDB.Enum.corrections.raceKeys
    local classIDs = LibQuestieDB.Enum.corrections.classKeys
    local sortKeys = LibQuestieDB.Enum.sortKeys
    local specialFlags = LibQuestieDB.Enum.specialFlags
    local profKeys = LibQuestieDB.Enum.professionKeys
    local specKeys = LibQuestieDB.Enum.specializationKeys
    local factionIDs = LibQuestieDB.Enum.factionIDs
    local rankKeys = LibQuestieDB.Enum.rankNames

    return {
        -- [questId] = { [questKeys.name] = "Corrected name" },
    }
end

---Returns authored Forever Dynamic quest corrections that depend on faction, class, race, or other character state.
---Add character-dependent rows to this table.
---@return table<integer, table> fixes Character-dependent quest corrections.
function providers.LoadDynamic()
    local questKeys = LibQuestieDB.Meta.Quest.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs
    local raceIDs = LibQuestieDB.Enum.corrections.raceKeys
    local classIDs = LibQuestieDB.Enum.corrections.classKeys
    local sortKeys = LibQuestieDB.Enum.sortKeys
    local specialFlags = LibQuestieDB.Enum.specialFlags
    local profKeys = LibQuestieDB.Enum.professionKeys
    local specKeys = LibQuestieDB.Enum.specializationKeys
    local factionIDs = LibQuestieDB.Enum.factionIDs
    local rankKeys = LibQuestieDB.Enum.rankNames
    local playerClass = UnitClassBase("player")

    return {
        -- [questId] = { [questKeys.name] = "Character-specific name" },
    }
end
