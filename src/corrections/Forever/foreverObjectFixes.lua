local _, LibQuestieDB = ...

-- Source separates authored Forever-only object corrections into Static and Dynamic tables.
-- Inherited Classic content lives under legacy/ and normally stays unchanged.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.foreverObjectFixes, "duplicate correction provider: foreverObjectFixes")
LibQuestieDB.CorrectionProviders.foreverObjectFixes = providers

---@return table<integer, table> fixes Character-independent object corrections.
function providers.Load()
    -- Add character-independent Forever object corrections or new entities to this Static table.
    local objectKeys = LibQuestieDB.Meta.Object.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs

    return {
        -- [objectId] = { [objectKeys.name] = "Corrected name" },
    }
end

---Returns authored Forever Dynamic object corrections that depend on faction, class, race, or other character state.
---Add character-dependent rows to this table.
---@return table<integer, table> fixes Character-dependent object corrections.
function providers.LoadDynamic()
    local objectKeys = LibQuestieDB.Meta.Object.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs

    return {
        -- [objectId] = { [objectKeys.name] = "Character-specific name" },
    }
end
