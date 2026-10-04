---@class ForeverItemFixes
local ForeverItemFixes = QuestieLoader:CreateModule("ForeverItemFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverItemFixes:Load()
    local itemKeys = QuestieDB.itemKeys
    local itemClasses = QuestieDB.itemClasses

    return {
        [6889] = { -- Small Egg
            [itemKeys.npcDrops_add] = {251261,251284,251291},
        },
        [14395] = { -- Spells of Shadow
            [itemKeys.npcDrops_remove] = {238461},
        },
        [14396] = { -- Incantations from the Nether
            [itemKeys.npcDrops_remove] = {238461},
        },
        [252760] = { -- Stolen Shen'dar Supplies
            [itemKeys.npcDrops] = {252068,254596,259385,259398},
        },
        [254871] = { -- Bloody Note
            [itemKeys.objectDrops] = {617704},
        },
        [257945] = { -- Pilfered Windstone
            [itemKeys.npcDrops] = {251918,255534},
        },
        [285356] = { -- Advisor Emerson's Instructions
            [itemKeys.name] = "Advisor Emerson's Instructions",
            [itemKeys.npcDrops] = {275491},
        },
        [285357] = { -- Advisor Nazgrel's Instructions
            [itemKeys.name] = "Advisor Nazgrel's Instructions",
            [itemKeys.npcDrops] = {3230},
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverItemFixes:LoadDynamic()
    local itemKeys = QuestieDB.itemKeys
    local itemClasses = QuestieDB.itemClasses

    return {
        -- [itemId] = { [itemKeys.name] = "Character-specific name" },
    }
end
