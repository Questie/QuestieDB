---@class LibQuestieDB
---@field Meta Meta
local LibQuestieDB = select(2, ...)

---@class Meta
local Meta = LibQuestieDB.Meta


---Create a shallow copy of the given keys table.
---Used to make a copy of the keys table to avoid modifying the original.
---@generic T
---@param keys T
---@return T
function Meta.CloneKeys(keys)
  local DBKeys = {}
  for k, v in pairs(keys) do
    DBKeys[k] = v
  end
  return DBKeys
end
