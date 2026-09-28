local _, LibQuestieDB = ...

-- Source separates authored Forever-only item corrections into Static and Dynamic tables.
-- Inherited Classic content lives under legacy/ and normally stays unchanged.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.foreverItemFixes, "duplicate correction provider: foreverItemFixes")
LibQuestieDB.CorrectionProviders.foreverItemFixes = providers

---@return table<integer, table> fixes Character-independent item corrections.
function providers.Load()
    -- Add character-independent Forever item corrections or new entities to this Static table.
    local itemKeys = LibQuestieDB.Meta.Item.keys
    local itemClasses = LibQuestieDB.Enum.itemClasses

    return {
        -- [itemId] = { [itemKeys.name] = "Corrected name" },
    }
end

---Returns authored Forever Dynamic item corrections that depend on faction, class, race, or other character state.
---Add character-dependent rows to this table.
---@return table<integer, table> fixes Character-dependent item corrections.
function providers.LoadDynamic()
    local itemKeys = LibQuestieDB.Meta.Item.keys
    local itemClasses = LibQuestieDB.Enum.itemClasses

    return {
        -- [itemId] = { [itemKeys.name] = "Character-specific name" },
    }
end
