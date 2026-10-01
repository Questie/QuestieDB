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
        [253666] = { -- Flutterfly Swatter
            [itemKeys.name] = "Flutterfly Swatter",
            [itemKeys.class] = itemClasses.QUEST,
        },
        [254871] = { -- Bloody Note
            [itemKeys.name] = "Bloody Note",
            [itemKeys.objectDrops] = {617704},
        },
        [266434] = { -- Resaan's Heirloom
            [itemKeys.name] = "Resaan's Heirloom",
            [itemKeys.npcDrops] = {259013},
        },
        [277329] = { -- Torch of Eternal Flame
            [itemKeys.name] = "Torch of Eternal Flame",
            [itemKeys.class] = itemClasses.QUEST,
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
