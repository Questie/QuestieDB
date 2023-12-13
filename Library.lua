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
PrivateLibQuestieDB.PublicLibQuestieDB = PublicLibQuestieDB

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

do
  local savedFunction = LibQuestieDB
  C_Timer.NewTimer(1, function()
    if LibQuestieDB ~= savedFunction then
      print("LibQuestieDB was replaced by another addon!")
    end
  end)
end
