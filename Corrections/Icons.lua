---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Extend Module --------

---@class Corrections
local Corrections = LibQuestieDB.Corrections

--- This is a manual copy of the Icons from Questie.
--- See https://github.com/Questie/Questie/blob/master/Questie.lua#L208
---@class QuestieIcons
local QuestieLocalTable = {
  ICON_TYPE_SLAY = 1,
  ICON_TYPE_LOOT = 2,
  ICON_TYPE_EVENT = 3,
  ICON_TYPE_OBJECT = 4,
  ICON_TYPE_TALK = 5,
  ICON_TYPE_AVAILABLE = 6,
  ICON_TYPE_AVAILABLE_GRAY = 7,
  ICON_TYPE_COMPLETE = 8,
  ICON_TYPE_GLOW = 9,
  ICON_TYPE_REPEATABLE = 10,
  ICON_TYPE_REPEATABLE_COMPLETE = 11,
  ICON_TYPE_INCOMPLETE = 12,
  ICON_TYPE_EVENTQUEST = 13,
  ICON_TYPE_EVENTQUEST_COMPLETE = 14,
  ICON_TYPE_PVPQUEST = 15,
  ICON_TYPE_PVPQUEST_COMPLETE = 16,
  ICON_TYPE_INTERACT = 17,
  ICON_TYPE_SODRUNE = 18,
  ICON_TYPE_MOUNT_UP = 19,
  ICON_TYPE_NODE_FISH = 20,
  ICON_TYPE_NODE_HERB = 21,
  ICON_TYPE_NODE_ORE = 22,
  ICON_TYPE_CHEST = 23,
}

---@type QuestieIcons
local Icons = setmetatable({}, {
  __index = function(t, k)
    if type(k) ~= "string" then
      return nil -- Only allow string keys
    end

    -- Check if the value is already cached
    if t[k] ~= nil then
      return t[k]
    end

    -- Try fetching from the Questie global object first
    ---@diagnostic disable-next-line: undefined-global
    if Questie and Questie[k] and type(Questie[k]) == "number" then
      ---@diagnostic disable-next-line: undefined-global
      local valueFromQuestie = Questie[k]
      t[k] = valueFromQuestie -- Cache the value
      return valueFromQuestie
    end

    -- If not found in Questie, try fetching from QuestieLocalTable
    local valueFromLocalTable = QuestieLocalTable[k]
    if valueFromLocalTable ~= nil then
      t[k] = valueFromLocalTable -- Cache the value
      return valueFromLocalTable
    end

    -- If not found in either source, return nil
    return nil
  end,
})


Corrections.Icons = Icons
