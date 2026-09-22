---@class ForeverItemFixes
local ForeverItemFixes = QuestieLoader:CreateModule("ForeverItemFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverItemFixes:Load()
    local itemKeys = QuestieDB.itemKeys
    local itemClasses = QuestieDB.itemClasses

    return {
        -- [itemId] = { [itemKeys.name] = "Corrected name" },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverItemFixes:LoadDynamic()
    local itemKeys = QuestieDB.itemKeys
    local itemClasses = QuestieDB.itemClasses

    return {
        [270302] = {
            [itemKeys.name] = "Chakuyak's Pelt",
            [itemKeys.npcDrops] = {268558},
            [itemKeys.objectDrops] = nil,
            [itemKeys.itemDrops] = nil,
            [itemKeys.vendors] = nil,
            [itemKeys.startQuest] = nil,
        },
        [275019] = {
            [itemKeys.name] = "Supply Bundle",
            [itemKeys.npcDrops] = nil,
            [itemKeys.objectDrops] = nil,
            [itemKeys.itemDrops] = nil,
            [itemKeys.vendors] = nil,
            [itemKeys.startQuest] = nil,
        },
        [277199] = {
            [itemKeys.name] = "Pouch of Smoldering Incense",
            [itemKeys.npcDrops] = nil,
            [itemKeys.objectDrops] = nil,
            [itemKeys.itemDrops] = nil,
            [itemKeys.vendors] = nil,
            [itemKeys.startQuest] = nil,
        },
    }
end
