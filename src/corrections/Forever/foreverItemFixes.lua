---@class ForeverItemFixes
local ForeverItemFixes = QuestieLoader:CreateModule("ForeverItemFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverItemFixes:Load()
    local itemKeys = QuestieDB.itemKeys
    local itemClasses = QuestieDB.itemClasses

    return {
        [750] = { -- Tough Wolf Meat
            [itemKeys.npcDrops_remove] = {238425,238426,238427,247809},
        },
        [780] = { -- Torn Murloc Fin
            [itemKeys.npcDrops_remove] = {202060},
        },
        [5220] = { -- Gnarlpine Fang
            [itemKeys.npcDrops] = {2006,2007,2008,2009,2010,2011,2012,2013,2014,2152,7235,14428,14429},
        },
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
        [281030] = { -- Treaty of Understanding
            [itemKeys.objectDrops] = {673474},
        },
        [285356] = { -- Advisor Emerson's Instructions
            [itemKeys.name] = "Advisor Emerson's Instructions",
            [itemKeys.npcDrops] = {275491},
        },
        [285357] = { -- Advisor Nazgrel's Instructions
            [itemKeys.name] = "Advisor Nazgrel's Instructions",
            [itemKeys.npcDrops] = {3230},
        },
        [287505] = { -- Tender Strider Meat
            [itemKeys.name] = "Tender Strider Meat",
            [itemKeys.npcDrops] = {2956,2957,3068},
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
