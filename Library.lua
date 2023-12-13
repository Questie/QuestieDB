------------------------------------------------------
--   ____                  _   _      _____  ____
--  / __ \                | | (_)    |  __ \|  _ \
-- | |  | |_   _  ___  ___| |_ _  ___| |  | | |_) |
-- | |  | | | | |/ _ \/ __| __| |/ _ \ |  | |  _ <
-- | |__| | |_| |  __/\__ \ |_| |  __/ |__| | |_) |
--  \___\_\\__,_|\___||___/\__|_|\___|_____/|____/
------------------------------------------------------
--* This file is the main file for the QuestieDB library.
--* It contains the main functions for the library.
--
-- The library is split into two namespaces, Public and Private.
--* The Public namespace is the one that is returned when you call LibQuestieDB()
-- The Private namespace is the one that is used internally in the library.

---@class QuestieDB
---@field public Quest QuestFunctions
---@field public Item ItemFunctions
---@field public Npc NpcFunctions
---@field public Object ObjectFunctions
local PublicLibQuestieDB = {
  Quest = {},
  Item = {},
  Npc = {},
  Object = {},
}

---Get LibQuestieDB
---@return QuestieDB
function LibQuestieDB()
  ---@type QuestieDB
  return setmetatable(PublicLibQuestieDB, {
    __newindex = function(_, _, _)
      error("Attempt to write to a read-only table")
    end
  })
end


---- Private namespace -----

-- The main namespace class for the QuestieDB library.
---@class LibQuestieDB
local PrivateLibQuestieDB = select(2, ...)
-- Set a metatable to create a new table when a key is accessed
---@private
function PrivateLibQuestieDB:initNamespace()
  self = setmetatable(self, {
    ---@generic T
    ---@param key `T`
    ---@return T
    __index = function(s, key)
      print("Missing key", key)
      s[key] = {}
      return s[key]
    end,
    -- __newindex = function(_, _, _)
    --   error("Attempt to write to a read-only table")
    -- end
  })
end
-- Set the metatable to the namespace
PrivateLibQuestieDB:initNamespace()
PrivateLibQuestieDB.initNamespace = nil -- Remove it, no one should be able to change it


PrivateLibQuestieDB.PublicLibQuestieDB = PublicLibQuestieDB


do
  local savedFunction = LibQuestieDB
  C_Timer.NewTimer(1, function()
    if LibQuestieDB ~= savedFunction then
      print("LibQuestieDB was replaced by another addon!")
    end
  end)
end
