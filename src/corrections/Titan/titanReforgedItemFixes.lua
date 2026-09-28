local _, LibQuestieDB = ...
if not LibQuestieDB.IsCorrectionProviderActive("titanReforgedItemFixes") then return end

-- Native Titan Reforged item provider.
-- The central manifest owns classification and execution order; this module publishes the native provider table.
-- Dynamic additions and inherited-data overrides stay separate; these loaders do not inspect character state.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.titanReforgedItemFixes, "duplicate correction provider: titanReforgedItemFixes")
LibQuestieDB.CorrectionProviders.titanReforgedItemFixes = providers

---Returns Titan Reforged item additions and relationship corrections.
---@return table<integer, table> rows Seasonal item rows.
function providers.LoadItems()
    local itemKeys = LibQuestieDB.Meta.Item.keys
    local itemClasses = LibQuestieDB.Enum.itemClasses

    return {
        [264272] = { -- Celestial Missive
            [itemKeys.name] = "Celestial Missive",
            [itemKeys.relatedQuests] = {94376},
            [itemKeys.class] = itemClasses.QUEST,
        },
        [268145] = { -- Punctured Voodoo Doll
            [itemKeys.name] = "Punctured Voodoo Doll",
            [itemKeys.class] = itemClasses.QUEST,
            [itemKeys.itemLevel] = 1,
            [itemKeys.flags] = 33792,
        },
        [272955] = { -- Eredar Heart
            [itemKeys.name] = "Eredar Heart",
            [itemKeys.npcDrops] = {34780},
            [itemKeys.class] = itemClasses.QUEST,
            [itemKeys.relatedQuests] = {96211},
            [itemKeys.startQuest] = 96211,
        },
        [274994] = { -- Primal Hakkari Idol
            [itemKeys.name] = "Primal Hakkari Idol",
            [itemKeys.class] = 15,
            [itemKeys.requiredLevel] = 80,
        },
        [279578] = { -- Empowered Zandalari Bijou
            [itemKeys.name] = "Empowered Zandalari Bijou",
            [itemKeys.class] = itemClasses.QUEST,
            [itemKeys.requiredLevel] = 80,
        },
    }
end

---Returns Titan Reforged overrides for inherited WotLK items.
---@return table<integer, table> overrides Inherited-item overrides.
function providers.LoadItemOverrides()
    local itemKeys = LibQuestieDB.Meta.Item.keys

    return {
        [22734] = { -- Base of Atiesh
            [itemKeys.npcDrops] = {15172},
        },
    }
end
