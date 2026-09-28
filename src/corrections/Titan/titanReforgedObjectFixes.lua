local _, LibQuestieDB = ...
if not LibQuestieDB.IsCorrectionProviderActive("titanReforgedObjectFixes") then return end

-- Native Titan Reforged object provider.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
-- Manifest Dynamic data can correct inherited rows or add entities without inspecting character state.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.titanReforgedObjectFixes, "duplicate correction provider: titanReforgedObjectFixes")
LibQuestieDB.CorrectionProviders.titanReforgedObjectFixes = providers

---Returns Titan Reforged object additions and corrections.
---@return table<integer, table> rows Seasonal object rows.
function providers.LoadObjects()
    local objectKeys = LibQuestieDB.Meta.Object.keys
    local zoneIDs = LibQuestieDB.Enum.zoneIDs

    return {
        [420002] = { -- Blood Ritual Altar
            [objectKeys.name] = "Blood Ritual Altar",
            [objectKeys.spawns] = {[zoneIDs.ZUL_GURUB] = {{-1,-1}}},
            [objectKeys.zoneID] = zoneIDs.ZUL_GURUB,
        },
    }
end
